//
//  ZLUtility.h
//  HongZeHaiShi
//
//  Created by 蔡紫龙 on 2018/1/26.
//  Copyright © 2018年 xgzl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLUtility : NSObject

//单例
+ (instancetype)instance;

#pragma mark - 时间

/**
 获取当前时间的时间戳(秒)
 */
+ (long long)getNowTimestampSec;

/**
 获取当前时间的时间戳(毫秒)
 */
+ (long long)getNowTimestampMesc;

/**
 获取当前时间的时间戳字符串(秒)
 */
+ (NSString *)getNowTimestampString;

/**
 将秒数转换成时分秒

 @param seconds 秒数
 @return 时分秒
 */
+ (NSString *)getHMSFormatBySeconds:(int)seconds;

#pragma mark - 时间戳与日期的相互转换
/**
 时间戳转日期

 @param timestamp 时间戳
 @param timeType 时间格式
 @return 时间
 */
+ (NSString *)getDateByTimestamp:(long long)timestamp type:(NSInteger)timeType;

/**
 日期转时间戳

 @param dateString 日期
 @param timeType 格式
 @return 时间戳
 */
+ (NSInteger)getTimestampByDate:(NSString *)dateString type:(NSInteger)timeType;


#pragma mark - 文件路径
+ (NSString *)getDocDir;
+ (NSString *)getVideoDir;
+ (NSString *)getAudioDir;
+ (NSString *)getAudioFilePath;
+ (NSString *)getTempPicDir;

#pragma mark - 权限
+ (BOOL)isAudioRecordPermit;
+ (BOOL)isPhotoLibraryPermit;
+ (BOOL)isCameraPermit;

#pragma mark -- 视频处理

/**
 根据视频的URL来获取视频封面截图
 
 @param videoURL 视频URL
 @param enableSave 是否将封面截图保存到本地
 @return 返回封面截图
 */
- (UIImage *)imageWithVideoURL: (NSURL *)videoURL enableSave: (BOOL)enableSave;


- (void)getVideoPathFromURL: (NSURL *)videoURL PHAsset: (PHAsset *)asset enableSave: (BOOL)enableSave completion: (void(^)(NSString *name, UIImage *screenshot, id pathData, NSString *videoPath))completion;

@end
