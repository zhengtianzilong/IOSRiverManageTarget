//
//  ZLOverSeeVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/6.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLOverSeeVC.h"
#import "ZLGetSuperviseTaskListService.h"
#import "ZLSuperviseModel.h"
@interface ZLOverSeeVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger requestStart;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, strong) NSString *department;
@property (nonatomic, strong) NSString *superviseName;
@property (nonatomic, strong) NSString *assignCode;
@property (nonatomic, strong) NSString *superviseUnit;
@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *startTime;

@property (nonatomic, strong) NSString *superviseStartTime;

@property (nonatomic, strong) NSString *superviseEndTime;

@end
@implementation ZLOverSeeVC

- (void)getData {
    
    ZLGetSuperviseTaskListService *service = [[ZLGetSuperviseTaskListService alloc]initWithpageSize:10 currentPage:1 superviseName:self.superviseName assignCode:self.assignCode superviseUnit:self.superviseUnit departName:self.department userName:self.userName startTime:self.startTime superviseStartTime:self.superviseStartTime superviseEndTime:self.superviseEndTime];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLSuperviseModel *model = [[ZLSuperviseModel alloc]initWithString:request.responseString error:nil];
        
        if ([model.code isEqualToString:@"0"]) {
            
            if ([_startTime isEqualToString:@""]) {
                [_sourceArray removeAllObjects];
            }
            
            for (ZLSuperviseRowDetailModel *dataModel in model.data.rows) {
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
    
    self.department = @"";
    self.superviseUnit = @"";
    self.superviseName = @"";
    self.userName = @"";
    self.assignCode = @"";
    self.startTime = @"";
    self.superviseEndTime = @"";
    self.superviseStartTime = @"";
    
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
    
    self.queryView = [[ZLQueryOverSeeView alloc] init];
    //        con.backgroundColor = [UIColor blackColor];
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
    
    ZLSuperviseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLSuperviseTableViewCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ZLSuperviseRowDetailModel *detailModel = self.sourceArray[indexPath.section];
    cell.detailModel = detailModel;
    
    if (indexPath.section == _sourceArray.count - 1) {
        _startTime = detailModel.createTime;
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLSuperviseRowDetailModel *detailModel = self.sourceArray[indexPath.section];
    
    ZLSuperviseDetailVC *vc = [[ZLSuperviseDetailVC alloc]init];
    vc.code = detailModel.ID;
    
//    vc.status = detailModel.isExpire;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

/**
 查询按钮
 */
- (void)queryButtonClick{
    
    if ([self.queryView.selectInfoView.createStartTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
        self.superviseStartTime = @"";
    }else{
        NSString *time = self.queryView.selectInfoView.createStartTimeView.selectTimeLabel.text;
        
        
        self.superviseStartTime = time;
    }
    
    if ([self.queryView.selectInfoView.createEndTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
        self.superviseEndTime = @"";
    }else{
        NSString *time = self.queryView.selectInfoView.createEndTimeView.selectTimeLabel.text;
        
        
        self.superviseEndTime = time;
    }

    self.superviseName = self.queryView.selectInfoView.eventName.infoTextField.text;
    self.department = self.queryView.selectInfoView.department.infoTextField.text;
    self.userName = self.queryView.selectInfoView.people.infoTextField.text;
    self.superviseUnit = self.queryView.selectInfoView.resDepartment.infoTextField.text;
    self.assignCode = self.queryView.selectInfoView.code.infoTextField.text;
    
    
    [self.mainTableView.mj_header beginRefreshing];
}


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        
        [_mainTableView registerClass:[ZLSuperviseTableViewCell class] forCellReuseIdentifier:@"ZLSuperviseTableViewCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.sectionFooterHeight = 20;
        _mainTableView.sectionHeaderHeight = 0;
        //        _mainTableView.contentInset = UIEdgeInsetsMake(20 - 35, 0, 0, 0);
        //
        
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 500;
        
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
