//
//  ZLNewFilesUpLoadService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewFilesUpLoadService.h"
@interface ZLNewFilesUpLoadService (){
    NSArray<ACMediaModel *>  *_imageArray;
    NSString *_name;
    NSData *_data;
    
}

@end
@implementation ZLNewFilesUpLoadService

- (instancetype)initWithImage:(NSArray<ACMediaModel *> *)imageArray{
    self = [super init];
    if (self) {
        _imageArray = imageArray;
    }
    return self;
}

- (NSString *)requestUrl {
    return River_BatchUploadUrl;
}


- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}


- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}


- (AFConstructingBlock)constructingBodyBlock {
    
    return ^(id<AFMultipartFormData> formData)
    {
        
        for (ACMediaModel *model in _imageArray) {
            NSData *imageDataW = nil;
            
            if (model) {
                
                if (!model.isVideo) {
                    if ([self getHEFIWith:model.asset]) {
                        NSArray *nameArray = [model.name componentsSeparatedByString:@"."];
                        model.name = [NSString stringWithFormat:@"%@.jpg",nameArray.firstObject];
                    }
                    
                    imageDataW = UIImageJPEGRepresentation(model.image, 0.8);
                    NSData *data = imageDataW;
                    NSString *name = model.name;
                    NSString *formKey = @"file";
                    NSString *type = @"image/jpeg";
                    [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
                }else{
                    
                    NSData *data = (NSData *)model.uploadType;
                    NSString *name = model.name;
                    NSString *formKey = @"file";
                    NSString *type = @"video/mov";
                    [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
                }
                

            }
            

        }

    };
}

//// 将原始视频的URL转化为NSData数据,写入沙盒
//- (void)videoWithUrl:(NSURL *)url withFileName:(NSString *)fileName
//{
//    // 解析一下,为什么视频不像图片一样一次性开辟本身大小的内存写入?
//    // 想想,如果1个视频有1G多,难道直接开辟1G多的空间大小来写?
//    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        if (url) {
//            [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
//                ALAssetRepresentation *rep = [asset defaultRepresentation];
//                NSString * videoPath = [KCachesPath stringByAppendingPathComponent:fileName];
//                char constconst *cvideoPath = [videoPath UTF8String];
//                FILEFILE *file = fopen(cvideoPath, "a+");
//                if (file) {
//                    const int bufferSize = 11024 * 1024;
//                    // 初始化一个1M的buffer
//                    Byte *buffer = (Byte*)malloc(bufferSize);
//                    NSUInteger read = 0, offset = 0, written = 0;
//                    NSError* err = nil;
//                    if (rep.size != 0)
//                    {
//                        do {
//                            read = [rep getBytes:buffer fromOffset:offset length:bufferSize error:&err];
//                            written = fwrite(buffer, sizeof(char), read, file);
//                            offset += read;
//                        } while (read != 0 && !err);//没到结尾，没出错，ok继续
//                    }
//                    // 释放缓冲区，关闭文件
//                    free(buffer);
//                    buffer = NULL;
//                    fclose(file);
//                    file = NULL;
//                }
//            } failureBlock:nil];
//        }
//    });
//}




- (BOOL)getHEFIWith:(PHAsset *)phAsset{
    __block BOOL isHEIF = NO;
    if (isIOS9) {
        
        
        NSArray *resourceList = [PHAssetResource assetResourcesForAsset:phAsset];
        [resourceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PHAssetResource *resource = obj;
            NSString *UTI = resource.uniformTypeIdentifier;
            if ([UTI isEqualToString:@"public.heif"] || [UTI isEqualToString:@"public.heic"]) {
                isHEIF = YES;
                *stop = YES;
            }
        }];
    } else {
        NSString *UTI = [phAsset valueForKey:@"uniformTypeIdentifier"];
        isHEIF = [UTI isEqualToString:@"public.heif"] || [UTI isEqualToString:@"public.heic"];
    }
    return isHEIF;
}

@end
