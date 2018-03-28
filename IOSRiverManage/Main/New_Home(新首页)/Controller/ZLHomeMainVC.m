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

@interface ZLHomeMainVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) ZLHomeHeadView *headView;
@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) ZLHomeAddButtonMaskView *maskView;

@property (nonatomic, strong) UIView *headContentView;

@property (nonatomic, strong) YTKKeyValueStore *store;

@property (nonatomic, strong) NSMutableArray *riversTitleArray;

@property (nonatomic, strong) NSMutableArray *riversModelArray;


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
    
    if (riversModel.data.count > 0) {
        
        for (ZLNewUserRiversDataModel *riverDataModel in riversModel.data ) {
            
            [self.riversTitleArray addObject:riverDataModel.riverName];
            
            [self.riversModelArray addObject:riverDataModel];
            
        }
        
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self getRiversData];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
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



- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

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
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 160;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 2;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return -10;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLHomeTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLHomeTaskTableViewCell" forIndexPath:indexPath];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        [_mainTableView registerClass:[ZLHomeTaskTableViewCell class] forCellReuseIdentifier:@"ZLHomeTaskTableViewCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _mainTableView.sectionFooterHeight = 20;
        _mainTableView.sectionHeaderHeight = 0;
        
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 150;
        
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
    
//    NSMutableArray *sourceArray = [NSMutableArray arrayWithObjects:@"李伟",
//                                   @"李青",
//                                   @"张友善",
//                                   @"刘霞",
//                                   @"刘霞",
//                                   @"刘霞",
//                                   @"刘霞",
//                                   @"刘霞",
//                                   @"刘霞",
//                                   @"刘霞",
//                                   @"刘霞",nil];
    
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
