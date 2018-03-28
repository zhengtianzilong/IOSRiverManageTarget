//
//  ZLCoordinateProcesser.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/9.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLCoordinateProcesser : NSObject

- (CLLocationCoordinate2D)processWithCoordinate:(CLLocationCoordinate2D)coordinate speed:(CGFloat)speed timestamp:(NSInteger)timestamp;

@end
