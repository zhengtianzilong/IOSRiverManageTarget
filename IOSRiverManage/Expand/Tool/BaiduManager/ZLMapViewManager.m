//
//  ZLMapViewManager.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/27.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLMapViewManager.h"

@implementation ZLMapViewManager

- (BMKMapView *)mapView{
    
    if (!_mapView) {
        
        _mapView = [[BMKMapView alloc]init];
        // 去除百度地图logo
        UIView *mview = _mapView.subviews.firstObject;
        for (id logoView in mview.subviews) {
            if ([logoView isKindOfClass:[UIImageView class]]) {
                UIImageView *blogo = (UIImageView *)logoView;
                blogo.hidden = YES;
            }
        }

        
    }
    return _mapView;
    
}

+ (ZLMapViewManager *)shareMapViewManager{
    //    //单例
    static ZLMapViewManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[ZLMapViewManager alloc]init];
        
    });
    return manager;
}


@end
