//
//  ZLMapManager.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/9.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import "ZLMapLocationModel.h"
@interface ZLMapManager : NSObject

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) NSMutableArray *annotationRecordArray;
@property (nonatomic, strong) NSMutableArray *locationsAndAddress;

// 得到定位的信息
@property (nonatomic, strong) ZLMapLocationModel *locationModel;



- (void)setupMapView;


/** 开始定位 */
- (void)startLocation;

/** 结束定位 */
- (void)endLocation;


@end
