//
//  ZLMapViewManager.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/27.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
@interface ZLMapViewManager : NSObject

@property (nonatomic, strong) BMKMapView *mapView;

+ (ZLMapViewManager *)shareMapViewManager;

@end
