//
//  ZLMapCalculateFunc.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/9.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
@class ZLMapAnnotation;
@interface ZLMapCalculateFunc : NSObject
+ (void)addAnnotationArray:(NSArray<ZLMapAnnotation *> *)annotationArray
                 toMapView:(MAMapView *)mapView;
@end
