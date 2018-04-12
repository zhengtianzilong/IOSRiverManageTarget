//
//  ZLSimpleHomeMainVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/9.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLSimpleHomeMainVC.h"
#import "ZLSimpleHomeView.h"
#import "ZLRiverRecordVC.h"
#import "ZLEventManagerVC.h"
#import "ZLTaskManagerVC.h"
#import "ZLNewLoginModel.h"
#import "ZLAlertSelectionView.h"
#import "ZLNewUserRiversModel.h"
#import "ZLGaodeViewController.h"
#import "AppDelegate.h"
#import "ZLHomeRiverRunningModel.h"
#import "ZLNewUserRiversDataModel.h"
#import "ZLHomeAddButtonMaskView.h"
#import "ZLNewEventReportVC.h"
#import "ZLNewTaskDownVC.h"

#import "ZLNewGetUserRiversService.h"
#import "ZLGetUserListByIncidentService.h"
#import "ZLGetDepartmentListByIncidentService.h"
#import "ZLGetUserListByTaskNormalService.h"
#import "ZLGetDepartmentListByTaskService.h"
#import "ZLGetEventUserListModel.h"
#import "ZLGetDepartModel.h"


@interface ZLSimpleHomeMainVC ()

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) ZLSimpleHomeView *simpleHomeView;
@property (nonatomic, strong) YTKKeyValueStore *store;

@property (nonatomic, strong) NSMutableArray *riversTitleArray;

@property (nonatomic, strong) NSMutableArray *riversModelArray;
@property (nonatomic, strong) ZLNewLoginModel *loginModel;

@property (nonatomic, assign) BOOL isHideRunningView;

@property (nonatomic, strong) ZLHomeAddButtonMaskView *maskView;

@end

@implementation ZLSimpleHomeMainVC

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:@"RiverRunning"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"RiverRunningEnd"];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(handleShow) name:@"RiverRunning" object:nil];
    
    [nc addObserver:self selector:@selector(handleHide) name:@"RiverRunningEnd" object:nil];
    
}

- (void)handleHide{
    
    self.isHideRunningView = YES;
    
}


- (void)handleShow{
    
    self.isHideRunningView = NO;
    
}



/**
 得到河道数据
 */
- (void)getRiversData{
    
    self.riversTitleArray = [NSMutableArray array];
    
    self.riversModelArray = [NSMutableArray array];
    
    self.store = [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
    
    NSString *tableName = DBUserTable;
    
    [self.store createTableWithName:tableName];
    NSString *rivers = [self.store getStringById:DBUserRivers fromTable:DBUserTable];
    
    ZLNewUserRiversModel *riversModel = [[ZLNewUserRiversModel alloc]initWithString:rivers error:nil];
    
    NSString *userModel = [self.store getStringById:DBLoginModel fromTable:DBUserTable];
    
    _loginModel = [[ZLNewLoginModel alloc]initWithString:userModel error:nil];
    
    if (riversModel.data.count > 0) {
        
        for (ZLNewUserRiversDataModel *riverDataModel in riversModel.data ) {
            
            [self.riversTitleArray addObject:riverDataModel.riverName];
            
            [self.riversModelArray addObject:riverDataModel];
            
        }
        
    }
    
}

- (void)getAllData{
    ZLGetUserListByIncidentService *getUserListService = [[ZLGetUserListByIncidentService alloc]initWithriverCode:@""];
    
    ZLGetDepartmentListByIncidentService *getDepartListService = [[ZLGetDepartmentListByIncidentService alloc]init];
    
    ZLGetUserListByTaskNormalService *getTaskNormalService = [[ZLGetUserListByTaskNormalService alloc]initWithriverCode:nil];
    
    ZLGetDepartmentListByTaskService *getDepartListTaskService = [[ZLGetDepartmentListByTaskService alloc]init];
    
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc]initWithRequestArray:@[getUserListService,getDepartListService,getTaskNormalService,getDepartListTaskService]];
    
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
        
        ZLGetUserListByIncidentService *getUserList = (ZLGetUserListByIncidentService *)batchRequest.requestArray[0];
        
        ZLGetEventUserListModel *eventUserList = [[ZLGetEventUserListModel alloc]initWithString:getUserList.responseString error:nil];
        
        if ([eventUserList.code isEqualToString:@"0"]) {
            
            [self.store putString:getUserList.responseString withId:DBEventPeopleListRivers intoTable:DBUserTable];
            
        }
        
        ZLGetDepartmentListByIncidentService *getDepartList = (ZLGetDepartmentListByIncidentService *)batchRequest.requestArray[1];
        
        ZLGetDepartModel *departModel = [[ZLGetDepartModel alloc]initWithString:getDepartList.responseString error:nil];
        
        if ([departModel.code isEqualToString:@"0"]) {
            [self.store putString:getDepartList.responseString withId:DBEventDepartListRivers intoTable:DBUserTable];
        }
        ZLGetUserListByTaskNormalService *getTaskUsersList = (ZLGetUserListByTaskNormalService *)batchRequest.requestArray[2];
        ZLGetEventUserListModel *taskUserList = [[ZLGetEventUserListModel alloc]initWithString:getTaskUsersList.responseString error:nil];
        
        if ([taskUserList.code isEqualToString:@"0"]) {
            [self.store putString:getTaskUsersList.responseString withId:DBTaskPeopleListRivers intoTable:DBUserTable];
        }
        
        ZLGetDepartmentListByTaskService *getDepartTaskList = (ZLGetDepartmentListByTaskService *)batchRequest.requestArray[3];
        
        ZLGetDepartModel *taskDepartModel = [[ZLGetDepartModel alloc]initWithString:getDepartTaskList.responseString error:nil];
        
        if ([taskDepartModel.code isEqualToString:@"0"]) {
            [self.store putString:getDepartTaskList.responseString withId:DBTaskDepartListRivers intoTable:DBUserTable];
        }
        
        
    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
        
        ZLGetUserListByIncidentService *getUserList = (ZLGetUserListByIncidentService *)batchRequest.requestArray[0];
        
        if (getUserList.responseStatusCode == 200) {
            ZLGetEventUserListModel *eventUserList = [[ZLGetEventUserListModel alloc]initWithString:getUserList.responseString error:nil];
            
            if ([eventUserList.code isEqualToString:@"0"]) {
                
                [self.store putString:getUserList.responseString withId:DBEventPeopleListRivers intoTable:DBUserTable];
                
            }
        }
        ZLGetDepartmentListByIncidentService *getDepartList = (ZLGetDepartmentListByIncidentService *)batchRequest.requestArray[1];
        
        if (getDepartList.responseStatusCode == 200) {
            ZLGetDepartModel *departModel = [[ZLGetDepartModel alloc]initWithString:getDepartList.responseString error:nil];
            
            if ([departModel.code isEqualToString:@"0"]) {
                [self.store putString:getDepartList.responseString withId:DBEventDepartListRivers intoTable:DBUserTable];
            }
        }
        
        
        
        ZLGetUserListByTaskNormalService *getTaskUsersList = (ZLGetUserListByTaskNormalService *)batchRequest.requestArray[2];
        
        if (getTaskUsersList.responseStatusCode == 200) {
            ZLGetEventUserListModel *taskUserList = [[ZLGetEventUserListModel alloc]initWithString:getTaskUsersList.responseString error:nil];
            
            if ([taskUserList.code isEqualToString:@"0"]) {
                [self.store putString:getTaskUsersList.responseString withId:DBTaskPeopleListRivers intoTable:DBUserTable];
            }
            
        }
        
        
        ZLGetDepartmentListByTaskService *getDepartTaskList = (ZLGetDepartmentListByTaskService *)batchRequest.requestArray[3];
        
        if (getDepartTaskList.responseStatusCode == 200) {
            ZLGetDepartModel *taskDepartModel = [[ZLGetDepartModel alloc]initWithString:getDepartTaskList.responseString error:nil];
            
            if ([taskDepartModel.code isEqualToString:@"0"]) {
                [self.store putString:getDepartTaskList.responseString withId:DBTaskDepartListRivers intoTable:DBUserTable];
            }
        }
        ZLLog(@"错误");
        
    }];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getRiversData];
    
    [self getAllData];
    
    self.isHideRunningView = YES;
    
    [self.view addSubview:self.mainScrollView];
    
    [self.mainScrollView addSubview:self.simpleHomeView];
    
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    
    [self.simpleHomeView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mainScrollView);
        make.top.equalTo(self.mainScrollView);
        make.width.mas_equalTo(Main_Screen_Width);
        make.height.mas_equalTo(Main_Screen_Height - TopBarHeight - BottomBarHeight);
        
    }];
    
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.bottom.equalTo(self.simpleHomeView.mas_bottom);

    }];
    
    [self.store createTableWithName:DBMapTable];
    NSString *runningString = [self.store getStringById:DBRunningModel fromTable:DBMapTable];
    
    if (runningString.length > 0) {
        
        [self handleShow];
    }
    

}


/**
 开始巡河
 */
- (void)startRiverBtnClick{
    
    if (self.riversTitleArray.count <= 0) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        } title:@"提示" message:@"当前并无河道" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
    }else{
        if (self.isHideRunningView) {
            ZLAlertSelectionView *alert = [[ZLAlertSelectionView alloc]initWithFrame:CGRectZero sourceArray:self.riversTitleArray withTitle:@"选择河道" sureTitle:@"巡河" singleSelection:YES];
            alert.selectItem = ^(NSInteger index) {
                ZLLog(@"%ld",(long)index);
                ZLGaodeViewController *gaode = [[ZLGaodeViewController alloc]init];
                if (_riversModelArray.count > 0) {
                    ZLNewUserRiversDataModel *riverDataModel = self.riversModelArray[index];
                    gaode.riverDataModel = riverDataModel;
                    [self presentViewController:gaode animated:YES completion:nil];
                }
            };
            [alert show];
        }else{
//            [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
//            } title:@"提示" message:@"当前已经在巡河中" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
            
            AppDelegate *deleage = (AppDelegate *)[UIApplication sharedApplication].delegate;
            
            if (deleage.floatWindow.presentView != nil) {
                [deleage.floatWindow click:nil];
                
                
            }else{
                
                NSString *runningString = [self.store getStringById:DBRunningModel fromTable:DBMapTable];
                
                if (runningString.length > 0) {
                    ZLHomeRiverRunningModel *runningModel = [[ZLHomeRiverRunningModel alloc]initWithString:runningString error:nil];
                    
                    ZLNewUserRiversDataModel *riverModel = [[ZLNewUserRiversDataModel alloc]initWithString:runningModel.riverData error:nil];
                
                    ZLGaodeViewController *vc = [[ZLGaodeViewController alloc]init];
                    vc.riverDataModel = riverModel;
                    [self presentViewController:vc animated:YES completion:nil];
                }
              
                
            }
            
        }
    }
    
    
}

/**
 巡河记录
 */
- (void)riverRecordBtnClick{
    ZLRiverRecordVC *vc = [[ZLRiverRecordVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

/**
 事件管理
 */
- (void)eventManageBtnClick{
    ZLEventManagerVC *vc = [[ZLEventManagerVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 任务管理
 */
- (void)taskManageBtnClick{
    ZLTaskManagerVC *vc = [[ZLTaskManagerVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)right_button_event:(UIButton *)sender{
    
    _maskView = [[ZLHomeAddButtonMaskView alloc]initWithFrame:CGRectMake(0, 0, App_Frame_Width, Main_Screen_Height)];
    
    _maskView.riverBtn.hidden = YES;
    
    [_maskView.eventReportBtn addTarget:self action:@selector(eventReportBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_maskView.taskDownBtn addTarget:self action:@selector(taskDownBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_maskView];
    
    
}

// 事件上报
- (void)eventReportBtnClick{
    [_maskView dismissView];
    //    ZLEventReportViewController *vc = [[ZLEventReportViewController alloc]init];
    
    ZLNewEventReportVC *vc = [[ZLNewEventReportVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}
// 任务下发
- (void)taskDownBtnClick{
    [_maskView dismissView];
    ZLNewTaskDownVC *vc = [[ZLNewTaskDownVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (ZLSimpleHomeView *)simpleHomeView{
    
    if (!_simpleHomeView) {
        _simpleHomeView = [[ZLSimpleHomeView alloc]init];
        
        [_simpleHomeView.startRiverBtn addTarget:self action:@selector(startRiverBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_simpleHomeView.riverRecordBtn addTarget:self action:@selector(riverRecordBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_simpleHomeView.eventManageBtn addTarget:self action:@selector(eventManageBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_simpleHomeView.taskManageBtn addTarget:self action:@selector(taskManageBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    
    return _simpleHomeView;
    
}

- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        
        _mainScrollView = [[UIScrollView alloc]init];
        _mainScrollView.backgroundColor = HEXCOLOR(0xf4f4f4);
        _mainScrollView.showsVerticalScrollIndicator = NO;
    }
    return _mainScrollView;
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"江苏河长通" attributes:dic];
    
    return title;
    
}

- (UIButton *)set_leftButton{
    return  nil;
}

- (UIButton *)set_rightButton{
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [button setImage:[UIImage imageNamed:@"home_right"] forState:(UIControlStateNormal)];
    
    return button;
    
    
}


@end
