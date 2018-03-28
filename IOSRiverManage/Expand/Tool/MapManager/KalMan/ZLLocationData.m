//
//  ZLLocationData.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/9.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLLocationData.h"

@interface ZLLocationData ()

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) NSInteger timestamp;
@property (nonatomic, assign) double accuracy;

@end

@implementation ZLLocationData

- (id)initWithLatitude:(double)latitude longitude:(double)longitude speed:(CGFloat)speed timestamp:(NSInteger)timestamp{
    if (self = [super init]) {
        self.latitude = latitude;
        self.longitude = longitude;
        self.speed = speed;
        self.timestamp = timestamp;
        self.accuracy = 8;
    }
    return self;
}

- (CLLocationCoordinate2D)getCoordinate{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    return coordinate;
}

- (double)getLatitude{
    return self.latitude;
}
- (double)getLongitude{
    return self.longitude;
}
- (CGFloat)getSpeed{
    return self.speed;
}
- (NSInteger)getTimestamp{
    return self.timestamp;
}
- (double)getAccuracy{
    return self.accuracy;
}

@end
