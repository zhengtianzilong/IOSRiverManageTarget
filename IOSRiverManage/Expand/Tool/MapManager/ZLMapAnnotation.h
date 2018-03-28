//
//  ZLMapAnnotation.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/9.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
@interface ZLMapAnnotation : NSObject<MAAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D )coordinate;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
