//
//  ZLTaskMyCheckVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/17.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLTaskMyCheckVC.h"
#import "ZLFindTaskListService.h"
#import "ZLAlertSelectionView.h"
#import "ZLTaskCheckModel.h"
#import "ZLTaskDetailVC.h"
#import "ZLMyTaskAlreadyCell.h"
@interface ZLTaskMyCheckVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSString *createName;

// 最后一个cell的数据创建时间,便于分页
@property (nonatomic, strong) NSString *lastCreateTime;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, strong) NSString *taskName;

@property (nonatomic, strong) NSString *createStartTime;
@property (nonatomic, strong) NSString *createEndTime;

@property (nonatomic, strong) NSString *completeStartTime;
@property (nonatomic, strong) NSString *completeEndTime;

// 执行人
@property (nonatomic, strong) NSString *userName;
// 当前状态
@property (nonatomic, strong) NSString *taskStatus;

@property (nonatomic, strong) NSMutableArray *stateNameArray;

@property (nonatomic, strong) NSMutableArray *stateIdArray;
@end

@implementation ZLTaskMyCheckVC

- (void)getData{
    ZLFindTaskListService *service = [[ZLFindTaskListService alloc]initWithpageSize:10 createTimeFormat:_lastCreateTime taskName:_taskName createName:_createName createStartTime:_createStartTime createEndTime:_createEndTime completeStartTime:_completeStartTime completeEndTime:_completeEndTime userName:_userName taskStatus:_taskStatus];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLTaskCheckModel *checkModel = [[ZLTaskCheckModel alloc]initWithString:request.responseString error:nil];

        if ([checkModel.code isEqualToString:@"0"]) {
            if ([_lastCreateTime isEqualToString: @""]) {

                [_sourceArray removeAllObjects];

            }
            for (ZLTaskCheckDataModel *dataModel in checkModel.data) {

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
    self.taskName = @"";
    self.completeStartTime = @"";
    self.completeEndTime = @"";
    self.createName = @"";
    self.userName = @"";
    self.taskStatus = @"-1";
    _sourceArray = [NSMutableArray array];
    
    _lastCreateTime = @"";
    
    [self getData];
    [self.view addSubview:self.mainTableView];
    
    [self setTabViewHeadView];
    
    
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
    self.queryView.selectInfoView.eventName.titleLabel.text = @"任务名称";
    [headView addSubview:self.queryView];
    
    [self.queryView.queryButton addTarget:self action:@selector(queryButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    __weak typeof(self) weakSelef = self;
    self.queryView.selectInfoView.state.selectBlock = ^(UITextField *textField) {
      
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        
        ZLAlertSelectionView *alert = [[ZLAlertSelectionView alloc]initWithFrame:CGRectZero sourceArray:weakSelef.stateNameArray withTitle:@"选择状态" sureTitle:@"确定" singleSelection:YES];
    
        alert.selectItem = ^(NSInteger index) {
          
            textField.text = weakSelef.stateNameArray[index];
            weakSelef.taskStatus = weakSelef.stateIdArray[index];
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
        self.completeStartTime = @"";
    }else{
        NSString *time = self.queryView.selectInfoView.completeStartTimeView.selectTimeLabel.text;
        
        
        self.completeStartTime = time;
    }
    
    if ([self.queryView.selectInfoView.completeEndTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
        self.completeEndTime = @"";
    }else{
        NSString *time = self.queryView.selectInfoView.completeEndTimeView.selectTimeLabel.text;
        
        
        self.completeEndTime = time;
    }
    
    self.taskName = self.queryView.selectInfoView.eventName.infoTextField.text;
    self.createName = self.queryView.selectInfoView.people.infoTextField.text;
    self.userName = self.queryView.selectInfoView.executorPeople.infoTextField.text;
    [self.mainTableView.mj_header beginRefreshing];
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
    
    ZLMyTaskAlreadyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyTaskAlreadyCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ZLTaskCheckDataModel *model = self.sourceArray[indexPath.section];

    cell.checkDataModel = model;

    if (indexPath.section == _sourceArray.count - 1) {
        ZLTaskCheckDataModel *dataModel = _sourceArray[indexPath.section];
        _lastCreateTime = dataModel.createTime;

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLTaskDetailVC *vc = [[ZLTaskDetailVC alloc]init];

    ZLTaskCheckDataModel *dataModel = self.sourceArray[indexPath.section];
    vc.passCode = @"任务查询";
    vc.code = dataModel.taskId;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (NSMutableArray *)stateNameArray{
    if (!_stateNameArray) {
        _stateNameArray =  [NSMutableArray arrayWithArray:@[
                            @"已创建",
                            @"已下发",
                            @"已接收",
                            @"已转发",
                            @"已反馈",
                            @"已驳回",
                            @"已完成",
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
                          @"6",
                          @"7",
                          @"8",
                          @"9",
                          @"-1"
                          ]];
    }
    return _stateIdArray;
}


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        
        [_mainTableView registerClass:[ZLMyTaskAlreadyCell class] forCellReuseIdentifier:@"ZLMyTaskAlreadyCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.sectionFooterHeight = 20;
        _mainTableView.sectionHeaderHeight = 0;
        _mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 180;
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
