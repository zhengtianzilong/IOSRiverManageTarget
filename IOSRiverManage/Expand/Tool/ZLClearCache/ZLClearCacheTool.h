//
//  ZLClearCacheTool.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/23.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLClearCacheTool : NSObject
/**
 *  获取缓存大小
 */
+ (NSString *)getCacheSize;


/**
 *  清理缓存
 */
+ (BOOL)clearCaches;

@end
