//
//  ZLKalmanFilter.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/9.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLKalmanFilter.h"
#import "ZLLocationData.h"
@interface ZLKalmanFilter ()
@property (nonatomic, assign) NSInteger timestamp;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) CGFloat variance;

@property (nonatomic, strong) ZLLocationData *filteredLocationData;

@end
@implementation ZLKalmanFilter

- (instancetype)init{
    if (self = [super init]) {
        self.variance = -1;
        
    }
    return self;
}

- (void)locationUpdate:(ZLLocationData *)locationData{
    [self processWithNewSpeed:locationData.getSpeed newLatitude:locationData.getLatitude newLongitude:locationData.getLongitude newTimestamp:locationData.getTimestamp newAccuracy:locationData.getAccuracy];
}

- (void)setStateWithLatitude:(double)latitude
                   longitude:(double)longitude
                   timestamp:(NSInteger)timestamp
                    accuracy:(CGFloat)accuracy{
    self.latitude = latitude;
    self.longitude = longitude;
    self.timestamp = timestamp;
    self.variance = accuracy * accuracy;
}

- (void)processWithNewSpeed:(CGFloat)newSpeed
                newLatitude:(double)newLatitude
               newLongitude:(double)newLongitude
               newTimestamp:(NSInteger)newTimestamp
                newAccuracy:(double)newAccuracy{
    if (self.variance < 0) {
        
        [self setStateWithLatitude:newLatitude longitude:newLongitude timestamp:newTimestamp accuracy:newAccuracy];
        //  在这也初始化self.filteredLocationData，保证getFilteredLocationData在第一次返回时也不为空
        self.filteredLocationData = [[ZLLocationData alloc]initWithLatitude:newLatitude longitude:newLongitude speed:newSpeed timestamp:newTimestamp];
        
    }else{
        NSInteger duration = newTimestamp - self.timestamp;
        if (duration > 0) {
            
            self.variance += duration * newSpeed * newSpeed;
            self.timestamp = newTimestamp;
            
        }
        float k = self.variance / (self.variance + newAccuracy * newAccuracy);
        self.latitude += k * (newLatitude - self.latitude);
        self.longitude += k * (newLongitude - self.longitude);
        
        self.variance = (1 - k) * self.variance;
        
        self.filteredLocationData = [[ZLLocationData alloc] initWithLatitude:self.latitude longitude:self.longitude speed:newSpeed timestamp:self.timestamp];
        
    }
    
    
}

- (ZLLocationData *)getFilteredLocationData{
    return self.filteredLocationData;
}
@end
