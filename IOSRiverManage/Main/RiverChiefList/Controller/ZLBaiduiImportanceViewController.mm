//
//  ZLBaiduTrackViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/16.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLBaiduiImportanceViewController.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Map/BMKPolyline.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "ZLLocationManager.h"
#import "ZLRiverSelectView.h"
#import "ZLBaiduBottomButtonView.h"
#import "ZLBaiduAddOrSubView.h"
#import "ZLBaiduRiverInfoView.h"
#import "ZLBaiduImportReportViewController.h"
#import "WJYAlertView.h"
#import "ZLRiversDemandReachService.h"
#import "ZLRiverDemandModel.h"
#import "ZLRiverChiefAddEventService.h"
#import "ZLEndCheckRiverService.h"
#import "ZLBaiduImportDownTaskViewController.h"
#import "ZLReportAndDownTaskView.h"
#import "ZLMapViewManager.h"
#define polylineWidth 5.0
#define polylineColor [[UIColor greenColor] colorWithAlphaComponent:1]
#define mapViewZoomLevel 15
#define removeObjectsLen 20

typedef enum : NSUInteger {
    endRiver,
    startRiver,
    rivering,
} riverStaus;

@interface ZLBaiduiImportanceViewController ()<BMKMapViewDelegate,DYLocationManagerDelegate>

@property (nonatomic, strong) ZLBaiduBottomButtonView *bottomButtonView;
// 放大或缩小
@property (nonatomic, strong) ZLBaiduAddOrSubView *addOrSubView;

@property (nonatomic, strong) ZLBaiduRiverInfoView *riverInfoView;

@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) BMKPolyline *polyLine;

// 开始大头针
@property (nonatomic, weak) BMKPointAnnotation *startAnnotation;

// 结束大头针
@property (nonatomic, weak) BMKPointAnnotation *endAnnotation;

// 上报的事件大头针
@property (nonatomic, weak) BMKPointAnnotation *eventAnnotation;



@property (nonatomic, strong) ZLLocationManager *locationManager;
/** 保存经纬度信息 */
@property (strong, nonatomic)NSMutableArray<CLLocation *> *locations;

@property (nonatomic, assign)BOOL isWillAppear;

// 是否展示遮罩
@property (nonatomic, assign)BOOL isShowMaskview;

@property (nonatomic,strong) ZLRiverSelectView *riverView;

@property (nonatomic, strong) UIButton *reportButton;
// 下发按钮
@property (nonatomic, strong) UIButton *downTaskButton;

// 是否已经结束巡河
@property (nonatomic, assign) BOOL isEndRiver;

@property (nonatomic, assign) riverStaus status;

@property (nonatomic, strong) NSMutableArray *riverSourceArray;

// 河长所拥有的河段
@property (nonatomic, strong) ZLRiverDemandModel *demandModel;

@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;

@property (nonatomic, strong) ZLMapViewManager *mapViewManager;

@property (nonatomic, strong) ZLReportAndDownTaskView *reportAndDown;

@end

@implementation ZLBaiduiImportanceViewController
- (void)loadData{
    ZLRiversDemandReachService *demand = [[ZLRiversDemandReachService alloc]initWithUidCode:_uid];
    
    _riverSourceArray = [NSMutableArray array];
    
    [demand startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSDictionary *dic = request.responseObject;
        
        NSArray *modelArray = dic[@"data"];
        
        if (modelArray.count > 0) {
            
            for (NSDictionary *dic in modelArray) {
                
                ZLRiverDemandModel *model = [[ZLRiverDemandModel alloc]initWithDictionary:dic error:nil];
                
                [_riverSourceArray addObject:model];
                
                ZLLog(@"%@",model);
            }
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
//                //回调或者说是通知主线程刷新，
//                _riverInfoView.demandModel = _demandModel;
                
            });
        }
        self.title = @"";
        ZLRiverDemandModel *demandModel = [[ZLRiverDemandModel alloc]init];
        demandModel.riverId = @"";
        demandModel.rivers_name = @"";
        demandModel.org_type = @"";
        demandModel.start_point_desc = @"";
        demandModel.end_point_desc = @"";
        _demandModel = demandModel;
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZLLog(@"%@",request);
        self.title = @"";
    }];
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
    [self loadData];
    _isShowMaskview = YES;
    _status = startRiver;
    _bottomButtonView = [[ZLBaiduBottomButtonView alloc]init];
    
    [_bottomButtonView.startButton addTarget:self action:@selector(startClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_bottomButtonView.endButton addTarget:self action:@selector(endClick) forControlEvents:(UIControlEventTouchUpInside)];
    _bottomButtonView.endButton.enabled = NO;
    
    [self.view addSubview:_bottomButtonView];
    [_bottomButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.width.mas_equalTo(App_Frame_Width);
        make.height.mas_equalTo(AdaptedHeight(115));
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    
    
    _riverInfoView = [[ZLBaiduRiverInfoView alloc]init];
    
    _riverInfoView.alpha = 0;
    
    [self.view addSubview:_riverInfoView];
    
    [_riverInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.width.mas_equalTo(App_Frame_Width);
//        make.height.mas_equalTo(AdaptedHeight(170));
        make.height.mas_equalTo(90);
        make.bottom.equalTo(_bottomButtonView.mas_top);
        
    }];
    
    
    _mapViewManager = [ZLMapViewManager shareMapViewManager];
    _mapView = _mapViewManager.mapView;
    [self.view addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.width.mas_equalTo(App_Frame_Width);
        make.bottom.equalTo(_bottomButtonView.mas_top);
        make.top.equalTo(self.view).offset(64);
    }];
    [self.view bringSubviewToFront:_riverInfoView];
    [self.view bringSubviewToFront:_bottomButtonView];
    
   
    _reportAndDown = [[ZLReportAndDownTaskView alloc]init];
    [self.view addSubview:_reportAndDown];
    [_reportAndDown.downTaskButton addTarget:self action:@selector(downTaskClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_reportAndDown.reportButton addTarget:self action:@selector(reportClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_reportAndDown mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(15);
        make.bottom.equalTo(_bottomButtonView.mas_top).offset(-15);
        make.width.mas_equalTo(47);
        make.height.mas_equalTo(95);
        
    }];

    
    _addOrSubView = [[ZLBaiduAddOrSubView alloc]init];
    
    [_addOrSubView.addButton addTarget:self action:@selector(zoomBig) forControlEvents:(UIControlEventTouchUpInside)];
    [_addOrSubView.subButton addTarget:self action:@selector(zoomSmall) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:_addOrSubView];
    
    [_addOrSubView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.bottom.equalTo(_bottomButtonView.mas_top).offset(-15);
        make.width.mas_equalTo(38);
        make.height.mas_equalTo(74);
    }];

    
    
    _isWillAppear = YES;
    
    
    
    //初始化定位
    [self initLocation];
    
}


/**
 上报案件
 */
- (void)reportClick{
    
    if (_status == endRiver) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"巡河已经结束,无法上报" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
    }else if(_status == startRiver){
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"还未开始巡河,无法上报" cancelButtonName:@"确定" otherButtonTitles:nil, nil];        return;
    }else{
        ZLBaiduImportReportViewController *reportVC = [[ZLBaiduImportReportViewController alloc]initWithShowFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - App_Frame_Height * 0.9, [UIScreen mainScreen].bounds.size.width, App_Frame_Height * 0.9) ShowStyle:(MYPresentedViewShowStyleFromBottomSpreadStyle) callback:^(id callback) {
            
            if ([callback isEqualToString:@"确定"]) {
                self.eventAnnotation = [self creatPointWithLocaiton:_locationManager.userLocation.location title:@"上报案件"];
            }
        }];
        reportVC.isHaveInfoView = _riverInfoView.alpha;
        reportVC.demandModel = self.demandModel;
        reportVC.uid = _uid;
        reportVC.type = _type;
        reportVC.uuid = _uuid;
        reportVC.location = _locationManager.userLocation.location;

        [self presentViewController:reportVC animated:YES completion:nil];
    }
    
    
}

/**
 下发案件
 */
- (void)downTaskClick{
    
    if (_status == endRiver) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"巡河已经结束,无法下发" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
    }else if(_status == startRiver){
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"还未开始巡河,无法下发" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return;
    }else{
        
        //        [_locationManager geoResult:_locationManager.userLocation];
        
        ZLBaiduImportDownTaskViewController *downVC = [[ZLBaiduImportDownTaskViewController alloc]initWithShowFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - App_Frame_Height * 0.9, [UIScreen mainScreen].bounds.size.width, App_Frame_Height * 0.9) ShowStyle:(MYPresentedViewShowStyleFromBottomSpreadStyle) callback:^(id callback) {
            
            if ([callback isEqualToString:@"确定"]) {
                self.eventAnnotation = [self creatPointWithLocaiton:_locationManager.userLocation.location title:@"下发任务"];
                
            }
        }];
        
        downVC.isHaveInfoView = _riverInfoView.alpha;
        downVC.demandModel = self.demandModel;
        downVC.uid = _uid;
        downVC.type = _type;
        downVC.uuid = _uuid;
        downVC.location = _locationManager.userLocation.location;
        [self presentViewController:downVC animated:YES completion:nil];
    }
    
    
}



- (void)startClick{
    
    if (_isEndRiver) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"巡河已经结束" cancelButtonName:@"确定" otherButtonTitles:nil,nil];
    }else{
        
        NSString *titleTips = @"";
        
        if ([self.title isEqualToString:@""]) {
            titleTips = [NSString stringWithFormat:@"当前未选择河段,是否确定开始巡河"];
        }else{
            titleTips = [NSString stringWithFormat:@"当前已选择%@,是否确定开始巡河",self.title];
        }
        
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                // 得到当前的时间戳
                _startTime = [self getCurrenttTimer];
                // 放置起点旗帜
                if (!_startAnnotation) {
                    [_locationManager startUpdatingLocation];
                    _startAnnotation = [self creatPointWithLocaiton:_locationManager.userLocation.location title:@"起点"];
                    
                    _status = rivering;
                    _bottomButtonView.startButton.backgroundColor = [UIColor grayColor];
                    _bottomButtonView.startButton.enabled = NO;
                    _bottomButtonView.endButton.enabled = YES;
                }else{
                    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                        
                    } title:@"提示" message:@"巡河已经开始" cancelButtonName:@"确定" otherButtonTitles:nil,nil];

                }
            }
        } title:@"提示" message:titleTips cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
    }
}

- (void)endClick{
    
    if (_isEndRiver) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"巡河已经结束" cancelButtonName:@"确定" otherButtonTitles:nil,nil];
    }else{
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                // 得到结束的时间戳
                _endTime = [self getCurrenttTimer];
//                // 放置终点旗帜
//                if (_startAnnotation) {
//                    _endAnnotation  = [self creatPointWithLocaiton:_locationManager.userLocation.location title:@"终点"];
                    [self endRiverService];
//                }
            }
        } title:@"提示" message:@"是否确定结束巡河" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
    }
}

/**
 巡河结束上报服务
 */
- (void)endRiverService{
    ZLEndCheckRiverService *endService = [[ZLEndCheckRiverService alloc]initWithuid:_uid uuid:_uuid riverId:_demandModel.riverId startTime:_startTime endTime:_endTime type:_type batchData: _locationManager.locationsAndAddress];
    [SVProgressHUD showWithStatus:@"结束巡河中"];
    [endService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSDictionary *dic = request.responseObject;
        if ([dic[@"code"] isEqualToString:@"0"]) {
            _isEndRiver = YES;
            _bottomButtonView.startButton.backgroundColor = [UIColor grayColor];
            [_locationManager stopUpdatingLocation];
            _status = endRiver;
            [SVProgressHUD showSuccessWithStatus:@"结束巡河成功"];
            [SVProgressHUD dismissWithDelay:0.3 completion:^{
                // 放置终点旗帜
                if (_startAnnotation) {
                    _endAnnotation  = [self creatPointWithLocaiton:_locationManager.userLocation.location title:@"终点"];
                }
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"结束巡河失败"];
            [SVProgressHUD dismissWithDelay:0.3];
            
        }
        
        ZLLog(@"%@",request.responseObject);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [SVProgressHUD showErrorWithStatus:@"结束巡河失败 请检查网络"];
        [SVProgressHUD dismissWithDelay:0.3];
        
    }];
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


#pragma mark -- 原生生成事件ID,暂时不用,现在用H5的
- (NSString *)creatEventUUID{
    NSString *uuid = @"";
    for (int i = 1; i <= 32; i++) {
        
        double d =  floor(arc4random() % (16 + 1));
        
        NSString * n = [self getHexByDecimal:d];
        uuid = [uuid stringByAppendingString:n];
        
    }
    return uuid;
    
}

- (NSString *)getHexByDecimal:(NSInteger)decimal {
    
    NSString *hex =@"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i<9; i++) {
        
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
                
            case 10:
                letter =@"A"; break;
            case 11:
                letter =@"B"; break;
            case 12:
                letter =@"C"; break;
            case 13:
                letter =@"D"; break;
            case 14:
                letter =@"E"; break;
            case 15:
                letter =@"F"; break;
            default:
                letter = [NSString stringWithFormat:@"%ld", number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) {
            
            break;
        }
    }
    return hex;
}



/**
 地图的放大
 */
- (void)zoomBig{
    [_mapView zoomIn];
    
}


/**
 地图的缩小
 */
- (void)zoomSmall{
    [_mapView zoomOut];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_isWillAppear) {
        
        [_mapView viewWillAppear];
        // 0x619000100480
        _mapView.delegate = self;
        
        _locationManager.delegate = self;
        
        //更新位置
        
        BMKUserLocation *userLocation = _locationManager.userLocation;
        
        //[_mapView setCenterCoordinate:location.coordinate animated:YES];
        //下行：设置默认的地图中心。按上行设置时，当直接改变zoomLevel，是中心会改变
        _mapView.centerCoordinate = userLocation.location.coordinate;
        [_mapView updateLocationData:userLocation];
        
        _isWillAppear = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_locationManager stopUpdatingLocation];
    [_mapView viewWillDisappear];//一定要写
    _mapView.delegate = nil;//不用时，值nil。释放内存
    [[ZLMapViewManager shareMapViewManager].mapView removeOverlays:[_mapView overlays]];
    
    [_mapView removeAnnotations: [_mapView annotations]];
    _mapView = nil;
    
}
- (void) dealloc{
//    [_mapView viewWillDisappear];
//    _mapView.delegate = nil;
//    _mapView = nil;
//    [_locationManager stopUpdatingLocation];
    
    
}

#pragma mark -- 初始化地图
- (void)initLocation{
    
    _mapView.delegate = self;
    
    _mapView.zoomLevel = mapViewZoomLevel;
    
    BMKLocationViewDisplayParam *displayParam = [BMKLocationViewDisplayParam new];
    displayParam.isRotateAngleValid = true;//跟随态旋转角度是否生效
    displayParam.isAccuracyCircleShow = true;//精度圈是否显示
    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    //    displayParam.locationViewImgName = @"bnavi_icon_location_fixed";//定位图标名称
    //    [_mapView updateLocationViewWithParam:displayParam];
    
    
    /** 开始定位 */
    _locationManager = [ZLLocationManager shareLocationManager];
    _locationManager.delegate = self;
    
    [_locationManager startUpdatingLocation];
    
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;// 定位罗盘模式
    _mapView.showsUserLocation = YES;//显示定位图层,开始定位
    
    
}

#pragma mark -- DYLocationManagerDelegate

- (void)locationManage:(ZLLocationManager *)manager didUpdateLocations:(NSArray <CLLocation *>*)locations{
    //_mapView.zoomLevel = mapViewZoomLevel;
    BMKUserLocation *userLocation = manager.userLocation;
    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    [_mapView updateLocationData:userLocation];
    
    
    // 放置起点旗帜
    if (_startAnnotation) {
        [self drawWalkPolyline:locations];
    }
    
    
}
#pragma mark -- 路径配置
/**
 *  绘制轨迹路线
 */
- (void)drawWalkPolyline:(NSArray *)locations{
    // 轨迹点数组个数
    NSUInteger count = locations.count;
    // 动态分配存储空间
    // BMKMapPoint是个结构体：地理坐标点，用直角地理坐标表示 X：横坐标 Y：纵坐标
    
    BMKMapPoint *tempPoints = new BMKMapPoint[sizeof(BMKMapPoint) * count];
    // 遍历数组 ,将coordinate 转化为 BMKMapPoint
    [locations enumerateObjectsUsingBlock:^(CLLocation *location, NSUInteger idx, BOOL * _Nonnull stop) {
        BMKMapPoint locationPoint = BMKMapPointForCoordinate(location.coordinate);
        tempPoints[idx] = locationPoint;
    }];
    
    //    // 放置起点旗帜
    //    if (!_startAnnotation && count >0  ) {
    //        _startAnnotation = [self creatPointWithLocaiton:[_locations firstObject] title:@"起点"];
    //    }
    
    //移除原有的绘图，避免在原来轨迹上重画
    if (self.polyLine) {
        [self.mapView removeOverlay:self.polyLine];
    }
    
    //通过points构建BMKPolyline
    self.polyLine = [BMKPolyline polylineWithPoints:tempPoints count:count];
    //添加路线，绘图
    if(self.polyLine){
        [self.mapView addOverlay:self.polyLine];
    }
    // 清空 tempPoints 临时数组
    free(tempPoints);
    
    // 根据polyline设置地图范围
    //[self mapViewFitPolyLine:self.polyLine];
}

/**
 *  根据polyline设置地图范围
 *
 */


- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    
    //    if (polyLine.pointCount < 20 ) {
    //        self.mapView.zoomLevel = 20;
    //        [self.mapView setCenterCoordinate:[_locations lastObject].coordinate animated:YES];
    //        return;
    //    }
    
    //一个矩形的四边
    /** ltx: top left x */
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    
    
    
    BMKMapRect mapRect;
    mapRect.origin = BMKMapPointMake(ltX, ltY);
    mapRect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    // DDLogInfo(@"1coor:%lf-- %lf",_mapView.centerCoordinate.longitude,_mapView.centerCoordinate.latitude);
    [self.mapView setVisibleMapRect:mapRect ];
    //DDLogInfo(@"2coor:%lf-- %lf",_mapView.centerCoordinate.longitude,_mapView.centerCoordinate.latitude);
    
    ZLLog(@" region:%lf,%lf",_mapView.region.span.latitudeDelta,_mapView.region.span.longitudeDelta);
    
    CGPoint point = [self.mapView convertCoordinate:_locations.firstObject.coordinate toPointToView:self.mapView];
    if (16777215 == point.x) {
        [_mapView zoomOut];
    }
    [_mapView zoomOut];
    ZLLog(@"%@",NSStringFromCGPoint(point));
    ZLLog(@" region:%lf,%lf",_mapView.region.span.latitudeDelta,_mapView.region.span.longitudeDelta);
    
    
}


// Override
#pragma mark - BMKMapViewDelegate
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolyline class]]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = polylineColor;
        polylineView.lineWidth = polylineWidth;
        // polylineView.fillColor = [[UIColor clearColor] colorWithAlphaComponent:0.7];
        return polylineView;
    }
    return nil;
}
- (void)didFailToLocateUserWithError:(NSError *)error{
    ZLLog(@"error:%@",error);
}

/**
 *  添加一个大头针
 *
 */
- (BMKPointAnnotation *)creatPointWithLocaiton:(CLLocation *)location title:(NSString *)title;
{
    BMKPointAnnotation *point = [[BMKPointAnnotation alloc] init];
    point.coordinate = location.coordinate;
    point.title = title;
    [self.mapView addAnnotation:point];
    
    return point;
}

/**
 *  移除一个大头针
 *
 */
- (void)removePointWithLocaiton:(BMKPointAnnotation *)eventAnotation ;
{
    //    point.coordinate = location.coordinate;
    //    point.title = title;
    [self.mapView removeAnnotation:eventAnotation];
    
    //    return point;
}

/**
 *  只有在添加大头针的时候会调用，直接在viewDidload中不会调用
 *  根据anntation生成对应的View
 *  @param mapView 地图View
 *  @param annotation 指定的标注
 *  @return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *annotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        annotationView.annotation = annotation;
        if([[annotation title] isEqualToString:@"起点"]){ // 有起点旗帜代表应该放置终点旗帜（程序一个循环只放两张旗帜：起点与终点）
//            UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/baidu_startPoint.png"]]];
//            annotationView.image = imageV.image;
            annotationView.pinColor = BMKPinAnnotationColorGreen;
        }else if([[annotation title] isEqualToString:@"终点"]){
//            UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/baidu_endPoint.png"]]];
//            annotationView.image = imageV.image;
            annotationView.pinColor = BMKPinAnnotationColorRed;
        }else { // 没有起点旗帜，应放置起点旗帜
            annotationView.pinColor = BMKPinAnnotationColorPurple;
            
        }

        
        // 从天上掉下效果
        annotationView.animatesDrop = YES;
        
        // 不可拖拽
        annotationView.draggable = NO;
        
        return annotationView;
    }
    return nil;
}
- (NSString*)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}

/**
 *在地图View将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser
{
    ZLLog(@"start locate");
}


- (UIButton *)set_rightButton{
    
    UIImage *rightImage = [UIImage imageNamed:@"baidu_right"];
    //    UIImage* backItemHlImage = [[UIImage imageNamed:@"login_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
    //    [rightButton setBackgroundImage:rightImage forState:(UIControlStateNormal)];
    [rightButton setImage:rightImage forState:UIControlStateNormal];
    //    [rightButton sizeToFit];
    return rightButton;
    
    
}

- (void)right_button_event:(UIButton *)sender{

    if (_status == rivering) {
        
        //        [WJYAlertView showOneButtonWithTitle:@"提示" Message:@"巡河已经开始" ButtonType:(WJYAlertViewButtonTypeDefault) ButtonTitle:@"确定" Click:^{
        //
        //        }];
        //
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"巡河已经开始" cancelButtonName:@"确定" otherButtonTitles:nil,nil];
        return;
        
    }
    
    if (_status == endRiver) {
        
        //        [WJYAlertView showOneButtonWithTitle:@"提示" Message:@"巡河已经开始" ButtonType:(WJYAlertViewButtonTypeDefault) ButtonTitle:@"确定" Click:^{
        //
        //        }];
        //
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"巡河已经结束" cancelButtonName:@"确定" otherButtonTitles:nil,nil];
        return;
        
    }
    
    if (_isShowMaskview) {
        _riverView = [[ZLRiverSelectView alloc]initWithFrame:CGRectMake(0, 64, App_Frame_Width, App_Frame_Height - 64 + 20)titles:_riverSourceArray importOrNomal:@"1"];
        _riverView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [_riverView.maskView addGestureRecognizer:tap];
        
        
        __weak typeof(self) weakself = self;
        _riverView.selectedTitleBlock = ^(ZLRiverDemandModel *demandModel) {
            
            if ([demandModel.rivers_name isEqualToString:@"清除所有选项"]) {
                weakself.title = @"";
                ZLRiverDemandModel *demandModel = [[ZLRiverDemandModel alloc]init];
                demandModel.riverId = @"";
                demandModel.rivers_name = @"";
                demandModel.org_type = @"";
                demandModel.start_point_desc = @"";
                demandModel.end_point_desc = @"";
                _demandModel = demandModel;

                if (weakself.riverInfoView.alpha != 0) {
                    weakself.riverInfoView.alpha = 0;
                    
                    weakself.addOrSubView.transform = CGAffineTransformTranslate(weakself.addOrSubView.transform, 0, 90);
                    weakself.reportAndDown.transform = CGAffineTransformTranslate(weakself.reportAndDown.transform, 0, 90);
                    

                }
                
                
            }else{
                weakself.title = demandModel.rivers_name;
                weakself.riverInfoView.demandModel = demandModel;
                weakself.riverInfoView.startAddressLabel.text = demandModel.start_point_desc;
                weakself.riverInfoView.endAddressLabel.text = demandModel.end_point_desc;
                weakself.demandModel = demandModel;
                if (weakself.riverInfoView.alpha != 1) {
                    
                    weakself.riverInfoView.alpha = 1;
                    weakself.addOrSubView.transform = CGAffineTransformTranslate(weakself.addOrSubView.transform, 0, -90);
                    weakself.reportAndDown.transform = CGAffineTransformTranslate(weakself.reportAndDown.transform, 0, -90);

                }
            }
            [weakself tapClick];
            
        };
        [[UIApplication sharedApplication].keyWindow addSubview:_riverView];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _riverView.alpha = 1;
            
        } completion:^(BOOL finished) {
            
        }];
        
        _isShowMaskview = NO;
    }else{
        
        [_riverView removeFromSuperview];
        _isShowMaskview = YES;
    }

    
}

- (void)left_button_event:(UIButton *)sender{
    
    if (_status == rivering) {
        
        //        [WJYAlertView showOneButtonWithTitle:@"提示" Message:@"正在巡河中,请先结束巡河" ButtonType:(WJYAlertViewButtonTypeDefault) ButtonTitle:@"确定" Click:^{
        //
        //        }];
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"巡河还未结束,请先结束巡河" cancelButtonName:@"确定" otherButtonTitles:nil,nil];
        
        return;
    }
    
    [super left_button_event:sender];
    
    [_riverView removeFromSuperview];
    
    
}


/**
 点击消除遮罩
 */
- (void)tapClick{
    
    [_riverView removeFromSuperview];
    _isShowMaskview = YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    //    //内存警告时，移除内存大的
    //    NSRange range = NSMakeRange(0, removeObjectsLen);
    //    [_locationManager.locations removeObjectsInRange:range];
}



@end

