//
//  ZLMapAnnotation.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/9.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLMapAnnotation.h"

@implementation ZLMapAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate{
    if (self = [super init]) {
        _coordinate = coordinate;
    }
    return self;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    _coordinate = newCoordinate;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"latitude = %f, longitude = %f", _coordinate.latitude, _coordinate.longitude];
}

@end
