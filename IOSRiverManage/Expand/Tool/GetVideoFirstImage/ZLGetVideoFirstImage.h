//
//  ZLGetVideoFirstImage.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/6/8.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLGetVideoFirstImage : NSObject

@property (nonatomic, strong) UIImage *image;

+(instancetype)sharedManager;

- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

@end
