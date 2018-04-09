//
//  ZLRiverRecordVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverRecordVC.h"
#import "ZLQueryView.h"
#import "ZLRiverRecordCell.h"
#import "ZLGaodeDetailViewController.h"
#import "ZLGetRiverPatrolListByUserCodeService.h"
#import "ZLRiverRecordModel.h"
@interface ZLRiverRecordVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) ZLQueryView *recordView;
// 最后一个cell的数据创建时间,便于分页
@property (nonatomic, strong) NSString *lastCreateTime;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, strong) NSString *quertStartTime;

@property (nonatomic, strong) NSString *quertEntTime;

@property (nonatomic, strong) NSString *queryRiverName;

@end

@implementation ZLRiverRecordVC

- (void)getData {
    
    [self.mainTableView ly_hideEmptyView];
    
    ZLGetRiverPatrolListByUserCodeService *service = [[ZLGetRiverPatrolListByUserCodeService alloc]initWithpageSize:@"10" startTime:self.lastCreateTime quertStartTime:self.quertStartTime quertEntTime:self.quertEntTime queryRiverName:self.queryRiverName];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLRiverRecordModel *model = [[ZLRiverRecordModel alloc]initWithString:request.responseString error:nil];

        if ([model.code isEqualToString:@"0"]) {

            if ([_lastCreateTime isEqualToString: @""]) {

                [_sourceArray removeAllObjects];

            }

            for (ZLRiverRecordDataModel *dataModel in model.data) {
                [_sourceArray addObject:dataModel];
            }
        }

        [self.mainTableView reloadData];
        
        [self setEmpty];
        
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        
        [self.mainTableView ly_hideEmptyView];
        
    }];
}


- (void)setEmpty{
    if (self.sourceArray.count > 0) {
        [self.mainTableView ly_hideEmptyView];
    }else{
        [self.mainTableView ly_showEmptyView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    
    _recordView = [[ZLQueryView alloc]init];
    self.sourceArray = [NSMutableArray array];
    [self.view addSubview:_recordView];
    
    [self.view addSubview:self.mainTableView];
    [self setTabViewHeadView];
    
    self.lastCreateTime = @"";
    self.queryRiverName = @"";
    self.quertEntTime = @"";
    self.quertStartTime = @"";
    //框架方法
    self.mainTableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"empty_jd"
                                                                titleStr:@"暂无数据，点击重新加载"
                                                               detailStr:@""];
    
    self.mainTableView.ly_emptyView.autoShowEmptyView = NO;
    //emptyView内容上的点击事件监听
    __weak typeof(self)weakSelf = self;
    [self.mainTableView.ly_emptyView setTapContentViewBlock:^{
        //        [weakSelf getData];
        [weakSelf.mainTableView.mj_header beginRefreshing];
        
    }];
    
    [self getData];
    
}

- (void)setTabViewHeadView{
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];
    [self.mainTableView setNeedsLayout];
    [self.mainTableView layoutIfNeeded];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 1)];
    
    self.recordView = [[ZLQueryView alloc] init];
    [self.recordView.queryButton addTarget:self action:@selector(queryButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    //        con.backgroundColor = [UIColor blackColor];
    [headView addSubview:self.recordView];
    
    [self.recordView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    if ([self.recordView.selectInfoView.startTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
        self.quertStartTime = @"";
    }else{
        NSString *time = self.recordView.selectInfoView.startTimeView.selectTimeLabel.text;
        
        self.quertStartTime = time;
    }
    
    if ([self.recordView.selectInfoView.endTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
        self.quertEntTime = @"";
    }else{
        NSString *time = self.recordView.selectInfoView.endTimeView.selectTimeLabel.text;
        self.quertEntTime = time;
    }
    
    self.queryRiverName = self.recordView.selectInfoView.nameAndTextField.infoTextField.text;
    
    [self.mainTableView.mj_header beginRefreshing];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLRiverRecordCell *cell = (ZLRiverRecordCell *)[tableView dequeueReusableCellWithIdentifier:@"ZLRiverRecordCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    ZLRiverRecordDataModel *dataModel = _sourceArray[indexPath.row];
    
    cell.listDataModel = dataModel;
    
    if (indexPath.row == _sourceArray.count - 1) {
//        ZLRiverRecordDataModel *dataModel = _sourceArray[indexPath.row];
        _lastCreateTime = dataModel.START_TIME;
        
    }
    
  
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     ZLRiverRecordDataModel *dataModel = _sourceArray[indexPath.row];
    
    ZLGaodeDetailViewController *detailVC = [[ZLGaodeDetailViewController alloc]init];
    
    detailVC.recordModel = dataModel;
//    detailVC.partolCode = dataModel.PATROL_CODE;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLRiverRecordCell class] forCellReuseIdentifier:@"ZLRiverRecordCell"];
        
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.tableFooterView = [UIView new];
        
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _mainTableView.estimatedRowHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.estimatedSectionFooterHeight = 0;
        
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _lastCreateTime = @"";
            [self getData];
            
        }];
        
        _mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self getData];
            
        }];
        
        
//        _mainTableView.backgroundColor = [UIColor lightGrayColor];
    }
    return _mainTableView;
    
}


- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"巡河记录" attributes:dic];
    return title;
    
    
}


@end
