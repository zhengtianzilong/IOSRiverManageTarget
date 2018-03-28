//
//  ZLTaskDealDetailVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLTaskDealDetailVC.h"
#import "ZLTaskInfoTableViewCell.h"
#import "ZLRiverPeopleNameAndEditBtnView.h"
#import "ZLTaskDetailByIdService.h"
#import "ZLTaskInfoDetailModel.h"
#import "WJYAlertInputTextView.h"
#import "WJYAlertView.h"
#import "ZLMyAdviseBottomView.h"
#import "ZLNewContiTaskDownVC.h"
@interface ZLTaskDealDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *sourceArray;;

@property (nonatomic, strong) NSMutableArray *taskInfoList;

@end

@implementation ZLTaskDealDetailVC

- (void)getData{
    
    ZLTaskDetailByIdService *service = [[ZLTaskDetailByIdService alloc]initWithtaskId:_dataModel.taskId];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLTaskInfoDetailModel *detailModel = [[ZLTaskInfoDetailModel alloc]initWithString:request.responseString error:nil];
        
        if ([detailModel.code isEqualToString:@"0"]) {

            [self.taskInfoList addObject:detailModel.data];
            [self.sourceArray addObject:self.taskInfoList];
            
        }
        
        
        [self.mainTableView reloadData];
        //        [self.mainTableView.mj_header endRefreshing];
        //        [self.mainTableView.mj_footer endRefreshing];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.taskInfoList = [NSMutableArray array];
    self.sourceArray = [NSMutableArray array];
    [self getData];
    
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    
    [self.view addSubview:self.mainTableView];
    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];
    
    
    
    
}


#pragma mark -- 列表的代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *array = self.sourceArray.firstObject;
    return array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    return self.sourceData.count;
    return self.sourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    ZLRiverPeopleNameAndEditBtnView *head;
    if (section == 0) {
        head = [[ZLRiverPeopleNameAndEditBtnView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 45) WithName:@"任务信息"];
    }
    head.nameLable.textColor = [UIColor blackColor];
    [view addSubview:head];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZLTaskInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLTaskInfoTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.taskInfoList.count > 0) {
            ZLTaskInfoDetailDataModel *dataModel = self.taskInfoList[indexPath.section];
            cell.dataModel = dataModel;
        }
        
        return cell;
    }
    
    return nil;
}


/**
 继续下发
 */
- (void)startButtonClick{
    
    ZLNewContiTaskDownVC *vc = [[ZLNewContiTaskDownVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


/**
 任务反馈
 */
- (void)endButtonClick{
    
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        
        [_mainTableView registerClass:[ZLTaskInfoTableViewCell class] forCellReuseIdentifier:@"ZLTaskInfoTableViewCell"];
        
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 150;
        
        //        _mainTableView.contentInset = UIEdgeInsetsMake(20 - 35, 0, 0, 0);
        
        UIView *headerView = [[UIView alloc] init];
        
        headerView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        ZLMyAdviseBottomView *bottomView = [[ZLMyAdviseBottomView alloc]initWithFrame:CGRectMake(0, 50, Main_Screen_Width, 50 * kScreenHeightRatio)withTitles:@[@"继续下发", @"任务反馈"]];
        
        if (_dataModel.taskChildCode != nil) {
            [bottomView setStartButtonHidden:YES];
        }

        [bottomView.startButton addTarget:self action:@selector(startButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        [bottomView.endButton addTarget:self action:@selector(endButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        [headerView addSubview:bottomView];
        headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, CGRectGetMaxY(bottomView.frame));
        _mainTableView.tableFooterView = headerView;
        
        
        
    }
    return _mainTableView;
}


- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"任务详情" attributes:dic];
    
    return title;
    
}
@end
