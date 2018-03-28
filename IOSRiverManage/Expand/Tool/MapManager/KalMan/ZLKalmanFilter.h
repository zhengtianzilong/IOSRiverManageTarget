//
//  ZLKalmanFilter.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/9.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZLLocationData;
@interface ZLKalmanFilter : NSObject

- (void)locationUpdate:(ZLLocationData *)locationData;
- (ZLLocationData *)getFilteredLocationData;

@end
