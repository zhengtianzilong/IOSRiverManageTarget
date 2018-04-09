//
//  ZLRiverInfoMapVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/9.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverInfoMapVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface ZLRiverInfoMapVC ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) NSMutableArray *eventAllPointArray;

@end

@implementation ZLRiverInfoMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.eventAllPointArray = [NSMutableArray array];
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    _mapView.zoomLevel = 14;
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    if (self.publicityBrandModel) {
        
        [self createStart:self.publicityBrandModel.PUBLICITY_BRAND_LATITUDE AndEndPoint:self.publicityBrandModel.PUBLICITY_BRAND_LONGITUDE withTitle:@"公示牌"];
        
    }else if (self.pumpingPortModel) {
        
        [self createStart:self.pumpingPortModel.LATITUDE AndEndPoint:self.pumpingPortModel.LONGITUDE withTitle:@"取水口"];
        
    }else if (self.sewageOutletModel) {
        
        [self createStart:self.sewageOutletModel.LATITUDE AndEndPoint:self.sewageOutletModel.LONGITUDE withTitle:@"排污口"];
        
    }else if (self.riverInfoBaseModel){
        [self createStart:self.riverInfoBaseModel.LATITUDE_START AndEndPoint:self.riverInfoBaseModel.LONGITUDE_START withTitle:@"起点"];
        
        [self createStart:self.riverInfoBaseModel.LATITUDE_END AndEndPoint:self.riverInfoBaseModel.LONGITUDE_END withTitle:@"终点"];
    
        
        
    }
    [_mapView addAnnotations:self.eventAllPointArray];

    
    [self.mapView reloadMap];
}

// 创建上报的点
- (void)createStart:(NSString *)latitude AndEndPoint:(NSString *)longitude withTitle:(NSString *)title{
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    pointAnnotation.title = title;
    [self.eventAllPointArray addObject:pointAnnotation];
    [self.mapView setCenterCoordinate:pointAnnotation.coordinate];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        
        MAPinAnnotationView  *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        
        if([[annotation title] isEqualToString:@"公示牌"]){ // 有起点旗帜代表应该放置终点旗帜（程序一个循环只放两张旗帜：起点与终点）
            annotationView.image = [UIImage imageNamed:@"river_publicBrand"];
            
        }
        if([[annotation title] isEqualToString:@"取水口"]){
            annotationView.image = [UIImage imageNamed:@"river_pumpingPort"];
        }
        
        if([[annotation title] isEqualToString:@"排污口"]){
            annotationView.image = [UIImage imageNamed:@"river_sewage"];
        }
        
        if([[annotation title] isEqualToString:@"起点"]){
            annotationView.image = [UIImage imageNamed:@"map_startPoint"];
        }
        
        if([[annotation title] isEqualToString:@"终点"]){
            annotationView.image = [UIImage imageNamed:@"map_endPoint"];
        }
        
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = NO;        //设置标注动画显示，默认为NO
        
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        annotationView.userInteractionEnabled = YES;
        return annotationView;
    }
    
    return nil;
}



@end
