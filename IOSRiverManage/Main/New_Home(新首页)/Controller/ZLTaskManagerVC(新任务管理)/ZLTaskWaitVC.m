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
#import "ZLTaskWaitModel.h"
#import "ZLReceiveTaskService.h"
#import "ZLTaskDealDetailVC.h"

#import "ZLNewContiTaskDownVC.h"

@interface ZLTaskWaitVC ()
@property (nonatomic, strong) NSString *createName;

// 最后一个cell的数据创建时间,便于分页
@property (nonatomic, strong) NSString *lastCreateTime;

@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, assign) BOOL isPush;
@end

@implementation ZLTaskWaitVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_isPush) {
        //push
    }else{
        //pop
        _lastCreateTime = @"";
        [self getData];
        
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    _isPush = NO;
    
}


- (void)getData{
    ZLFindMyToDoTaskListService *service = [[ZLFindMyToDoTaskListService alloc]initWithpageSize:10 createTimeFormat:_lastCreateTime taskName:_taskName createName:_createName createStartTime:_createStartTime createEndTime:_createEndTime];

    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZLLog(@"%@",request.responseString);
        
        ZLTaskWaitModel *waitModel = [[ZLTaskWaitModel alloc]initWithString:request.responseString error:nil];
        
        if ([waitModel.code isEqualToString:@"0"]) {
            if ([_lastCreateTime isEqualToString: @""]) {
                
                [_sourceArray removeAllObjects];
                
            }
            for (ZLTaskWaitDataModel *dataModel in waitModel.data) {
                
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
    
    self.createEndTime = @"";
    self.createStartTime = @"";
    self.taskName = @"";
    self.createName = @"";
    _sourceArray = [NSMutableArray array];
    
    _lastCreateTime = @"";
    _isPush = YES;
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
     [self.queryView.queryButton addTarget:self action:@selector(queryButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sourceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLMyTaskWaitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyTaskWaitCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ZLTaskWaitDataModel *model = self.sourceArray[indexPath.section];
    
    cell.dataModel = model;
    
    if (indexPath.section == _sourceArray.count - 1) {
        ZLTaskWaitDataModel *dataModel = _sourceArray[indexPath.section];
        _lastCreateTime = dataModel.createTime;
        
    }
    
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
                            _lastCreateTime = @"";
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
//            vc.dataModel = dataModel;
            
            vc.taskDetailID = dataModel.taskDetailId;
            vc.taskId = dataModel.taskId;
            vc.childCode = dataModel.taskChildCode;
            
            [weakSelf.navigationController pushViewController:vc animated:YES];
        
        }else if ([dealBtn.currentTitle isEqualToString:@"重做"]){
            ZLTaskDealDetailVC *vc = [[ZLTaskDealDetailVC alloc]init];
            //            vc.dataModel = dataModel;
            
            vc.taskDetailID = dataModel.taskDetailId;
            vc.taskId = dataModel.taskId;
            vc.childCode = dataModel.taskChildCode;
            
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }

        
    };
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLTaskDetailVC *vc = [[ZLTaskDetailVC alloc]init];
    
    ZLTaskWaitDataModel *dataModel = self.sourceArray[indexPath.section];
//    vc.passCode = @"待办任务";
    vc.code = dataModel.taskId;
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
        _mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 180;
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _lastCreateTime = @"";
            [self getData];
            
        }];
        
        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self getData];
            
        }];
        
    }
    return _mainTableView;
}


@end
