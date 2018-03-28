//
//  ZLLocationData.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/9.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLLocationData : NSObject

- (id)initWithLatitude:(double)latitude
             longitude:(double)longitude
                 speed:(CGFloat)speed
             timestamp:(NSInteger)timestamp;

- (CLLocationCoordinate2D)getCoordinate;
- (double)getLatitude;
- (double)getLongitude;
- (CGFloat)getSpeed;
- (NSInteger)getTimestamp;
- (double)getAccuracy;

@end
