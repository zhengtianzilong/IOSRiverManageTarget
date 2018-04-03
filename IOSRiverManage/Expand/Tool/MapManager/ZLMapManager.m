//
//  ZLMapManager.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/9.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLMapManager.h"
#import "ZLCoordinateProcesser.h"
#import "ZLMapAnnotation.h"
#import "ZLMapCalculateFunc.h"
@import AddressBookUI;
@interface ZLMapManager ()<MAMapViewDelegate>


// 系统回调更新定位数据的次数
@property (nonatomic, assign) NSInteger updateLocationTimes;
/** 卡尔曼滤波处理 */
@property (nonatomic, strong) ZLCoordinateProcesser *processer;

/** 当前速度 */
@property (nonatomic, assign) CGFloat currentSpeed;

@property (nonatomic, assign) double lastLocatedTime;  // 上一次定位的时间
@property (nonatomic, assign) double currentLocatedTime;   // 当前定位的时间

@property (nonatomic, strong) CLGeocoder *geoder;

@property (nonatomic, strong) YTKKeyValueStore *store;

@end


@implementation ZLMapManager
static const double kMapDistanceFilter = 3.0;
- (instancetype)init{
    if (self = [super init]) {
        self.annotationRecordArray = [NSMutableArray array];
        [self initMap];
        
        // 初始化，之后通过是否大于0来判断有没有赋值
        self.lastLocatedTime = -1;
        self.currentLocatedTime = -1;
        self.currentSpeed = 0;
        
        self.updateLocationTimes = 0;
        self.processer = [ZLCoordinateProcesser new];
        
        self.store = [[ZLDBStoreManager shareDbStoreManager]createDB];
        [self.store createTableWithName:DBMapTable];
        self.locationModel = [[ZLMapLocationModel alloc]init];
    }
    return self;
    
    
}

- (void)initMap{
    
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    self.mapView = [[MAMapView alloc]init];
    self.mapView.delegate = self;
    self.mapView.distanceFilter = kMapDistanceFilter;
    _geoder = [[CLGeocoder alloc]init];
    [self setupMapView];
}

- (void)setupMapView{
    self.mapView.zoomLevel = 14;
    self.mapView.showsScale = NO;
    self.mapView.pausesLocationUpdatesAutomatically = NO;
    //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        self.mapView.allowsBackgroundLocationUpdates = YES;
    }
    
}

- (void)startLocation{
    // 开始进行定位
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
}

- (void)endLocation{
    self.mapView.showsUserLocation = NO;
}

// 得到定位信息,并添加到数组中
- (void)getLocationdDetailAddress:(NSString *)latitude location:(CLLocation *)location longitude:(NSString *)longitude withCreateTime:(NSString *)createTime {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         longitude,@"longitude",latitude,@"latitude",createTime,@"createTime", nil];
    [self.locationsAndAddress addObject:dic];
    if (self.startSavePoint) {
        
        NSMutableArray *addressArray = [[self.store getObjectById:DBAddress fromTable:DBMapTable] mutableCopy];
        
        if (addressArray.count > 0) {
            
            [addressArray addObjectsFromArray:self.locationsAndAddress];
            [self.store putObject:addressArray withId:DBAddress intoTable:DBMapTable];
            
            [self.locationsAndAddress removeAllObjects];
            
        }else{
            [self.store putObject:self.locationsAndAddress withId:DBAddress intoTable:DBMapTable];
        }
        
        
    }
}

// 只得到定位信息
- (void)getLocationdDetail:(NSString *)latitude location:(CLLocation *)location longitude:(NSString *)longitude {
    [self.geoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error||placemarks.count==0) {
            
        }else//编码成功
        {
            //显示最前面的地标信息
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            
            NSString *address = ABCreateStringWithAddressDictionary(firstPlacemark.addressDictionary, YES);
            
            NSString *detailAddress = [[address stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            ZLLog(@"%@",detailAddress);
            self.locationModel.longitude = longitude;
            self.locationModel.latitude = latitude;
            self.locationModel.addressDetail = detailAddress;
        }
    }];
}

/**
 添加到数组中

 @param coordinate 定位点
 */
- (void)addLocationCoordinate:(CLLocationCoordinate2D)coordinate location:(CLLocation *)location{
    
    ZLMapAnnotation *annotation = [[ZLMapAnnotation alloc]initWithCoordinate:coordinate];
    
    NSString *longitude = [NSString stringWithFormat:@"%f",annotation.coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%f",annotation.coordinate.latitude];
    
    NSString *createTime = [self getCurrenttTimer];
    [self.annotationRecordArray addObject:annotation];
    
    if (_annotationRecordArray.count > 2) {
        [self getLocationdDetailAddress:latitude location:location longitude:longitude withCreateTime:createTime];
    }
    
    
    
    
    
}

/**
 得到当前的时间戳
 */
- (NSString *)getCurrenttTimer{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    // 乘以1000是为了和java对其,Java是13位,IOS是10位
    NSTimeInterval timer = [date timeIntervalSince1970] * 1000;
    NSString *currentTime = [NSString stringWithFormat:@"%.0f",timer];
    return currentTime;
}

/** 更新路径 */
- (void)updateRoute{
    NSInteger numberOfCoords = [self.annotationRecordArray count];
    NSInteger requiredCount = 2;// 需要两点来绘制新的路线
    if (numberOfCoords < requiredCount) {
        return;
    }
    [self addUpdateRoute];
}
- (void)addUpdateRoute{
    [ZLMapCalculateFunc addAnnotationArray:self.annotationRecordArray toMapView:self.mapView];
    [self removePreviousRoute];
    // 绘制最新的路径
    ZLMapAnnotation *annotation = [self.annotationRecordArray lastObject];
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
}


/** 移除之前的路径 */
- (void)removePreviousRoute{
    NSArray *overlays = self.mapView.overlays;
    NSInteger count = [overlays count];
    NSInteger requireNumber = 1;// 只需要一条路径来展示路线
    if (count > requireNumber) {
        NSRange range = NSMakeRange(0, count - requireNumber);
        NSArray *subOverlays = [overlays subarrayWithRange:range];
        [self.mapView removeOverlays:subOverlays];
    }
}

#pragma mark -- MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    if (updatingLocation) {
        NSString *longitude = [NSString stringWithFormat:@"%f",userLocation.coordinate.longitude];
        NSString *latitude = [NSString stringWithFormat:@"%f",userLocation.coordinate.latitude];
        [self getLocationdDetail:latitude location:userLocation.location longitude:longitude];
        
//        [self addLocationCoordinate:userLocation.coordinate location:userLocation.location];
        
        self.updateLocationTimes++;
        NSInteger ignoreTimes = 5;
        if (self.updateLocationTimes <= ignoreTimes) {
            return;
        }
        // 滤波在处理慢速运行时，会出现路径端点与定位点连接不上的情况，所以在绘制路径时，将未处理过的当前点添加到数组的末尾，每次有新位置进行计算时，先将上一次数组末尾的点移除。
        if (self.annotationRecordArray.count > 0) {
            [self.annotationRecordArray removeLastObject];
        }
        
        CLLocationCoordinate2D coordinate = userLocation.coordinate;
        // 卡尔曼滤波器
        CLLocationCoordinate2D filteredCoordinate =  [self.processer processWithCoordinate:coordinate speed:userLocation.location.speed timestamp:CFAbsoluteTimeGetCurrent()];
        
        if (self.startSavePoint) {
            
            [self addLocationCoordinate:filteredCoordinate location:userLocation.location];
            //        [self addLocationCoordinate:coordinate location:userLocation.location];
            [self updateRoute];

            
        }
        
        
        
    }
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay{
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc]initWithOverlay:overlay];
        polylineRenderer.lineWidth = 8.f;
        polylineRenderer.strokeColor = [UIColor redColor];
        return polylineRenderer;
        
    }
    
    return nil;
    
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        
        MAPinAnnotationView  *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        
        if([[annotation title] isEqualToString:@"起点"]){ // 有起点旗帜代表应该放置终点旗帜（程序一个循环只放两张旗帜：起点与终点）
            annotationView.image = [UIImage imageNamed:@"map_startPoint.png"];
//            annotationView.pinColor = BMKPinAnnotationColorGreen;
            
        }else if([[annotation title] isEqualToString:@"终点"]){
            annotationView.image = [UIImage imageNamed:@"map_endPoint.png"];
//            annotationView.pinColor = BMKPinAnnotationColorRed;
        }else if([[annotation title] isEqualToString:@"上报案件"]){ // 没有起点旗帜，应放置起点旗帜
             annotationView.image = [UIImage imageNamed:@"GaodeRiverReport.png"];
            
        }else if([[annotation title] isEqualToString:@"下发任务"]){ // 没有起点旗帜，应放置起点旗帜
            annotationView.image = [UIImage imageNamed:@"GaodeRiverDown"];
            
        }
        
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO

        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
    
    
}

- (NSMutableArray *)locationsAndAddress{
    if (!_locationsAndAddress) {
        _locationsAndAddress = [NSMutableArray new];
    }
    return _locationsAndAddress;
}

@end
