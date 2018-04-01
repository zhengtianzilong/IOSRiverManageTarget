//
//  ZLMyLaunchWorkVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManagerWaitVC.h"
#import "ZLMyEventWaitCell.h"
#import "ZLMyventDealDetailVC.h"
#import "ZLEventManagerWaitService.h"
#import "ZLEventManagerReportModel.h"
#import "ZLMyEventDetailVC.h"
#import "ZLReceiveIncidentService.h"

@interface ZLEventManagerWaitVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *incidentName;
@property (nonatomic, strong) NSString *createUserName;
@property (nonatomic, strong) NSString *createStartTime;
@property (nonatomic, strong) NSString *createEndTime;
// 最后一个cell的数据创建时间,便于分页
@property (nonatomic, strong) NSString *lastCreateTime;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@end

@implementation ZLEventManagerWaitVC
- (void)getData{
    ZLEventManagerWaitService *service = [[ZLEventManagerWaitService alloc]initWithpageSize:10      incidentName:self.incidentName createUserName:self.createUserName createBeginTime:self.createStartTime createEndTime:self.createEndTime appPageCreateTime:self.lastCreateTime];
    
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
    self.createUserName = self.queryView.selectInfoView.people.infoTextField.text;
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
    
    self.queryView = [[ZLQueryEventManageView alloc] init];
    
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
    
    ZLMyEventWaitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyEventWaitCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
     cell.userCode = self.userCode;
    
    ZLEventManagerReportDataModel *model = self.sourceArray[indexPath.section];
    
    cell.dataModel = model;
    
    if (indexPath.section == _sourceArray.count - 1) {
        ZLEventManagerReportDataModel *dataModel = _sourceArray[indexPath.section];
        _lastCreateTime = dataModel.createTime;
        
    }
    __weak typeof(self) weakSelf = self;
    
    cell.dealClick = ^(NSString *eventId, NSString *detailId, UIButton *dealBtn) {
        if ([dealBtn.currentTitle isEqualToString:@"接收"]) {
            
            DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"提示" message:@"确认接收吗?" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
            
            alert.otherButtonAction = ^{
                
                ZLReceiveIncidentService *service = [[ZLReceiveIncidentService alloc]initWithriverIncidentDetailId:detailId eventId:eventId];
                [SVProgressHUD showWithStatus:@"接收中"];
                [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    
                    ZLBaseModel *model = [[ZLBaseModel alloc]initWithString:request.responseString error:nil];
                    
                    if ([model.code isEqualToString:@"0"]) {
                        
                        [SVProgressHUD showSuccessWithStatus:@"接收成功"];
                        [SVProgressHUD dismissWithDelay:0.3 completion:^{
                            
                            [tableView.mj_header beginRefreshing];
                            
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
            ZLMyventDealDetailVC *vc = [[ZLMyventDealDetailVC alloc]init];
            vc.eventId = eventId;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }

    };
    
    
    return cell;
    
    
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        
        [_mainTableView registerClass:[ZLMyEventWaitCell class] forCellReuseIdentifier:@"ZLMyEventWaitCell"];
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
