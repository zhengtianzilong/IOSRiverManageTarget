//
//  ZLHaveNoExamineVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/15.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLHaveNoExamineVC.h"
#import "ZLMyExamineBaseTableViewCell.h"
#import "ZLScoreDetailVC.h"
@interface ZLHaveNoExamineVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger requestStart;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *department;
@property (nonatomic, strong) NSString *departPeople;
@property (nonatomic, strong) NSString *creatStartTime;
@property (nonatomic, strong) NSString *creatEndTime;
@property (nonatomic, strong) NSString *completeStartTime;
@property (nonatomic, strong) NSString *completeEndTime;

@property (nonatomic, strong) NSString *startTime;

@property (nonatomic, strong) UITableView *mainTableView;

@end
@implementation ZLHaveNoExamineVC

//- (void)getData {
//
//    ZLGetAssignTaskListService *service = [[ZLGetAssignTaskListService alloc]initWithpageSize:10 currentPage:1 assignName:self.eventName assignStartTime:self.creatStartTime assignEndTime:self.creatEndTime completeStartTime:self.completeStartTime completeEndTime:self.completeEndTime departName:self.department userName:self.departPeople startTime:self.startTime];
//
//    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//        ZLLog(@"%@",request.responseString);
//
//        ZLAssignTaskRowModel *model = [[ZLAssignTaskRowModel alloc]initWithString:request.responseString error:nil];
//
//        if ([model.code isEqualToString:@"0"]) {
//
//            if ([_startTime isEqualToString:@""]) {
//                [_sourceArray removeAllObjects];
//            }
//
//            for (ZLAssignTaskRowDetailModel *dataModel in model.data.rows) {
//                [_sourceArray addObject:dataModel];
//            }
//        }
//
//        [self.mainTableView reloadData];
//        [self.mainTableView.mj_header endRefreshing];
//        [self.mainTableView.mj_footer endRefreshing];
//
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//        [self.mainTableView.mj_header endRefreshing];
//        [self.mainTableView.mj_footer endRefreshing];
//    }];
//}

- (void)




- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.requestStart = 1;
//
//    self.eventName = @"";
//    self.department = @"";
//    self.departPeople = @"";
//    self.creatStartTime = @"";
//    self.creatEndTime = @"";
//    self.completeStartTime = @"";
//    self.completeEndTime = @"";
//    self.startTime = @"";
//
//    self.sourceArray = [NSMutableArray array];
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    [self.view addSubview:self.mainTableView];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    
//    [self getData];
    
}





#pragma mark -- 列表的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    return self.sourceData.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLMyExamineBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyExamineBaseTableViewCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.scoreClick = ^{
      
        ZLScoreDetailVC *vc = [[ZLScoreDetailVC alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
    
}




- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        
        [_mainTableView registerClass:[ZLMyExamineBaseTableViewCell class] forCellReuseIdentifier:@"ZLMyExamineBaseTableViewCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.sectionFooterHeight = 20;
        _mainTableView.sectionHeaderHeight = 0;
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 180;
        
        
//        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//            _requestStart = 1;
//            _startTime = @"";
//            [self getData];
//
//        }];
//
//        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            //            _requestStart += 1;
//            [self getData];
//
//        }];
        
    }
    return _mainTableView;
}

@end
