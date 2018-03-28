//
//  ZLTaskMyLauchVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLTaskMyDownVC.h"
#import "ZLMyTaskChangAndDeleteCell.h"
#import "ZLNewChangeTaskDownVC.h"
#import "ZLFindMyCreatedTaskListService.h"
#import "ZLTaskManagerModel.h"
#import "ZLTaskDetailVC.h"
@interface ZLTaskMyDownVC ()<UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, strong) NSString *createTimeFormat;
@property (nonatomic, strong) NSString *taskName;

@property (nonatomic, strong) NSString *createStartTime;
@property (nonatomic, strong) NSString *createEndTime;
// 最后一个cell的数据创建时间,便于分页
@property (nonatomic, strong) NSString *lastCreateTime;

@property (nonatomic, strong) NSMutableArray *sourceArray;


@end

@implementation ZLTaskMyDownVC
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.mainTableView.mj_header beginRefreshing];
    
    
}

- (void)getData{
    ZLFindMyCreatedTaskListService *service = [[ZLFindMyCreatedTaskListService alloc]initWithpageSize:10 createTimeFormat:_lastCreateTime taskName:self.taskName createStartTime:self.createStartTime createEndTime:self.createEndTime];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZLLog(@"%@",request.responseString);
        
        ZLTaskManagerModel *manageModel = [[ZLTaskManagerModel alloc]initWithString:request.responseString error:nil];
        
        if ([manageModel.code isEqualToString:@"0"]) {
            if ([_lastCreateTime isEqualToString: @""]) {
                
                [_sourceArray removeAllObjects];
                
            }
            for (ZLTaskManageDataModel *dataModel in manageModel.data) {
                
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
    _sourceArray = [NSMutableArray array];
    
    _lastCreateTime = @"";
    
//    [self getData];
    
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
    
    self.queryView = [[ZLZLQueryEventDownView alloc] init];
    self.queryView.selectInfoView.eventName.titleLabel.text = @"任务名称";
    //        con.backgroundColor = [UIColor blackColor];
    [headView addSubview:self.queryView];
    
    [self.queryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headView);
    }];
    CGFloat height = [headView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = headView.frame;
    frame.size.height = height;
    
    headView.frame = frame;
    
    _mainTableView.tableHeaderView = headView;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    return self.sourceData.count;
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLMyTaskChangAndDeleteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyTaskChangAndDeleteCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ZLTaskManageDataModel *model = self.sourceArray[indexPath.section];
    
    cell.dataModel = model;
    __weak typeof(self) weakSelf = self;
    
    cell.changeClick = ^{
        
        ZLNewChangeTaskDownVC *changeVC = [[ZLNewChangeTaskDownVC alloc]init];
        [weakSelf.navigationController pushViewController:changeVC animated:YES];
        
        
    };
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLTaskDetailVC *vc = [[ZLTaskDetailVC alloc]init];
    
    ZLTaskManageDataModel *dataModel = self.sourceArray[indexPath.section];
    
    vc.code = dataModel.taskId;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

/**
 查询按钮
 */
- (void)queryButtonClick{
    
    if ([self.queryView.selectInfoView.startTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
        self.createStartTime = @"";
    }else{
        NSString *time = self.queryView.selectInfoView.startTimeView.selectTimeLabel.text;
        self.createStartTime = time;
    }
    
    if ([self.queryView.selectInfoView.endTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
        self.createEndTime = @"";
    }else{
        NSString *time = self.queryView.selectInfoView.endTimeView.selectTimeLabel.text;
        
        
        self.createEndTime = time;
    }
    
    self.taskName = self.queryView.selectInfoView.eventName.infoTextField.text;
    [self.mainTableView.mj_header beginRefreshing];
}


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        
        [_mainTableView registerClass:[ZLMyTaskChangAndDeleteCell class] forCellReuseIdentifier:@"ZLMyTaskChangAndDeleteCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.sectionFooterHeight = 20;
        _mainTableView.sectionHeaderHeight = 0;
        _mainTableView.contentInset = UIEdgeInsetsMake(20 - 35, 0, 0, 0);
        
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 150;
        
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
