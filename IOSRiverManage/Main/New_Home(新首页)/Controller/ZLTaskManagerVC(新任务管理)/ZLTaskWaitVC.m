//
//  ZLTaskWaitVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLTaskWaitVC.h"
#import "ZLMyTaskWaitCell.h"
#import "ZLMyventDealDetailVC.h"
#import "ZLFindMyToDoTaskListService.h"
@interface ZLTaskWaitVC ()
@property (nonatomic, strong) NSString *createName;

// 最后一个cell的数据创建时间,便于分页
@property (nonatomic, strong) NSString *lastCreateTime;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@end

@implementation ZLTaskWaitVC

- (void)getData{
    ZLFindMyToDoTaskListService *service = [[ZLFindMyToDoTaskListService alloc]initWithpageSize:10 createTimeFormat:_lastCreateTime taskName:_taskName createName:_createName createStartTime:_createStartTime createEndTime:_createEndTime];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZLLog(@"%@",request.responseString);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.createEndTime = @"";
    self.createStartTime = @"";
    self.taskName = @"";
    self.createName = @"";
    _sourceArray = [NSMutableArray array];
    
    _lastCreateTime = @"";
    
    [self getData];
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
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
    
    self.queryView = [[ZLQueryEventManageView alloc] init];
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
     self.createName = self.queryView.selectInfoView.people.infoTextField.text;
    [self.mainTableView.mj_header beginRefreshing];
}


#pragma mark -- 列表的代理
- (NSInteger)setSectionsCount{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self setSectionsCount];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLMyTaskWaitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyTaskWaitCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof(self) weakSelf = self;
    
    cell.dealClick = ^{
        ZLMyventDealDetailVC *vc = [[ZLMyventDealDetailVC alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLTaskDetailVC *vc = [[ZLTaskDetailVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}




- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
         [self.mainTableView registerClass:[ZLMyTaskWaitCell class] forCellReuseIdentifier:@"ZLMyTaskWaitCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.sectionFooterHeight = 20;
        _mainTableView.sectionHeaderHeight = 0;
        _mainTableView.contentInset = UIEdgeInsetsMake(20 - 35, 0, 0, 0);
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
