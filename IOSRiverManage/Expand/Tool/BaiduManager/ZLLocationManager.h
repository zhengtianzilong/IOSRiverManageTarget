//
//  ZLLocationManager.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/19.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class ZLLocationManager,BMKLocationService,BMKUserLocation;
@protocol DYLocationManagerDelegate <NSObject>
/**
 *  当位置发生变化时调用
 */
- (void)locationManage:(ZLLocationManager *)manager didUpdateLocations:(NSArray <CLLocation *>*)locations;

@optional
/**
 *  当定位状态发生变化时调用,开启定位/停止定位
 */
- (void)locationManage:(ZLLocationManager *)manager didChangeUpdateLocationState:(BOOL)running;
@end
@interface ZLLocationManager : NSObject
@property (nonatomic,strong) NSMutableArray<CLLocation *> *locations;
// 记录用户的位置和转换后的地址
@property (nonatomic,strong) NSMutableArray *locationsAndAddress;
@property (nonatomic, weak)id<DYLocationManagerDelegate> delegate;

/*  用于保存总记录
 */

@property (nonatomic) double totalDistanc;
@property (nonatomic) double speed;
/** 定位开始时间 */
@property (nonatomic, strong) NSDate *startLocationDate;
/** 是否是运动记录 */
@property (nonatomic,getter=isRunning) BOOL running;

//用于显示当前的位子
@property (nonatomic, strong) BMKUserLocation *userLocation;

+ (ZLLocationManager *)shareLocationManager;
/**
 * 开始定位
 */
- (void)startUpdatingLocation;

/**
 * 结束定位
 */
- (void)stopUpdatingLocation;

- (void)geoResult:(BMKUserLocation *)loction;

@end
