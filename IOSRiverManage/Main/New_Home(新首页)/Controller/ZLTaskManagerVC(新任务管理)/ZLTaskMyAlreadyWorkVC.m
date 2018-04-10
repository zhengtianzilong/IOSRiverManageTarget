//
//  ZLTaskMyAlreadyWorkVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLTaskMyAlreadyWorkVC.h"
#import "ZLFindMyDoneTaskListService.h"
#import "ZLMyTaskAlreadyCell.h"
#import "ZLTaskDetailVC.h"
#import "ZLTaskAlreadyModel.h"
@interface ZLTaskMyAlreadyWorkVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSString *createName;

// 最后一个cell的数据创建时间,便于分页
@property (nonatomic, strong) NSString *lastCreateTime;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, strong) NSString *taskName;

@property (nonatomic, strong) NSString *createStartTime;
@property (nonatomic, strong) NSString *createEndTime;

@property (nonatomic, strong) NSString *completeStartTime;
@property (nonatomic, strong) NSString *completeEndTime;
@property (nonatomic, assign) BOOL isPush;
@end

@implementation ZLTaskMyAlreadyWorkVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_isPush) {
        //push
    }else{
        //pop
        [self getData];
        
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    _isPush = NO;
    
}

- (void)getData{
    ZLFindMyDoneTaskListService *service = [[ZLFindMyDoneTaskListService alloc]initWithpageSize:10 createTimeFormat:_lastCreateTime taskName:_taskName createName:_createName createStartTime:_createStartTime createEndTime:_createEndTime completeStartTime:_completeStartTime completeEndTime:_completeEndTime];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLTaskAlreadyModel *alreadyModel = [[ZLTaskAlreadyModel alloc]initWithString:request.responseString error:nil];

        if ([alreadyModel.code isEqualToString:@"0"]) {
            if ([_lastCreateTime isEqualToString: @""]) {

                [_sourceArray removeAllObjects];

            }
            for (ZLTaskAlreadyDataModel *dataModel in alreadyModel.data) {

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
    _isPush = YES;
    self.createEndTime = @"";
    self.createStartTime = @"";
    self.taskName = @"";
    self.completeStartTime = @"";
    self.completeEndTime = @"";
    self.createName = @"";
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
    
    self.queryView = [[ZLQueryEventManagerAlreadyView alloc] init];
    self.queryView.selectInfoView.eventName.titleLabel.text = @"任务名称";
    //        con.backgroundColor = [UIColor blackColor];
    [headView addSubview:self.queryView];
    
    [self.queryView.queryButton addTarget:self action:@selector(queryButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    
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
    
    ZLTaskAlreadyDataModel *model = self.sourceArray[indexPath.section];
    
    cell.dataModel = model;
    
    if (indexPath.section == _sourceArray.count - 1) {
        ZLTaskAlreadyDataModel *dataModel = _sourceArray[indexPath.section];
        _lastCreateTime = dataModel.createTime;
        
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLTaskDetailVC *vc = [[ZLTaskDetailVC alloc]init];
    
    ZLTaskAlreadyDataModel *dataModel = self.sourceArray[indexPath.section];
    vc.passCode = @"已办任务";
    vc.code = dataModel.taskId;
    [self.navigationController pushViewController:vc animated:YES];
    
    
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
