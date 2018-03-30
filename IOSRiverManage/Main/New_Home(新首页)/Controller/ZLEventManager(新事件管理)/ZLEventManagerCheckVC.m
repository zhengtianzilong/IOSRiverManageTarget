//
//  ZLEventManagerCheckVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/17.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManagerCheckVC.h"
#import "ZLEventManagerCheckService.h"
#import "ZLAlertSelectionView.h"
#import "ZLEventManagerReportModel.h"
@interface ZLEventManagerCheckVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *incidentName;
@property (nonatomic, strong) NSString *createUserName;
@property (nonatomic, strong) NSString *createStartTime;
@property (nonatomic, strong) NSString *createEndTime;
// 最后一个cell的数据创建时间,便于分页
@property (nonatomic, strong) NSString *lastCreateTime;

@property (nonatomic, strong) NSString *updateBeginTime;
@property (nonatomic, strong) NSString *updateEndTime;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *detailStatus;
@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, strong) NSMutableArray *stateNameArray;

@property (nonatomic, strong) NSMutableArray *stateIdArray;

@end

@implementation ZLEventManagerCheckVC

- (void)getData{
    ZLEventManagerCheckService *service = [[ZLEventManagerCheckService alloc]initWithpageSize:10 incidentName:self.incidentName createUserName:self.createUserName createBeginTime:self.createStartTime createEndTime:self.createEndTime appPageCreateTime:self.lastCreateTime updateBeginTime:_updateBeginTime updateEndTime:_updateEndTime userName:self.userName detailStatus:self.detailStatus];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLEventManagerReportModel *manageModel = [[ZLEventManagerReportModel alloc]initWithString:request.responseString error:nil];
        
        if ([manageModel.code isEqualToString:@"0"]) {
            if ([_lastCreateTime isEqualToString: @""]) {
                
                [_sourceArray removeAllObjects];
                
            }
            for (ZLEventManagerReportDataModel *dataModel in manageModel.data) {
                
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
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    
    self.createEndTime = @"";
    self.createStartTime = @"";
    self.incidentName = @"";
    _sourceArray = [NSMutableArray array];
    
    _lastCreateTime = @"";
    _createUserName = @"";
    _updateBeginTime = @"";
    _updateEndTime = @"";
    _userName = @"";
    _detailStatus = @"";
    [self getData];
    [self.view addSubview:self.mainTableView];
    [self setTabViewHeadView];
}

/**
 查询按钮
 */
- (void)queryButtonClick{
    if ([self.queryView.selectInfoView.createStartTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
        self.createStartTime = @"";
    }else{
        NSString *time = self.queryView.selectInfoView.createStartTimeView.selectTimeLabel.text;
        self.createStartTime = time;
    }
    
    if ([self.queryView.selectInfoView.createEndTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
        self.createEndTime = @"";
    }else{
        NSString *time = self.queryView.selectInfoView.createEndTimeView.selectTimeLabel.text;
        self.createEndTime = time;
    }
    
    if ([self.queryView.selectInfoView.completeStartTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
        self.updateBeginTime = @"";
    }else{
        NSString *time = self.queryView.selectInfoView.completeStartTimeView.selectTimeLabel.text;
        self.updateBeginTime = time;
    }
    
    if ([self.queryView.selectInfoView.completeEndTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
        self.updateEndTime = @"";
    }else{
        NSString *time = self.queryView.selectInfoView.completeEndTimeView.selectTimeLabel.text;
        self.updateEndTime = time;
    }
    
    self.incidentName = self.queryView.selectInfoView.eventName.infoTextField.text;
    self.createUserName = self.queryView.selectInfoView.people.infoTextField.text;
    self.userName = self.queryView.selectInfoView.executorPeople.infoTextField.text;
    
    [self.mainTableView.mj_header beginRefreshing];
}




- (void)setTabViewHeadView{
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];
    [self.mainTableView setNeedsLayout];
    [self.mainTableView layoutIfNeeded];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 1)];
    
    self.queryView = [[ZLQueryEventManagerCheckView alloc] init];
   [self.queryView.queryButton addTarget:self action:@selector(queryButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [headView addSubview:self.queryView];
    
    __weak typeof(self) weakSelef = self;
    self.queryView.selectInfoView.state.selectBlock = ^(UITextField *textField) {
        
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        
        ZLAlertSelectionView *alert = [[ZLAlertSelectionView alloc]initWithFrame:CGRectZero sourceArray:weakSelef.stateNameArray withTitle:@"选择状态" sureTitle:@"确定" singleSelection:YES];
        
        alert.selectItem = ^(NSInteger index) {
            
            textField.text = weakSelef.stateNameArray[index];
            weakSelef.detailStatus = weakSelef.stateIdArray[index];
        };
        
        [alert show];
        
    };

    
    [self.queryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headView);
    }];
    CGFloat height = [headView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = headView.frame;
    frame.size.height = height;
    
    headView.frame = frame;
    
    _mainTableView.tableHeaderView = headView;
    
}

#pragma mark -- 列表的代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    return self.sourceData.count;
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLMyEventCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyEventCheckCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
     cell.userCode = self.userCode;
    
    ZLEventManagerReportDataModel *model = self.sourceArray[indexPath.section];
    
    cell.dataModel = model;
    
    if (indexPath.section == _sourceArray.count - 1) {
        ZLEventManagerReportDataModel *dataModel = _sourceArray[indexPath.section];
        _lastCreateTime = dataModel.createTime;
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLMyEventDetailVC *vc = [[ZLMyEventDetailVC alloc]init];
    
    ZLEventManagerReportDataModel *model = self.sourceArray[indexPath.section];
    
    vc.eventId = model.ID;
    vc.userCode = self.userCode;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (NSMutableArray *)stateNameArray{
    if (!_stateNameArray) {
        _stateNameArray =  [NSMutableArray arrayWithArray:@[
                                                            @"创建",
                                                            @"已上报",
                                                            @"已接收",
                                                            @"已转报",
                                                            @"完结",
                                                            @"全部"
                                                            ]];
        
    }
    return _stateNameArray;
}

- (NSMutableArray *)stateIdArray{
    if (!_stateIdArray) {
        _stateIdArray = [NSMutableArray arrayWithArray:@[
                                                         @"0",
                                                         @"1",
                                                         @"2",
                                                         @"3",
                                                         @"9",
                                                         @""
                                                         ]];
    }
    return _stateIdArray;
}



- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        
        [_mainTableView registerClass:[ZLMyEventCheckCell class] forCellReuseIdentifier:@"ZLMyEventCheckCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.sectionFooterHeight = 20;
        _mainTableView.sectionHeaderHeight = 0;
        _mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 200;
        
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _lastCreateTime = @"";
            [self getData];
            
        }];
        
        _mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self getData];
            
        }];

        
    }
    return _mainTableView;
}


@end
