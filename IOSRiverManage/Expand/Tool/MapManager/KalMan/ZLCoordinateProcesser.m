//
//  ZLCoordinateProcesser.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/9.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLCoordinateProcesser.h"
#import "ZLLocationData.h"
#import "ZLKalmanFilter.h"
@interface ZLCoordinateProcesser ()

@property (nonatomic, strong) ZLKalmanFilter *kalmanFilter;

@end
@implementation ZLCoordinateProcesser

- (instancetype)init{
    if (self = [super init]) {
        self.kalmanFilter = [[ZLKalmanFilter alloc]init];
    }
    return self;
}

- (CLLocationCoordinate2D)processWithCoordinate:(CLLocationCoordinate2D)coordinate speed:(CGFloat)speed timestamp:(NSInteger)timestamp{
    ZLLocationData *locationData = [[ZLLocationData alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude speed:speed timestamp:timestamp];
    [self.kalmanFilter locationUpdate:locationData];
    
    CLLocationCoordinate2D filterCoordinate = [self.kalmanFilter getFilteredLocationData].getCoordinate;
    
    return filterCoordinate;
    
    
}
@end
