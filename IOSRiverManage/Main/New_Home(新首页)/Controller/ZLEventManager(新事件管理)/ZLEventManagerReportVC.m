//
//  ZLMyWaitWorkVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManagerReportVC.h"
#import "ZLMyEventCell.h"
#import "ZLMyEventDetailVC.h"
#import "ZLNewChangeEventReportVC.h"
#import "ZLEventManagerReportService.h"
#import "ZLEventManagerReportModel.h"
#import "ZLDelIncidentService.h"
@interface ZLEventManagerReportVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *incidentName;

@property (nonatomic, strong) NSString *createStartTime;
@property (nonatomic, strong) NSString *createEndTime;
// 最后一个cell的数据创建时间,便于分页
@property (nonatomic, strong) NSString *lastCreateTime;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, assign) BOOL isPush;

@end

@implementation ZLEventManagerReportVC
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
    ZLEventManagerReportService *service = [[ZLEventManagerReportService alloc]initWithpageSize:10 incidentName:self.incidentName createBeginTime:self.createStartTime createEndTime:self.createEndTime appPageCreateTime:self.lastCreateTime];
    
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
    _isPush = YES;
    self.createEndTime = @"";
    self.createStartTime = @"";
    self.incidentName = @"";
    _sourceArray = [NSMutableArray array];
    
    _lastCreateTime = @"";
    
    [self getData];
    
    [self.view addSubview:self.mainTableView];
    
    [self setTabViewHeadView];
    
    
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
    
    self.incidentName = self.queryView.selectInfoView.eventName.infoTextField.text;
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
    
    self.queryView = [[ZLZLQueryEventDownView alloc] init];
    
    [self.queryView.queryButton addTarget:self action:@selector(queryButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLMyEventDetailVC *vc = [[ZLMyEventDetailVC alloc]init];
    
    ZLEventManagerReportDataModel *model = self.sourceArray[indexPath.section];
    
    vc.eventId = model.ID;
    vc.userCode = self.userCode;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLMyEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyEventCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.userCode = self.userCode;
    
    ZLEventManagerReportDataModel *model = self.sourceArray[indexPath.section];
    
    cell.dataModel = model;
    
    if (indexPath.section == _sourceArray.count - 1) {
        ZLEventManagerReportDataModel *dataModel = _sourceArray[indexPath.section];
        _lastCreateTime = dataModel.createTime;
        
    }
    __weak typeof(self) weakSelf = self;
    
    cell.changeClick = ^(ZLEventManagerReportDataModel *dataModel) {
        ZLNewChangeEventReportVC *changeVC = [[ZLNewChangeEventReportVC alloc]init];
        changeVC.dataModel = dataModel;
        [weakSelf.navigationController pushViewController:changeVC animated:YES];
        
    };
    
        cell.deleteClick = ^(ZLEventManagerReportDataModel *model) {
            
            DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"提示" message:@"确认删除吗?" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
            
            alert.otherButtonAction = ^{
                
                ZLDelIncidentService *service = [[ZLDelIncidentService alloc]initWitheventId:model.ID];
                [SVProgressHUD showWithStatus:@"删除中"];
                [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    
                    ZLBaseModel *model = [[ZLBaseModel alloc]initWithString:request.responseString error:nil];
                    
                    if ([model.code isEqualToString:@"0"]) {
                        
                        [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                        [SVProgressHUD dismissWithDelay:0.3 completion:^{
                            
                            [self.sourceArray removeObjectAtIndex:indexPath.section];
                            
                            [tableView reloadData];
                            
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
        
        
    };
    
    return cell;
}


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        
        [_mainTableView registerClass:[ZLMyEventCell class] forCellReuseIdentifier:@"ZLMyEventCell"];
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
