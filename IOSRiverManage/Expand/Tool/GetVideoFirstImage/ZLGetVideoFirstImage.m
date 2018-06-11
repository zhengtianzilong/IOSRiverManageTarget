//
//  ZLGetVideoFirstImage.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/6/8.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLGetVideoFirstImage.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVAsset.h>
@implementation ZLGetVideoFirstImage
+(instancetype)sharedManager{
    
    static ZLGetVideoFirstImage *firstImage = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        firstImage = [[ZLGetVideoFirstImage alloc]init];
        
        
    });
    
    return firstImage;
    
}

- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode =AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage:thumbnailImageRef] : [UIImage imageNamed:@"event_placeImage"];
    
    return thumbnailImage;
}


@end
