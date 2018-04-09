//
//  ZLGaodeViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/4.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLGaodeViewController.h"
#import "ZLMapManager.h"
#import "ZLGaodeBottomView.h"
#import "ZLGaodeRiverInfoView.h"
#import "ZLGaodeReportViewController.h"
#import "ZLGaodeDownTaskViewController.h"
#import "ZLEndCheckRiverService.h"
#import "FloatingWindow.h"
#import "AppDelegate.h"
#import "ZLGaodeCustomNavBar.h"
#import "DQAlertView.h"
#import "ZLRiverChangePopView.h"
#import "ZLRiverBilidChangeVC.h"
#import "ZLNewGaodeReportView.h"
#import "ZLRiverAddIntakeVC.h"
#import "ZLRiverAddOutletVC.h"
#import "ZLSavepatrolpointService.h"
#import "NSString+UUID.h"
#import "ZLNewLoginModel.h"
#import "ZLHomeRiverRunningModel.h"
#import "ZLGaodeDownTaskVC.h"
#import "ZLGaodeReportEventVC.h"
typedef enum : NSUInteger {
    noneRiver,// 没有河段
    endRiver,
    startRiver,
    rivering,
} riverStaus;

@interface ZLGaodeViewController ()<FloatingWindowTouchDelegate>

@property (nonatomic, strong) ZLMapManager *manager;
@property (nonatomic, strong) ZLGaodeBottomView *bottomButtonView;
// 放大或缩小
//@property (nonatomic, strong) ZLBaiduAddOrSubView *addOrSubView;

@property (nonatomic, strong) ZLGaodeRiverInfoView *riverInfoView;
@property (nonatomic, assign) riverStaus status;

//// 河长所拥有的河段
//@property (nonatomic, strong) ZLRiverDemandModel *demandModel;
// 是否已经结束巡河
@property (nonatomic, assign) BOOL isEndRiver;

@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;

@property (nonatomic, strong) MAMapView *mapView;

// 开始大头针
@property (nonatomic, strong) MAPointAnnotation *startAnnotation;

// 结束大头针
@property (nonatomic, strong) MAPointAnnotation *endAnnotation;

// 上报的事件大头针
@property (nonatomic, weak) MAPointAnnotation *eventAnnotation;

@property (nonatomic, strong) YTKKeyValueStore *store;

@property (nonatomic, strong) UIButton *changeBtn;


@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *patrolCode;

@property (nonatomic, strong) NSMutableArray *eventAndTaskArray;

@property (nonatomic, strong) NSMutableArray *eventPointArray;
@property (nonatomic, strong) NSMutableArray *taskPointArray;
@end

@implementation ZLGaodeViewController

-(void)assistiveTocuhs {
    
    AppDelegate *deleage = (AppDelegate *)[UIApplication sharedApplication].delegate;
    deleage.floatWindow.isCannotTouch = NO;
    //    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self];
    //    navigationController.navigationBar.hidden = YES;
    //    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:navigationController animated:NO completion:^{
    //
    //    }];
//        [deleage.floatWindow close];
    
}

/**
 得到用户数据
 */
- (void)getUserModelData{
    
//    self.store = [[ZLDBStoreManager shareDbStoreManager]createDB];
    self.store = [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
    NSString *tableName = DBUserTable;
    [self.store createTableWithName:tableName];
    
    [self.store createTableWithName:DBMapTable];
    
    NSString *loginString = [self.store getStringById:DBLoginModel fromTable:DBUserTable];
    
    ZLNewLoginModel *userModel = [[ZLNewLoginModel alloc]initWithString:loginString error:nil];
    //               {"code":0,"detail":"成功","data":{"areaCode":"32","userName":"admin","userId":"10000","token":"6605b805-4efc-45b6-ae7e-26271c963fe0"}}

    if ([userModel.code isEqualToString:@"0"]) {
        
        self.userId = userModel.data.userId;
        self.userName = userModel.data.userName;
    }
    
}



- (void)setUpUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    ZLGaodeCustomNavBar *navBar = [[ZLGaodeCustomNavBar alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, TopBarHeight)];
    navBar.titleLabel.text = _riverDataModel.riverName;
    [navBar.backButton addTarget:self action:@selector(backClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:navBar];
    
    navBar.backgroundColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    
    //    _status = startRiver;
    _bottomButtonView = [[ZLGaodeBottomView alloc]init];
    
    [_bottomButtonView.startAndEndButton addTarget:self action:@selector(startAndEndClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_bottomButtonView.reportButton addTarget:self action:@selector(reportClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_bottomButtonView.downTaskButton addTarget:self action:@selector(downTaskClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:_bottomButtonView];
    
    _bottomButtonView.frame = CGRectMake(0, Main_Screen_Height - AdaptedHeight(115) , Main_Screen_Width, AdaptedHeight(115));
    
    _riverInfoView = [[ZLGaodeRiverInfoView alloc]init];
    _riverInfoView.demandModel = self.riverDataModel;
    [self.view addSubview:_riverInfoView];
    
    _riverInfoView.frame = CGRectMake(0, CGRectGetMinY(_bottomButtonView.frame) - 90, Main_Screen_Width, 90);
    
    
    _mapView = self.manager.mapView;
    [self.view addSubview:_mapView];
    
    _mapView.frame =CGRectMake(0, TopBarHeight, Main_Screen_Width, Main_Screen_Height - TopBarHeight - CGRectGetHeight(_riverInfoView.frame) - CGRectGetHeight(_bottomButtonView.frame));
    
    _changeBtn = [[UIButton alloc]init];
    [_changeBtn setImage:[UIImage imageNamed:@"map_change"] forState:(UIControlStateNormal)];
    [_changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_changeBtn];
    
    _changeBtn.frame = CGRectMake(Main_Screen_Width - 60, TopBarHeight + 50, 50, 50);
    
    [self.view bringSubviewToFront:_riverInfoView];
    [self.view bringSubviewToFront:_bottomButtonView];
    [self.view bringSubviewToFront:_changeBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getUserModelData];
    
    self.manager = [[ZLMapManager alloc]init];
    [self setUpUI];
    self.manager.startSavePoint = NO;
    [self.manager startLocation];

    [self getDBData];
}


/**
 从数据库中得到点位数据,目的是还原上次的记录
 */
- (void)getDBData{
    
    self.eventAndTaskArray = [NSMutableArray array];
    
//    self.eventPointArray = [NSMutableArray array];
    NSMutableArray *taskArray = [self.store getObjectById:@"taskPointArray" fromTable:DBMapTable];
    
    NSMutableArray *eventArray = [self.store getObjectById:@"eventPointArray" fromTable:DBMapTable];
    
    if (taskArray.count > 0) {
        self.taskPointArray = taskArray;
        
        for (int i = 0; i < taskArray.count; i++) {
            
            NSDictionary *dic = taskArray[i];
            
            [self createStart:dic[@"latitude"] AndEndPoint:dic[@"longitude"] withTitle:@"下发任务"];
            
        }
    }else{
        self.taskPointArray = [NSMutableArray array];
    }
    if (eventArray.count > 0) {
        self.eventPointArray = eventArray;
        
        for (int i = 0; i < eventArray.count; i++) {
            
            NSDictionary *dic = eventArray[i];
            
            [self createStart:dic[@"latitude"] AndEndPoint:dic[@"longitude"] withTitle:@"上报案件"];
        }
    }else{
        self.eventPointArray = [NSMutableArray array];
    }
    
    [_mapView addAnnotations:self.eventAndTaskArray];
    
    
//    [self.store putObject:_manager.locationsAndAddress withId:DBAddress intoTable:DBMapTable];
    NSArray *addressArray = [self.store getObjectById:DBAddress fromTable:DBMapTable];
    NSDictionary *startDic = [self.store getObjectById:@"startAnnotation" fromTable:DBMapTable];
    NSString *runningString = [self.store getStringById:DBRunningModel fromTable:DBMapTable];
    if (runningString.length > 0) {
        CLLocationCoordinate2D commonPolylineCoords[addressArray.count];
        for (int i = 0; i < addressArray.count; i++) {
            NSDictionary *dic = addressArray[i];
            ZLLog(@"%f",[dic[@"latitude"] floatValue]);
            
            commonPolylineCoords[i].latitude = [dic[@"latitude"] floatValue];
            commonPolylineCoords[i].longitude = [dic[@"longitude"] floatValue];
        }
        
        //构造折线对象
        MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:addressArray.count];
        
        //在地图上添加折线对象
        [_mapView addOverlay: commonPolyline];
        
        _startAnnotation = [[MAPointAnnotation alloc] init];
        _startAnnotation.coordinate = CLLocationCoordinate2DMake([startDic[@"latitude"] floatValue], [startDic[@"longitude"] floatValue]);
        _startAnnotation.title = @"起点";
        _startAnnotation.subtitle = @"1";
        
        [_mapView addAnnotation:_startAnnotation];
        
        self.manager.startSavePoint = YES;
        [self.manager startLocation];
        
        [self.bottomButtonView.startAndEndButton setTitle:@"结束巡河" forState:(UIControlStateNormal)];
        [self.bottomButtonView.startAndEndButton setImage:[UIImage imageNamed:@"GaodeEndRiver"] forState:(UIControlStateNormal)];
        [self.bottomButtonView.startAndEndButton setBackgroundColor:HEXCOLOR(0xf29503)];
        
        self.patrolCode = [self.store getStringById:@"patrolCode" fromTable:DBMapTable];
    }
    
}

// 创建上报的点
- (void)createStart:(NSString *)latitude AndEndPoint:(NSString *)longitude withTitle:(NSString *)title{

    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    pointAnnotation.title = title;

    [self.eventAndTaskArray addObject:pointAnnotation];


    //    [_mapView addAnnotation:pointAnnotation];
}

/**
 修改项
 */
- (void)changeBtnClick{
     __weak typeof(self) weakSelf = self;
    ZLRiverChangePopView *popView = [[ZLRiverChangePopView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    
    popView.collectionView.centerItemBlock = ^(ZLHomeCenterCollectionModel *model, NSIndexPath *indexpath) {
        
        if ([model.title isEqualToString:@"公示牌"]) {
            ZLRiverBilidChangeVC *vc = [[ZLRiverBilidChangeVC alloc]init];
            
            ZLMapLocationModel *location = weakSelf.manager.locationModel;
            vc.locationModel = location;
            vc.riverDataModel = _riverDataModel;
            [weakSelf presentViewController:vc animated:YES completion:nil];
            
        }
        
        if ([model.title isEqualToString:@"取水口"]) {
            ZLRiverAddIntakeVC *vc = [[ZLRiverAddIntakeVC alloc]init];
            vc.riverDataModel = _riverDataModel;
            ZLMapLocationModel *location = weakSelf.manager.locationModel;
            vc.locationModel = location;
            [weakSelf presentViewController:vc animated:YES completion:nil];
        }
        
        if ([model.title isEqualToString:@"排污口"]) {
            ZLRiverAddOutletVC *vc = [[ZLRiverAddOutletVC alloc]init];
            vc.riverDataModel = _riverDataModel;
            ZLMapLocationModel *location = weakSelf.manager.locationModel;
            vc.locationModel = location;
            [weakSelf presentViewController:vc animated:YES completion:nil];
        }
        
    };
    
    [self.view addSubview:popView];
    
}

- (void)backClick:(UIButton *)button{
    
    AppDelegate *deleage = (AppDelegate *)[UIApplication sharedApplication].delegate;
    deleage.floatWindow.isCannotTouch = NO;
    __weak typeof (self) weakSelf = self;
    deleage.floatWindow.floatDelegate = weakSelf;
    
//    deleage.floatWindow.rootViewController = self;
    
    if([[self.bottomButtonView.startAndEndButton currentTitle] isEqualToString:@"开始巡河"]){
        [deleage.floatWindow close];
        [deleage.floatWindow resignKeyWindow];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"RiverRunningEnd" object:nil];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }else{
        [deleage.floatWindow startWithTime:0 presentview:self.view inRect:CGRectMake(0, Main_Screen_Height, 0, 0) withRiverTitle:self.riverDataModel.riverName];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"RiverRunning" object:nil];
        [self dismissViewControllerAnimated:NO completion:^{
        }];
    }
}

/**
 上报案件
 */
- (void)reportClick:(UIButton *)button{
    if (_status == endRiver) {

        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {

        } title:@"提示" message:@"巡河已经结束,无法上报" cancelButtonName:@"确定" otherButtonTitles:nil, nil];

    }else if([[self.bottomButtonView.startAndEndButton currentTitle] isEqualToString:@"开始巡河"]){

        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {

        } title:@"提示" message:@"还未开始巡河,无法上报" cancelButtonName:@"确定" otherButtonTitles:nil, nil];

        return;
    }else{
        __weak typeof(self) weakSelf = self;
//        ZLGaodeReportViewController *reportVC = [[ZLGaodeReportViewController alloc]initWithShowFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - App_Frame_Height * 0.9, [UIScreen mainScreen].bounds.size.width, App_Frame_Height * 0.9) ShowStyle:(MYPresentedViewShowStyleFromBottomSpreadStyle) callback:^(id callback) {
//
//            if ([callback isEqualToString:@"确定"]) {
//                weakSelf.eventAnnotation = [self creatPointWithLocaiton:self.manager.mapView.userLocation.location title:@"上报案件"];
//            }
//        }];
//        reportVC.clearBack = YES;
//
//        reportVC.demandModel = self.riverDataModel;
//        reportVC.uid = _uid;
//        reportVC.type = _type;
//        reportVC.uuid = _uuid;
//        reportVC.location = _manager.mapView.userLocation.location;

        ZLGaodeReportEventVC *reportVC = [[ZLGaodeReportEventVC alloc]initWithShowFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - App_Frame_Height * 0.7, [UIScreen mainScreen].bounds.size.width, App_Frame_Height * 0.7) ShowStyle:(MYPresentedViewShowStyleFromBottomSpreadStyle) callback:^(id callback) {
            
            if ([callback isEqualToString:@"确定"]) {
                weakSelf.eventAnnotation = [self creatPointWithLocaiton:self.manager.mapView.userLocation.location title:@"上报案件"];
                
                NSDictionary *pointDic = [NSDictionary dictionaryWithObjects:@[@(weakSelf.eventAnnotation.coordinate.latitude), @(weakSelf.eventAnnotation.coordinate.longitude), @"上报案件"] forKeys:@[@"latitude",@"longitude", @"type"]];
                
                [self.eventPointArray addObject:pointDic];
                
                [self.store putObject:self.eventPointArray withId:@"eventPointArray" intoTable:DBMapTable];
                
                
            }
        }];
        
        ZLMapLocationModel *location = weakSelf.manager.locationModel;
        
        reportVC.locationModel = location;
        
        reportVC.userRiverModel = self.riverDataModel;
        reportVC.patrolCode = self.patrolCode;
        
        
        [self presentViewController:reportVC animated:YES completion:nil];
    }
}

/**
 下发案件
 */
- (void)downTaskClick:(UIButton *)button{
    
    if (_status == endRiver) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"巡河已经结束,无法下发" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
    }else if([[self.bottomButtonView.startAndEndButton currentTitle] isEqualToString:@"开始巡河"]){
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"还未开始巡河,无法下发" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
        return;
    }else{
        __weak typeof(self) weakSelf = self;
//        ZLGaodeDownTaskViewController *downVC = [[ZLGaodeDownTaskViewController alloc]initWithShowFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - App_Frame_Height * 0.9, [UIScreen mainScreen].bounds.size.width, App_Frame_Height * 0.9) ShowStyle:(MYPresentedViewShowStyleFromBottomSpreadStyle) callback:^(id callback) {
//
//            if ([callback isEqualToString:@"确定"]) {
//                weakSelf.eventAnnotation = [self creatPointWithLocaiton:self.manager.mapView.userLocation.location title:@"下发任务"];
//
//            }
//        }];
        
//        downVC.demandModel = self.riverDataModel;
//        downVC.uid = _uid;
//        downVC.type = _type;
//        downVC.uuid = _uuid;
//        downVC.location = self.manager.mapView.userLocation.location;
        
        ZLGaodeDownTaskVC *downVC = [[ZLGaodeDownTaskVC alloc]initWithShowFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - App_Frame_Height * 0.7, [UIScreen mainScreen].bounds.size.width, App_Frame_Height * 0.7) ShowStyle:(MYPresentedViewShowStyleFromBottomSpreadStyle) callback:^(id callback) {
            
            if ([callback isEqualToString:@"确定"]) {
                weakSelf.eventAnnotation = [self creatPointWithLocaiton:self.manager.mapView.userLocation.location title:@"下发任务"];

                NSDictionary *pointDic = [NSDictionary dictionaryWithObjects:@[@(weakSelf.eventAnnotation.coordinate.latitude), @(weakSelf.eventAnnotation.coordinate.longitude), @"下发任务"] forKeys:@[@"latitude",@"longitude", @"type"]];
                
                [self.taskPointArray addObject:pointDic];
                
                [self.store putObject:self.eventPointArray withId:@"taskPointArray" intoTable:DBMapTable];
                
            }
        }];
        
        ZLMapLocationModel *location = weakSelf.manager.locationModel;
        
        downVC.locationModel = location;
        downVC.patrolCode = self.patrolCode;
        downVC.userRiverModel = self.riverDataModel;
        
        if (self.presentedViewController) {
            //要先dismiss结束后才能重新present否则会出现Warning: Attempt to present <UINavigationController: 0x7fdd22262800> on <UITabBarController: 0x7fdd21c33a60> whose view is not in the window hierarchy!就会present不出来登录页面
            [self.presentedViewController dismissViewControllerAnimated:NO completion:^{
                [self presentViewController:downVC animated:YES completion:nil];
            }];
        }else {
            [self presentViewController:downVC animated:YES completion:nil];
        }
    }
}


/**
 开始和结束巡河
 */
- (void)startAndEndClick:(UIButton *)button{
    if([[button currentTitle] isEqualToString:@"开始巡河"]){
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                // 得到当前的时间戳
                _startTime = [self getCurrenttTimer];
                
                NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[self.userName, self.riverDataModel.riverName, _startTime, self.riverDataModel.toJSONString] forKeys:@[@"userName",@"riverTitle",@"time",@"riverData"]];
                
                ZLHomeRiverRunningModel *runningModel = [[ZLHomeRiverRunningModel alloc]initWithDictionary:dic error:nil];
                
                [self.store putString:runningModel.toJSONString withId:DBRunningModel intoTable:DBMapTable];
                
                // 放置起点旗帜
                if (!_startAnnotation) {
                    self.manager.startSavePoint = YES;
                    [self.manager startLocation];
                    _startAnnotation = [self creatPointWithLocaiton:self.manager.mapView.userLocation.location title:@"起点"];
                    _status = rivering;
                    
                    [button setTitle:@"结束巡河" forState:(UIControlStateNormal)];
                    [button setImage:[UIImage imageNamed:@"GaodeEndRiver"] forState:(UIControlStateNormal)];
                    [button setBackgroundColor:HEXCOLOR(0xf29503)];
                    
                    NSDictionary *startDic = [NSDictionary dictionaryWithObjects:@[@(_startAnnotation.coordinate.latitude), @(_startAnnotation.coordinate.longitude)] forKeys:@[@"latitude",@"longitude"]];
                    
                    [self.store putObject:startDic withId:@"startAnnotation" intoTable:DBMapTable];
                    self.patrolCode = [NSString stringWithFormat:@"%@%@",[[self getCurrenttTimer] substringWithRange:NSMakeRange(2, 3)],[NSString UUID]];
                     [self.store putString:self.patrolCode withId:@"patrolCode" intoTable:DBMapTable];
                }else{
                    
                    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                        
                    } title:@"提示" message:@"巡河已经开始" cancelButtonName:@"确定" otherButtonTitles:nil,nil];
                    
                }
            }
            
        } title:@"提示" message: [NSString stringWithFormat:@"当前已选择%@,是否确定开始巡河", _riverDataModel.riverName] cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
    }else if ([[button currentTitle] isEqualToString:@"结束巡河"]){
//        __weak typeof(self) weakSelf = self;
        
        DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:@"提示" message:@"是否确定结束巡河" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView actionWithBlocksCancelButtonHandler:^{
            
        } otherButtonHandler:^{
            // 得到结束的时间戳
            _endTime = [self getCurrenttTimer];
            
            [self endRiverService:button];
        }];
        [alertView show];
        
//        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
//            
//            if (buttonIndex == 1) {
//                // 得到结束的时间戳
//                _endTime = [self getCurrenttTimer];
//                
//                [weakSelf endRiverService:button];
//            }
//        } title:@"提示" message:@"是否确定结束巡河" cancelButtonName:@"取消" otherButtonTitles:@"确定",nil];
    }
    
}

/**
 巡河结束上报服务
 */
- (void)endRiverService:(UIButton *)button{
    
    NSArray *addressArray = [self.store getObjectById:DBAddress fromTable:DBMapTable];
//    NSDictionary *startDics = [self.store getObjectById:@"startAnnotation" fromTable:DBMapTable];
    
    
    NSDictionary *startDic = addressArray.firstObject;
    
    NSDictionary *endDic = addressArray.lastObject;

    NSString *runningString = [self.store getStringById:DBRunningModel fromTable:DBMapTable];
    
    if (runningString.length > 0) {
        ZLHomeRiverRunningModel *runningModel = [[ZLHomeRiverRunningModel alloc]initWithString:runningString error:nil];

        _startTime = runningModel.time;
    }
    
    ZLSavepatrolpointService *endService = [[ZLSavepatrolpointService alloc]initWithpatrolCode:self.patrolCode userCode:self.userId riverCode:_riverDataModel.riverCode startTime:_startTime endTime:_endTime startLongitude:startDic[@"longitude"] startLatitude:startDic[@"latitude"] endLongitude:endDic[@"longitude"] endLatitude:endDic[@"latitude"] list:addressArray];
    [SVProgressHUD showWithStatus:@"结束巡河中"];
    
    //    __weak typeof(self) weakSelf = self;
    [endService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSDictionary *dic = request.responseObject;
        
        ZLBaseModel *baseModel = [[ZLBaseModel alloc]initWithDictionary:dic error:nil];
        
        
        if ([baseModel.code isEqualToString:@"0"]) {
            _isEndRiver = YES;
            self.manager.startSavePoint = NO;
            [self.manager endLocation];
            _status = endRiver;
            [SVProgressHUD showSuccessWithStatus:@"结束巡河成功"];
            [SVProgressHUD dismissWithDelay:0.3 completion:^{
                // 放置终点旗帜
                if (_startAnnotation) {
                    _endAnnotation  = [self creatPointWithLocaiton:_manager.mapView.userLocation.location title:@"终点"];
                    
                    [button setTitle:@"开始巡河" forState:(UIControlStateNormal)];
                    [button setImage:[UIImage imageNamed:@"GaodeStartRiver"] forState:(UIControlStateNormal)];
                    [button setBackgroundColor:[UIColor grayColor]];
                    button.enabled = NO;
                    
//                    [self.store deleteObjectsByIdArray:@[@"patrolCode",
//                                                         @"userCode",
//                                                         @"riverCode",
//                                                         @"startTime",
//                                                         @"endTime",
//                                                         @"startLongitude",
//                                                         @"startLatitude",
//                                                         @"endLongitude",
//                                                         @"endLatitude",
//                                                         DBAddress,
//                                                         DBRunningModel
//                                                         ] fromTable:DBMapTable];
                    
                    [self.store clearTable:DBMapTable];
                    
                }
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:baseModel.detail];
            [SVProgressHUD dismissWithDelay:0.3];
            
        }
        
        ZLLog(@"%@",request.responseObject);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.store putString:self.patrolCode withId:@"patrolCode" intoTable:DBMapTable];
        [self.store putString:self.userId withId:@"userCode" intoTable:DBMapTable];
        [self.store putString:_riverDataModel.riverCode withId:@"riverCode" intoTable:DBMapTable];
        [self.store putString:_startTime withId:@"startTime" intoTable:DBMapTable];
        [self.store putString:_endTime withId:@"endTime" intoTable:DBMapTable];
        [self.store putString:startDic[@"longitude"] withId:@"startLongitude" intoTable:DBMapTable];
        [self.store putString:startDic[@"latitude"] withId:@"startLatitude" intoTable:DBMapTable];
        [self.store putString:endDic[@"longitude"] withId:@"endLongitude" intoTable:DBMapTable];
        [self.store putString:endDic[@"latitude"] withId:@"endLatitude" intoTable:DBMapTable];
//        [self.store putObject:_manager.locationsAndAddress withId:DBAddress intoTable:DBMapTable];
        
        [SVProgressHUD showErrorWithStatus:@"结束巡河失败 请检查网络"];
        [SVProgressHUD dismissWithDelay:0.3];
        
    }];
    
    
    
    
//    ZLEndCheckRiverService *endService = [[ZLEndCheckRiverService alloc]initWithuid:_uid uuid:_uuid riverId:_riverDataModel.riverCode startTime:_startTime endTime:_endTime type:_type batchData: _manager.locationsAndAddress];
//    [SVProgressHUD showWithStatus:@"结束巡河中"];
//
//    //    __weak typeof(self) weakSelf = self;
//    [endService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//        NSDictionary *dic = request.responseObject;
//        if ([dic[@"code"] isEqualToString:@"0"]) {
//            _isEndRiver = YES;
//
//            [self.manager endLocation];
//            _status = endRiver;
//            [SVProgressHUD showSuccessWithStatus:@"结束巡河成功"];
//            [SVProgressHUD dismissWithDelay:0.3 completion:^{
//                // 放置终点旗帜
//                if (_startAnnotation) {
//                    _endAnnotation  = [self creatPointWithLocaiton:_manager.mapView.userLocation.location title:@"终点"];
//
//                    [button setTitle:@"开始巡河" forState:(UIControlStateNormal)];
//                    [button setImage:[UIImage imageNamed:@"GaodeStartRiver"] forState:(UIControlStateNormal)];
//                    [button setBackgroundColor:HEXCOLOR(KNavBarBG_color_blue)];
//
//
//                    [self.store deleteObjectsByIdArray:@[@"uid",
//                                                         @"uuid",
//                                                         @"riverId",
//                                                         @"startTime",
//                                                         @"endTime",
//                                                         @"type",
//                                                         DBAddress
//                                                         ] fromTable:DBMapTable];
//                }
//            }];
//        }else{
//
////            [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
////                if (buttonIndex == 1) {
////                    // 得到结束的时间戳
////                    _endTime = [self getCurrenttTimer];
////
////                    [self endRiverService:button];
////                }
////            } title:@"提示" message:@"结束巡河失败,点击重试" cancelButtonName:@"取消" otherButtonTitles:@"确定",nil];
//
//            [SVProgressHUD showErrorWithStatus:@"结束巡河失败"];
//            [SVProgressHUD dismissWithDelay:0.3];
//
//        }
//
//        ZLLog(@"%@",request.responseObject);
//
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        [self.store putString:_uid withId:@"uid" intoTable:DBMapTable];
//        [self.store putString:_uuid withId:@"uuid" intoTable:DBMapTable];
//        [self.store putString:_riverDataModel.riverCode withId:@"riverId" intoTable:DBMapTable];
//        [self.store putString:_startTime withId:@"startTime" intoTable:DBMapTable];
//        [self.store putString:_endTime withId:@"endTime" intoTable:DBMapTable];
//        [self.store putString:_type withId:@"type" intoTable:DBMapTable];
//        [self.store putObject:_manager.locationsAndAddress withId:DBAddress intoTable:DBMapTable];
//
//        [SVProgressHUD showErrorWithStatus:@"结束巡河失败 请检查网络"];
//        [SVProgressHUD dismissWithDelay:0.3];
//
//    }];
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


/**
 *  添加一个大头针
 *
 */
- (MAPointAnnotation *)creatPointWithLocaiton:(CLLocation *)location title:(NSString *)title;
{
    MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
    point.coordinate = location.coordinate;
    point.title = title;
    [self.mapView addAnnotation:point];
    
    return point;
}

- (void)left_button_event:(UIButton *)sender{
    
//    self.view.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    [self backClick:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
