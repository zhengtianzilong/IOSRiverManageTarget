//
//  ZLHomeMainVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLHomeMainVC.h"
//#import "ZLEventReportViewController.h"
#import "ZLHomeTaskTableViewCell.h"
#import "ZLHomeAddButtonMaskView.h"
//#import "ZLNewsAndNotifactionViewController.h"
#import "ZLHomeHeadView.h"
#import "ZLNewsAndNotifactionVC.h"
#import "ZLEventManagerVC.h"
#import "ZLTaskManagerVC.h"
#import "ZLRiverRecordVC.h"
#import "ZLAddressBookVC.h"
#import "ZLOverSeeManagerVC.h"

#import "ZLAlertSelectionView.h"

//#import "ZLEventReportViewController.h"
#import "ZLNewEventReportVC.h"
#import "ZLNewTaskDownVC.h"
//#import "ZLEvent_SendDownViewController.h"
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

@end

@implementation ZLHomeMainVC 

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:@"RiverRunning"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"RiverRunningEnd"];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(handleShow) name:@"RiverRunning" object:nil];

    [nc addObserver:self selector:@selector(handleHide) name:@"RiverRunningEnd" object:nil];
    
    
//    [_mainTableView reloadData];
    
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



- (void)viewDidLoad {
    [super viewDidLoad];
    [self getRiversData];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _sourceArray = [NSMutableArray array];
    _lastCreateTime = @"";
    
    [self getData];
    
    [self setUpUI];
    
    [self.store createTableWithName:DBMapTable];
    NSString *runningString = [self.store getStringById:DBRunningModel fromTable:DBMapTable];
    
    if (runningString.length > 0) {
        
        [self handleShow];
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
        
        if ([model.title isEqualToString:@"巡河记录"]) {
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
        return cell;
    }else{
        ZLMyEventWaitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyEventWaitCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.homeDataModel = model;
        
        return cell;
    }
    
   
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLHomeWaitEventAndTaskDataModel *model = self.sourceArray[indexPath.section];
    
    if ([model.type isEqualToString:@"1"]) {
        ZLTaskDetailVC *vc = [[ZLTaskDetailVC alloc]init];
        vc.passCode = @"待办任务";
        vc.code = model.taskId;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
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
        
        _mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
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
    

    
}

@end
