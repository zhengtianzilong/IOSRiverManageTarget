//
//  ACMediaManager.m
//
//  Version: 2.0.4.
//  Created by ArthurCao<https://github.com/honeycao> on 2016/12/22.
//  Update: 2017/12/27.
//

#import "ACMediaManager.h"
#import "ACMediaFrameConst.h"
#import <AssetsLibrary/ALAssetsLibrary.h>

@interface ACMediaManager ()<UITextViewDelegate>
@property (nonatomic, strong) NSData * CompressData;

@end

@implementation ACMediaManager

+ (instancetype)manager
{
    static ACMediaManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[ACMediaManager alloc] init];
    });
    return shareInstance;
}

#pragma mark - public

- (void)getImageInfoFromImage: (UIImage *)image PHAsset: (PHAsset *)asset completion: (void(^)(NSString *name, NSData *data))completion {
    //图片名
    NSString *imageName = [self getMediaNameWithPHAsset:asset extensionName:@"IMG.PNG"];
    NSData *imageData;
    if (UIImagePNGRepresentation(image) == nil)
    {
        imageData = UIImageJPEGRepresentation(image, 1);
    } else
    {
        imageData = UIImagePNGRepresentation(image);
    }
    !completion ?  : completion(imageName, imageData);
}

- (void)getVideoPathFromURL: (NSURL *)videoURL PHAsset: (PHAsset *)asset enableSave: (BOOL)enableSave completion: (void(^)(NSString *name, UIImage *screenshot, id pathData))completion {
    //视频名
    NSString *fileName = [self getMediaNameWithPHAsset:asset extensionName:@"Video.mov"];
    //视频本地路径
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingString:fileName];
    //data视频
    NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
    //视频封面
    UIImage *screenshot = [self imageWithVideoURL:videoURL enableSave:NO];
    
    [self mov2mp4:videoURL isSelectOrCamera:YES completion:^(NSData *data , NSString *fileName) {
        
        !completion ?  : completion(fileName, screenshot, data);
        
    }];
    
//    //判断本地是否有
//    BOOL success = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
//    //本地不存在的情况
//    if (!success) {
//        if (enableSave) {
//            //写入本地，成功之后返回路径
//            [videoData writeToFile:filePath atomically:YES];
//            success = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
//            if (success) {
////                !completion ?  :completion(fileName, screenshot, filePath);
//                !completion ?  :completion(fileName, screenshot, videoData);
//            }
//        }else{
//            //不保存，那么就只有返回NSData
//            !completion ?  : completion(fileName, screenshot, videoData);
//        }
//    }else {
//        //本地存在，那么就是本地视频，直接返回路径
////        !completion ?  : completion(fileName, screenshot, filePath);
//        !completion ?  : completion(fileName, screenshot, videoData);
//    }
}

- (void)mov2mp4:(NSURL *)movUrl isSelectOrCamera:(BOOL)isSelectOrCamera completion: (void(^)(NSData *data, NSString *fileName))completion
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    /**
     AVAssetExportPresetMediumQuality 表示视频的转换质量，
     */
    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
        
        //转换完成保存的文件路径
        NSString * resultPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4",nowTimeStr];
        
        NSString *fileName = [NSString stringWithFormat:@"output-%@.mp4",nowTimeStr];
        
        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
        
        //要转换的格式，这里使用 MP4
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        //转换的数据是否对网络使用优化
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        //异步处理开始转换
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         
         {
             //转换状态监控
             switch (exportSession.status) {
                 case AVAssetExportSessionStatusUnknown:
                     NSLog(@"AVAssetExportSessionStatusUnknown");
                     break;
                     
                 case AVAssetExportSessionStatusWaiting:
                     NSLog(@"AVAssetExportSessionStatusWaiting");
                     break;
                     
                 case AVAssetExportSessionStatusExporting:
                     NSLog(@"AVAssetExportSessionStatusExporting");
                     break;
                 case AVAssetExportSessionStatusFailed:
                     NSLog(@"AVAssetExportSessionStatusFailed");
                     break;
                 case AVAssetExportSessionStatusCancelled:
                     NSLog(@"AVAssetExportSessionStatusCancelled");
                     break;
                     
                 case AVAssetExportSessionStatusCompleted:
                 {
                     //转换完成
                     NSLog(@"AVAssetExportSessionStatusCompleted");
                     _CompressData = [NSData dataWithContentsOfURL:exportSession.outputURL];
                     
                     if (isSelectOrCamera) {
                         //测试使用，保存在手机相册里面
                         ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
                         [assetLibrary writeVideoAtPathToSavedPhotosAlbum:exportSession.outputURL completionBlock:^(NSURL *assetURL, NSError *error){
                             if (error) {

                                 NSLog(@"%@",error);
                             }
                         }];
                         
                     }
                     
                    
                     
                     completion(_CompressData, fileName);
                     
                     break;
                 }
             }
             
         }];
        
    }
    
}







- (void)getMediaInfoFromAsset: (PHAsset *)asset completion: (void(^)(NSString *name, id pathData))completion {
    if (!asset) {
        return;
    }
    NSString *mediaName;
    __block NSData *data;
    
    if (asset.mediaType == PHAssetMediaTypeImage) {
        //图片文件名
        mediaName = [self getMediaNameWithPHAsset:asset extensionName:@"Image.png"];
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        //返回图片的质量类型 （效率高，质量低）
        options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
        //同步请求获取iCloud图片（默认为NO）
        //options.synchronous = YES;
        
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            data = [NSData dataWithData:imageData];
            
            if (completion && data.length > 0) {
                completion(mediaName, data);
            }
        }];
    }
    else if (asset.mediaType == PHAssetMediaTypeVideo ||
             asset.mediaSubtypes == PHAssetMediaSubtypePhotoLive) {
        //视频文件名
        mediaName = [self getMediaNameWithPHAsset:asset extensionName:@"IMG.MOV"];
        //从PHAsset获取相册中视频的url
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            AVURLAsset *urlAsset = (AVURLAsset *)asset;
            
            NSURL *url = urlAsset.URL;
            
            [self mov2mp4:url isSelectOrCamera:NO completion:^(NSData *data , NSString *fileName) {
                
                !completion ?  : completion(fileName, data);
                
            }];
            
//            NSData *videoData = [NSData dataWithContentsOfURL:url];
            
            
            NSLog(@"%@",url);
        }];
        
//        NSString *videoPath = [NSTemporaryDirectory() stringByAppendingString:mediaName];
//        BOOL success = [[NSFileManager defaultManager] fileExistsAtPath:videoPath];
//        //当前处理方式：本地的视频 直接返回路径，非本地的也不存储到本地，直接返回data
//        if (success) {
//            !completion ?  : completion(mediaName, videoPath);
//        }else{
//            NSData *videoData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:videoPath]];
//            !completion ?  : completion(mediaName, videoData);
//        }
    }
}

#pragma mark - privary methods

/**
 获取媒体文件名称

 @param asset     PHAsset对象
 @param extension 媒体文件的拓展名（.PNG等）
 @return asset为nil时，返回默认自定义时间(按时间命名)，不为nil则返回原图名称
 */
- (NSString *)getMediaNameWithPHAsset: (PHAsset *)asset extensionName: (NSString *)extension {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *mediaName;
    //空的情况，返回自定义名称（按时间命名）
    if (!asset) {
        mediaName = [formatter stringFromDate:date];
        return [NSString stringWithFormat:@"%@%@",mediaName,extension];
    }
    PHAssetResource *resource = [[PHAssetResource assetResourcesForAsset:asset] firstObject];
    //获取本地原图的名称
    if (resource.originalFilename) {
        mediaName = resource.originalFilename;
    }else {
        mediaName = [NSString stringWithFormat:@"%@%@",[formatter stringFromDate:date],extension];
    }
    return mediaName;
}

/**
 根据视频的URL来获取视频封面截图
 
 @param videoURL 视频URL
 @param enableSave 是否将封面截图保存到本地
 @return 返回封面截图
 */
- (UIImage *)imageWithVideoURL: (NSURL *)videoURL enableSave: (BOOL)enableSave {
    
    //1、根据视频URL创建 AVURLAsset
    AVURLAsset *urlAsset = [AVURLAsset assetWithURL:videoURL];
    
    //2、根据 AVURLAsset 创建 AVAssetImageGenerator对象
    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    
    //3、定义获取0帧处的视频截图
    CMTime time = CMTimeMake(1,10);//缩略图创建时间 CMTime是表示电影时间信息的结构体，第一个参数表示是视频第几秒，第二个参数表示每秒帧数.(如果要活的某一秒的第几帧可以使用CMTimeMake方法)
    NSError *error = nil;
    CMTime actucalTime; //缩略图实际生成的时间
    
    //4、获取time处的视频截图
    CGImageRef cgImage = [imageGenerator copyCGImageAtTime:time actualTime:&actucalTime error:&error];
    if (error) {
//        NSLog(@"截取视频图片失败:%@",error.localizedDescription);
    }
    
    //5、将 CGImageRef 转化为 UIImage
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    //6、将其存储到本地相册
    if (enableSave) {
        UIImageWriteToSavedPhotosAlbum(image,nil, nil,nil);
    }
    CGImageRelease(cgImage);
    return image;
}

@end
