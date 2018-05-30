//
//  ZLHomeMainVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLHomeMainVC.h"
#import "ZLHomeTaskTableViewCell.h"
#import "ZLHomeAddButtonMaskView.h"
#import "ZLHomeHeadView.h"
#import "ZLNewsAndNotifactionVC.h"
#import "ZLEventManagerVC.h"
#import "ZLTaskManagerVC.h"
#import "ZLRiverRecordVC.h"
#import "ZLAddressBookVC.h"
#import "ZLOverSeeManagerVC.h"

#import "ZLAlertSelectionView.h"
#import "ZLNewEventReportVC.h"
#import "ZLNewTaskDownVC.h"
#import "ZLGaodeViewController.h"

#import "ZLNewUserRiversModel.h"
#import "ZLGetMyToDoTaskAndIncidentListService.h"
#import "ZLHomeWaitEventAndTaskModel.h"

#import "ZLMyTaskWaitCell.h"
#import "ZLMyEventWaitCell.h"
#import "ZLTaskDetailVC.h"
#import "ZLMyEventDetailVC.h"
#import "ZLStatisticsVC.h"
#import "ZLNewLoginModel.h"
#import "ZLReceiveTaskService.h"
#import "ZLTaskDealDetailVC.h"
#import "ZLMyventDealDetailVC.h"
#import "ZLReceiveIncidentService.h"

#import "ZLNewGetUserRiversService.h"
#import "ZLGetUserListByIncidentService.h"
#import "ZLGetDepartmentListByIncidentService.h"
#import "ZLGetUserListByTaskNormalService.h"
#import "ZLGetDepartmentListByTaskService.h"
#import "ZLGetEventUserListModel.h"
#import "ZLGetDepartModel.h"
#import "AppDelegate.h"
#import "ZLMyExamineManagerVC.h"
@interface ZLHomeMainVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) ZLHomeHeadView *headView;
@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) ZLHomeAddButtonMaskView *maskView;

@property (nonatomic, strong) UIView *headContentView;

@property (nonatomic, strong) YTKKeyValueStore *store;

@property (nonatomic, strong) NSMutableArray *riversTitleArray;

@property (nonatomic, strong) NSMutableArray *riversModelArray;

// 最后一个cell的数据创建时间,便于分页
@property (nonatomic, strong) NSString *lastCreateTime;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, strong) ZLNewLoginModel *loginModel;

@property (nonatomic, assign) BOOL isPush;

@property (nonatomic, strong) AppDelegate * app;

@end

@implementation ZLHomeMainVC 

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:@"RiverRunning"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"RiverRunningEnd"];
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    _isPush = NO;
    
}



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (_isPush) {
        //push
    }else{
        //pop
        self.lastCreateTime = @"";
        [self getData];
        
    }
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(handleShow) name:@"RiverRunning" object:nil];

    [nc addObserver:self selector:@selector(handleHide) name:@"RiverRunningEnd" object:nil];
    
}

- (void)handleHide{
    
    self.headView.isHideRunningView = YES;
    
    [self setTabViewHeadView];
    
    [_mainTableView reloadData];
}


- (void)handleShow{
    
    self.headView.isHideRunningView = NO;
    
    [self setTabViewHeadView];
    
    [_mainTableView reloadData];
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

- (void)getData{
    
    ZLGetMyToDoTaskAndIncidentListService *service = [[ZLGetMyToDoTaskAndIncidentListService alloc]initWithpageSize:10 appPageCreateTime:self.lastCreateTime];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLHomeWaitEventAndTaskModel *waitModel = [[ZLHomeWaitEventAndTaskModel alloc]initWithString:request.responseString error:nil];

        if ([waitModel.code isEqualToString:@"0"]) {
            if ([_lastCreateTime isEqualToString: @""]) {

                [_sourceArray removeAllObjects];

            }
            for (ZLHomeWaitEventAndTaskDataModel *dataModel in waitModel.data) {

                [self.sourceArray addObject:dataModel];

            }
        }

        [self.mainTableView reloadData];
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
    }];
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
    self.automaticallyAdjustsScrollViewInsets = NO;
    _sourceArray = [NSMutableArray array];
    _lastCreateTime = @"";
    _isPush = YES;
    [self getData];
    
    [self getAllData];
    
    [self setUpUI];
    
    [self.store createTableWithName:DBMapTable];
    NSString *runningString = [self.store getStringById:DBRunningModel fromTable:DBMapTable];
    
    if (runningString.length > 0) {
        
        [self handleShow];
    }
    
    self.app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //pushName 是我给后天约定的通知必传值，所以我可以根据他是否为空来判断是否有通知
    if ([self.app.userInfo objectForKey:@"payload"]) {
        
        // 这里延迟1秒 否则不执行跳转
        [self performSelector:@selector(skipToVC) withObject:nil afterDelay:1];
        
        
    }
}


/**
 收到推送的跳转
 */
- (void)skipToVC{
    NSString *payloadStr = [self.app.userInfo objectForKey:@"payload"];
    NSData *jsonData = [payloadStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSString *type=[NSString stringWithFormat:@"%@",dic[@"type"]];
    // 1事件 2 任务 3 交办
    NSString *Id=[NSString stringWithFormat:@"%@",dic[@"id"]];
    if ([type isEqualToString:@"1"]) {
        ZLMyEventDetailVC *vc = [[ZLMyEventDetailVC alloc]init];
        vc.eventId = Id;
        vc.userCode = _loginModel.data.userId;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([type isEqualToString:@"2"]){
        
        ZLTaskDetailVC *vc = [[ZLTaskDetailVC alloc]init];
        //        vc.passCode = @"待办任务";
        vc.code = Id;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (void)setUpUI{
    self.view.backgroundColor = HEXCOLOR(0xf2f0f3);
    [self.view addSubview:self.mainTableView];
    
    self.headContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 1)];
    
    self.headView = [[ZLHomeHeadView alloc] init];
    [self.headContentView addSubview:self.headView];

    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];
    
    
     __weak typeof(self) weakSelf = self;
    
    [self setTabViewHeadView];
    self.headView.homeCenterView.centerItemBlock = ^(ZLHomeCenterCollectionModel *model, NSIndexPath *indexpath) {
        
        if ([model.title isEqualToString:@"新闻公告"]) {
            ZLNewsAndNotifactionVC *vc = [[ZLNewsAndNotifactionVC alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
        if ([model.title isEqualToString:@"事件管理"]) {
            ZLEventManagerVC *vc = [[ZLEventManagerVC alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
        if ([model.title isEqualToString:@"任务管理"]) {
            ZLTaskManagerVC *vc = [[ZLTaskManagerVC alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
        if ([model.title isEqualToString:@"巡河记录"] || [model.title isEqualToString:@"巡查记录"]) {
            ZLRiverRecordVC *vc = [[ZLRiverRecordVC alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        if ([model.title isEqualToString:@"通讯录"]) {
            ZLAddressBookVC *vc = [[ZLAddressBookVC alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
        if ([model.title isEqualToString:@"交办督办"]) {
            ZLOverSeeManagerVC *vc = [[ZLOverSeeManagerVC alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
        if ([model.title isEqualToString:@"综合统计"]) {
            ZLStatisticsVC *vc = [[ZLStatisticsVC alloc]init];
            vc.areaCode = weakSelf.loginModel.data.areaCode;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
        if ([model.title isEqualToString:@"更多"]) {
            ZLMyExamineManagerVC *vc = [[ZLMyExamineManagerVC alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
        
    };
}

- (void)setTabViewHeadView{
    
    
    [self.mainTableView setNeedsLayout];
    [self.mainTableView layoutIfNeeded];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headContentView);
    }];
    CGFloat height = [self.headContentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = self.headContentView.frame;
    frame.size.height = height;
    
    self.headContentView.frame = frame;
    
    _mainTableView.tableHeaderView = self.headContentView;
    
}

- (void)clickAddButton{
    ZLLog(@"点击了加号");

    
}

//- (void)eventReportClick{
//    ZLEventReportViewController *reportVC = [[ZLEventReportViewController alloc]init];
//
//    [self.navigationController pushViewController:reportVC animated:YES];
//
//
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLHomeWaitEventAndTaskDataModel *model = self.sourceArray[indexPath.section];
    
    if (indexPath.section == _sourceArray.count - 1) {
        _lastCreateTime = model.createTime;
        
    }
    
    if ([model.type isEqualToString:@"1"]) {
        ZLMyTaskWaitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyTaskWaitCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.homeDataModel = model;
        
         __weak typeof(self) weakSelf = self;
        
        cell.dealClick = ^(ZLTaskWaitDataModel *dataModel,ZLHomeWaitEventAndTaskDataModel *homeDataModel, UIButton *dealBtn) {
            
            if ([dealBtn.currentTitle isEqualToString:@"接收"]) {
                
                DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"提示" message:@"确认接收吗?" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
                
                alert.otherButtonAction = ^{
                    
                    ZLReceiveTaskService *service = [[ZLReceiveTaskService alloc]initWithtaskDetailId:model.taskDetailId];
                    [SVProgressHUD showWithStatus:@"接收中"];
                    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                        
                        ZLBaseModel *model = [[ZLBaseModel alloc]initWithString:request.responseString error:nil];
                        
                        if ([model.code isEqualToString:@"0"]) {
                            
                            [SVProgressHUD showSuccessWithStatus:@"接收成功"];
                            [SVProgressHUD dismissWithDelay:0.3 completion:^{
                                
                                self.lastCreateTime = @"";
                                [self getData];
                            }];
                            
                        }else{
                            [SVProgressHUD showErrorWithStatus:model.detail];
                            [SVProgressHUD dismissWithDelay:0.3];
                        }
                        
                        
                    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                        [SVProgressHUD showErrorWithStatus:@"网络错误"];
                        [SVProgressHUD dismissWithDelay:0.3];
                    }];
                };

                [alert show];
            }else if ([dealBtn.currentTitle isEqualToString:@"处理"]){
                ZLTaskDealDetailVC *vc = [[ZLTaskDealDetailVC alloc]init];
                
                vc.taskDetailID = homeDataModel.taskDetailId;
                vc.taskId = homeDataModel.taskId;
                vc.childCode = homeDataModel.taskChildCode;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else if ([dealBtn.currentTitle isEqualToString:@"重做"]){
                ZLTaskDealDetailVC *vc = [[ZLTaskDealDetailVC alloc]init];
                //            vc.dataModel = dataModel;
                
                vc.taskDetailID = homeDataModel.taskDetailId;
                vc.taskId = homeDataModel.taskId;
                vc.childCode = homeDataModel.taskChildCode;
                
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            
            
        };
        return cell;
    }else if([model.type isEqualToString:@"2"]) {
        ZLMyEventWaitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyEventWaitCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.homeDataModel = model;
        
        __weak typeof(self) weakSelf = self;
        
        cell.dealClick = ^(ZLEventManagerReportDataModel *dataModel, ZLHomeWaitEventAndTaskDataModel *homeDataModel, UIButton *dealBtn) {
            if ([dealBtn.currentTitle isEqualToString:@"接收"]) {
                
                DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"提示" message:@"确认接收吗?" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
                
                alert.otherButtonAction = ^{
                    
                    ZLReceiveIncidentService *service = [[ZLReceiveIncidentService alloc]initWithriverIncidentDetailId:homeDataModel.detailId eventId:homeDataModel.ID];
                    [SVProgressHUD showWithStatus:@"接收中"];
                    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                        
                        ZLBaseModel *model = [[ZLBaseModel alloc]initWithString:request.responseString error:nil];
                        
                        if ([model.code isEqualToString:@"0"]) {
                            
                            [SVProgressHUD showSuccessWithStatus:@"接收成功"];
                            [SVProgressHUD dismissWithDelay:0.3 completion:^{
                                self.lastCreateTime = @"";
                                [self getData];
//                                [tableView.mj_header beginRefreshing];
                                
                            }];
                            
                        }else{
                            [SVProgressHUD showErrorWithStatus:model.detail];
                            [SVProgressHUD dismissWithDelay:0.3];
                        }
                        
                        
                    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                        [SVProgressHUD showErrorWithStatus:@"网络错误"];
                        [SVProgressHUD dismissWithDelay:0.3];
                    }];
                };
                [alert show];
            }else if ([dealBtn.currentTitle isEqualToString:@"处理"]){
                ZLMyventDealDetailVC *vc = [[ZLMyventDealDetailVC alloc]init];
                vc.detailID = homeDataModel.detailId;
                vc.eventId = homeDataModel.ID;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        };
        
        return cell;
    }
    
   
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLHomeWaitEventAndTaskDataModel *model = self.sourceArray[indexPath.section];
    
    if ([model.type isEqualToString:@"1"]) {
        ZLTaskDetailVC *vc = [[ZLTaskDetailVC alloc]init];
//        vc.passCode = @"待办任务";
        vc.code = model.taskId;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([model.type isEqualToString:@"2"]) {
        
        ZLMyEventDetailVC *vc = [[ZLMyEventDetailVC alloc]init];
        vc.eventId = model.ID;
        vc.userCode = model.userCode;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}



- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        [_mainTableView registerClass:[ZLMyTaskWaitCell class] forCellReuseIdentifier:@"ZLMyTaskWaitCell"];
        [_mainTableView registerClass:[ZLMyEventWaitCell class] forCellReuseIdentifier:@"ZLMyEventWaitCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _mainTableView.sectionFooterHeight = 20;
        _mainTableView.sectionHeaderHeight = 0;
        
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 200;
        
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _lastCreateTime = @"";
            [self getData];
            
        }];
        
        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self getData];
            
        }];
        
//        _mainTableView.scrollEnabled = NO;
        
    }
    return _mainTableView;
}



- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
#if WanApp
     NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"江苏湾长通" attributes:dic];
#else
     NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"江苏河长通" attributes:dic];
#endif
    
   
    
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


- (void)right_button_event:(UIButton *)sender{
    
    _maskView = [[ZLHomeAddButtonMaskView alloc]initWithFrame:CGRectMake(0, 0, App_Frame_Width, Main_Screen_Height)];
    
    [_maskView.riverBtn addTarget:self action:@selector(riverBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
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
// 河长巡河
- (void)riverBtnClick{
    
    [_maskView dismissView];
    
    if (self.riversTitleArray.count <= 0) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        } title:@"提示" message:@"当前并无河道" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
    }else{
        if (self.headView.isHideRunningView) {
            ZLAlertSelectionView *alert = [[ZLAlertSelectionView alloc]initWithFrame:CGRectZero sourceArray:self.riversTitleArray withTitle:@"选择河道" sureTitle:@"巡查" singleSelection:YES];
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
            [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            } title:@"提示" message:@"当前已经在巡查中" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        }
    }
}

@end
