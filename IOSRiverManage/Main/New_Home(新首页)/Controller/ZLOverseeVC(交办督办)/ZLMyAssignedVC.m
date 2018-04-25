//
//  ZLMyAssignedVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/8.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyAssignedVC.h"
#import "ZLGetMyAssignTaskListService.h"
#import "ZLAssignTaskRowModel.h"
@interface ZLMyAssignedVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger requestStart;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *creatStartTime;
@property (nonatomic, strong) NSString *creatEndTime;
@property (nonatomic, strong) NSString *completeStartTime;
@property (nonatomic, strong) NSString *completeEndTime;

@property (nonatomic, strong) NSString *startTime;

@end
@implementation ZLMyAssignedVC

- (void)getData {
    
    ZLGetMyAssignTaskListService *service = [[ZLGetMyAssignTaskListService alloc]initWithpageSize:10 currentPage:1 assignName:self.eventName assignStartTime:self.creatStartTime assignEndTime:self.creatEndTime completeStartTime:self.completeStartTime completeEndTime:self.completeEndTime startTime:self.startTime];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLAssignTaskRowModel *model = [[ZLAssignTaskRowModel alloc]initWithString:request.responseString error:nil];
        
        if ([model.code isEqualToString:@"0"]) {
            
            if ([_startTime isEqualToString:@""]) {
                [_sourceArray removeAllObjects];
            }
            
            for (ZLAssignTaskRowDetailModel *dataModel in model.data.rows) {
                [_sourceArray addObject:dataModel];
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
    
    self.requestStart = 1;
    
    self.eventName = @"";
    self.creatStartTime = @"";
    self.creatEndTime = @"";
    self.completeStartTime = @"";
    self.completeEndTime = @"";
    self.startTime = @"";
    
    self.sourceArray = [NSMutableArray array];
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    [self.view addSubview:self.mainTableView];
    
    [self getData];
    
    [self setTabViewHeadView];
    
    //    //框架方法
    //    self.mainTableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"empty_jd"
    //                                                                titleStr:@"暂无数据，点击重新加载"
    //                                                               detailStr:@""];
    //    //emptyView内容上的点击事件监听
    //    __weak typeof(self)weakSelf = self;
    //    [self.mainTableView.ly_emptyView setTapContentViewBlock:^{
    //        [weakSelf getData];
    //    }];
    
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
    
    self.queryView = [[ZLQueryMyAssignedView alloc] init];
    [headView addSubview:self.queryView];
    
    [self.queryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headView);
    }];
    CGFloat height = [headView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = headView.frame;
    frame.size.height = height;
    
    headView.frame = frame;
    
    [self.queryView.queryButton addTarget:self action:@selector(queryButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    _mainTableView.tableHeaderView = headView;
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    
    
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
    
    ZLOverSeeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLOverSeeTableViewCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ZLAssignTaskRowDetailModel *detailModel = self.sourceArray[indexPath.section];
    
    cell.assignType = @"我的交办";
    
    cell.assignModel = detailModel;
    
    
    if (indexPath.section == _sourceArray.count - 1) {
        _startTime = detailModel.createTime;
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLAssignTaskRowDetailModel *detailModel = self.sourceArray[indexPath.section];
    
    ZLOverSeeDetailVC *vc = [[ZLOverSeeDetailVC alloc]init];
    vc.code = detailModel.ID;
    
    ZLOverSeeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    vc.status = cell.state.text;
    
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 查询按钮
 */
- (void)queryButtonClick{
    
    if ([self.queryView.selectInfoView.createStartTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
        self.creatStartTime = @"";
    }else{
        NSString *time = self.queryView.selectInfoView.createStartTimeView.selectTimeLabel.text;
        
        //        time = [time substringToIndex:time.length - 3];
        
        self.creatStartTime = time;
    }
    
    if ([self.queryView.selectInfoView.createEndTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
        self.creatEndTime = @"";
    }else{
        NSString *time = self.queryView.selectInfoView.createEndTimeView.selectTimeLabel.text;
        
        //        time = [time substringToIndex:time.length - 3];
        
        self.creatEndTime = time;
    }
    
    if ([self.queryView.selectInfoView.completeStartTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
        self.completeStartTime = @"";
    }else{
        NSString *time = self.queryView.selectInfoView.completeStartTimeView.selectTimeLabel.text;
        
        //        time = [time substringToIndex:time.length - 3];
        
        self.completeStartTime = time;
    }
    
    if ([self.queryView.selectInfoView.completeEndTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
        self.completeEndTime = @"";
    }else{
        NSString *time = self.queryView.selectInfoView.createEndTimeView.selectTimeLabel.text;
        
        //        time = [time substringToIndex:time.length - 3];
        
        self.completeEndTime = time;
    }
    
    self.eventName = self.queryView.selectInfoView.eventName.infoTextField.text;
    //    [self listData];
    [self.mainTableView.mj_header beginRefreshing];
}


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        
        [_mainTableView registerClass:[ZLOverSeeTableViewCell class] forCellReuseIdentifier:@"ZLOverSeeTableViewCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.sectionFooterHeight = 20;
        _mainTableView.sectionHeaderHeight = 0;
        //        _mainTableView.contentInset = UIEdgeInsetsMake(20 - 35, 0, 0, 0);
        //
        
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 180;
        
        //        _mainTableView.tableHeaderView = self.queryView;
        
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            _requestStart = 1;
            _startTime = @"";
            [self getData];
            
        }];
        
        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            //            _requestStart += 1;
            [self getData];
            
        }];
        
    }
    return _mainTableView;
}

@end
