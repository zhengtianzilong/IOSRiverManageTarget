//
//  ZLGaodeDetailViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/20.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLGaodeDetailViewController.h"
#import "ZLGaodeEventDetailViewController.h"

#import "ZLGetPatrolCoordinateIncidentTaskService.h"
#import "ZLRiverRecordAllPointModel.h"
#import "ZLMyEventDetailVC.h"
@interface ZLGaodeDetailViewController ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) NSMutableArray *allPointArray;

@property (nonatomic, strong) NSMutableArray *eventAllPointArray;

@property (nonatomic, strong) NSMutableArray *taskAllPointArray;


@end

@implementation ZLGaodeDetailViewController

- (void)getData {
    ZLGetPatrolCoordinateIncidentTaskService *service = [[ZLGetPatrolCoordinateIncidentTaskService alloc]initWithpartolCode:self.recordModel.PATROL_CODE];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLRiverRecordAllPointModel *model = [[ZLRiverRecordAllPointModel alloc]initWithString:request.responseString error:nil];

        if ([model.code isEqualToString:@"0"]) {
            
            if (model.data.RiverIncident.count > 0) {
                
                for (int i = 0 ; i < 2 ; i++) {

                    if (i == 0) {
                        [self createStart:@"32.832136" AndEndPoint:@"118.34095" withTitle:@"上报" withTag:[NSString stringWithFormat:@"%d",i]];
                    }else{
                         [self createStart:@"32.902136" AndEndPoint:@"116.42095" withTitle:@"上报" withTag:[NSString stringWithFormat:@"%d",i]];
                    }
//                    ZLRiverIncidentDetailModel *dataModel = (ZLRiverIncidentDetailModel *)model.data.RiverIncident[i];

//                    [self.eventAllPointArray addObject:dataModel];
            
                [_mapView addAnnotations:self.eventAllPointArray];
                }
            
            }
            
//            if (model.data.PatrolCoordinate.count < 0) {
//                 CLLocationCoordinate2D commonPolylineCoords[model.data.PatrolCoordinate.count];
//                for (int i = 0; i < model.data.PatrolCoordinate.count; i++) {
//                    ZLPatrolCoordinateModel *pointModel = (ZLPatrolCoordinateModel *)model.data.PatrolCoordinate[i];
//                    commonPolylineCoords[i].latitude = [pointModel.latitude doubleValue];
//                    commonPolylineCoords[i].longitude = [pointModel.longitude doubleValue];
//
//                    [self.allPointArray addObject:pointModel];
//                }
                    CLLocationCoordinate2D commonPolylineCoords[4];
                    commonPolylineCoords[0].latitude = 32.832136;
                    commonPolylineCoords[0].longitude = 118.34095;
                
                    commonPolylineCoords[1].latitude = 32.832136;
                    commonPolylineCoords[1].longitude = 118.42095;
                
                    commonPolylineCoords[2].latitude = 32.902136;
                    commonPolylineCoords[2].longitude = 118.42095;
                
                    commonPolylineCoords[3].latitude = 32.902136;
                    commonPolylineCoords[3].longitude = 118.44095;
                
                //构造折线对象
                MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:4];
                
                //在地图上添加折线对象
                [_mapView addOverlay: commonPolyline];
            
            _mapView.centerCoordinate = commonPolylineCoords[0];
//            }

            if (true) {
                
                for (int i = 0 ; i < 2 ; i++) {
                    
                    if (i == 0) {
                        [self createDownStart:@"39.902136" AndEndPoint:@"116.44095" withTitle:@"下发" withTag:[NSString stringWithFormat:@"%d",i]];
                    }else{
                        [self createDownStart:@"39.832136" AndEndPoint:@"116.42095" withTitle:@"下发" withTag:[NSString stringWithFormat:@"%d",i]];
                    }
                    //                    ZLRiverIncidentDetailModel *dataModel = (ZLRiverIncidentDetailModel *)model.data.RiverIncident[i];
                    
                    //                    [self.eventAllPointArray addObject:dataModel];
                    
                    [_mapView addAnnotations:self.taskAllPointArray];
                }
            }
            
            [self.mapView reloadMap];
            
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allPointArray = [NSMutableArray array];
    self.taskAllPointArray = [NSMutableArray array];
    self.eventAllPointArray = [NSMutableArray array];
    
    [self getData];

    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
//    //构造折线数据对象
//    CLLocationCoordinate2D commonPolylineCoords[4];
//    commonPolylineCoords[0].latitude = 39.832136;
//    commonPolylineCoords[0].longitude = 116.34095;
//
//    commonPolylineCoords[1].latitude = 39.832136;
//    commonPolylineCoords[1].longitude = 116.42095;
//
//    commonPolylineCoords[2].latitude = 39.902136;
//    commonPolylineCoords[2].longitude = 116.42095;
//
//    commonPolylineCoords[3].latitude = 39.902136;
//    commonPolylineCoords[3].longitude = 116.44095;
//
//    //构造折线对象
//    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:4];
//
//    //在地图上添加折线对象
//    [_mapView addOverlay: commonPolyline];
    
//    [self createStartAndEndPoint];
    
    
    
}

// 创建上报的点
- (void)createStart:(NSString *)latitude AndEndPoint:(NSString *)longitude withTitle:(NSString *)title withTag:(NSString *)tag{
        
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    pointAnnotation.title = title;
    pointAnnotation.subtitle = tag;

    [self.eventAllPointArray addObject:pointAnnotation];
    
    
//    [_mapView addAnnotation:pointAnnotation];
}

// 创建下发的点
- (void)createDownStart:(NSString *)latitude AndEndPoint:(NSString *)longitude withTitle:(NSString *)title withTag:(NSString *)tag{
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    pointAnnotation.title = title;
    pointAnnotation.subtitle = tag;
    
    [self.taskAllPointArray addObject:pointAnnotation];
    
    
    //    [_mapView addAnnotation:pointAnnotation];
}





- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor redColor];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
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
        
        if([[annotation title] isEqualToString:@"下发"]){ // 有起点旗帜代表应该放置终点旗帜（程序一个循环只放两张旗帜：起点与终点）
            annotationView.image = [UIImage imageNamed:@"map_startPoint.png"];
            
        }
        if([[annotation title] isEqualToString:@"上报"]){
            annotationView.image = [UIImage imageNamed:@"map_endPoint"];
        }
        
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        annotationView.userInteractionEnabled = YES;
        [annotationView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)]];
        return annotationView;
    }
    
    
    
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
//        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
//        }
//        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
//        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
//        annotationView.draggable = NO;        //设置标注可以拖动，默认为NO
//        annotationView.pinColor = MAPinAnnotationColorPurple;
//
//        [annotationView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)]];
//
//        return annotationView;
//    }
    return nil;
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    
    MAPinAnnotationView  *annotationView = (MAPinAnnotationView *)tap.view;
    
    ZLLog(@"%@,%@", annotationView.annotation.title, annotationView.annotation.subtitle);
    
    
    // 0, [UIScreen mainScreen].bounds.size.height - App_Frame_Height * 0.9, [UIScreen mainScreen].bounds.size.width, App_Frame_Height * 0.9
    ZLGaodeEventDetailViewController *vc = [[ZLGaodeEventDetailViewController alloc]initWithShowFrame:CGRectMake(0, Main_Screen_Height - 200, Main_Screen_Width, 200) ShowStyle:(MYPresentedViewShowStyleFromBottomSpreadStyle) callback:nil];
    
    vc.index = [annotationView.annotation.subtitle integerValue];
    
    __weak typeof(self) weakSelf = self;
    vc.callback = ^(id callback) {
        
        ZLMyEventDetailVC *vc = [[ZLMyEventDetailVC alloc]init];
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    
    
    
    vc.scrollBlock = ^(NSInteger index) {
        MAPointAnnotation *annotation = (MAPointAnnotation *)weakSelf.eventAllPointArray[index];
        weakSelf.mapView.centerCoordinate = annotation.coordinate;
        
        ZLLog(@"%ld",index);
        
    };
    
    [self presentViewController:vc animated:YES completion:nil];
    
    
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"巡河详情" attributes:dic];
    return title;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
