//
//  ZLMapCalculateFunc.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/9.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLMapCalculateFunc.h"
#import "ZLMapAnnotation.h"
@implementation ZLMapCalculateFunc
+ (void)addAnnotationArray:(NSArray<ZLMapAnnotation *> *)annotationArray
                 toMapView:(MAMapView *)mapView{
    NSInteger count = [annotationArray count];
    CLLocationCoordinate2D polylineCoords[count];
    for (NSInteger i = 0; i < count; i++) {
        ZLMapAnnotation *annotation = (ZLMapAnnotation *)annotationArray[i];
        CLLocationCoordinate2D coordinate = annotation.coordinate;
        polylineCoords[i].latitude = coordinate.latitude;
        polylineCoords[i].longitude = coordinate.longitude;
    }
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:polylineCoords count:count];
    [mapView addOverlay:polyline];
    
}
@end
