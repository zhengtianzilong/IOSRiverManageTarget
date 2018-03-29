//
//  ZLMyEventDetailVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyEventDetailVC.h"
#import "ZLEventManagerDetailService.h"
#import "ZLMyEventAdviseVC.h"
#import "WJYAlertInputTextView.h"
#import "WJYAlertView.h"
#import "ZLRiverPeopleNameAndEditBtnView.h"
#import "ZLEventDealDetailCell.h"
#import "ZLEventInfoCell.h"
#import "ZLTimeLineTableViewCell.h"
@interface ZLMyEventDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;

// 任务跟踪
@property (nonatomic, strong) NSMutableArray *incidentList;

// 任务处理详情列表
@property (nonatomic, strong) NSMutableArray *riverTaskDetailList;

@property (nonatomic, strong) NSMutableArray *sourceArray;;

@property (nonatomic, strong) NSMutableArray *taskInfoList;

@end

@implementation ZLMyEventDetailVC

- (void)getData{
    
    ZLEventManagerDetailService *service = [[ZLEventManagerDetailService alloc]initWitheventId:self.eventId];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
//        ZLTaskInfoDetailModel *detailModel = [[ZLTaskInfoDetailModel alloc]initWithString:request.responseString error:nil];
//
//        if ([detailModel.code isEqualToString:@"0"]) {
//
//            for (ZLTaskIncidentListModel *model in detailModel.data.incidentList) {
//                [self.incidentList addObject:model];
//
//            }
//
//            for (ZLTaskRiverTaskDetailListModel *model in detailModel.data.riverTaskDetailList) {
//                [self.riverTaskDetailList addObject:model];
//
//            }
//
//            [self.taskInfoList addObject:detailModel.data];
//            [self.sourceArray addObject:self.taskInfoList];
//            [self.sourceArray addObject:self.riverTaskDetailList];
//            [self.sourceArray addObject:self.incidentList];
        
//        }
        
        
        [self.mainTableView reloadData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.incidentList = [NSMutableArray array];
    self.riverTaskDetailList = [NSMutableArray array];
    self.taskInfoList = [NSMutableArray array];
    self.sourceArray = [NSMutableArray array];
    [self getData];
    
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    
    [self.view addSubview:self.mainTableView];
    
   
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];
    
    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
   
    
    
}

#pragma mark -- 列表的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.incidentList.count;
    }else if (section == 1){
        
        return self.riverTaskDetailList.count;
    }
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
        head = [[ZLRiverPeopleNameAndEditBtnView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 45) WithName:@"事件信息"];
    }else if (section == 1){
        head = [[ZLRiverPeopleNameAndEditBtnView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 45) WithName:@"处理详情"];
    }else{
        head = [[ZLRiverPeopleNameAndEditBtnView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 45) WithName:@"任务跟踪"];
    }
    head.nameLable.textColor = [UIColor blackColor];
    [view addSubview:head];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        ZLTaskInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLTaskInfoTableViewCell" forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        if (self.taskInfoList.count > 0) {
//            ZLTaskInfoDetailDataModel *dataModel = self.taskInfoList[indexPath.section];
//            cell.dataModel = dataModel;
//        }
//
//        return cell;
//    }
//
//    if (indexPath.section == 1) {
//        ZLTaskDealDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLTaskDealDetailCell" forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        if (self.riverTaskDetailList.count > 0) {
//            ZLTaskRiverTaskDetailListModel *dataModel = self.riverTaskDetailList[indexPath.row];
//            cell.dataModel = dataModel;
//        }
//            if (![cell.completeBtn isHidden]) {
//
//            }
//
//        }
//        return cell;
//    }
//
//    if (indexPath.section == 2) {
//        ZLTimeLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLTimeLineTableViewCell" forIndexPath:indexPath];
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        if (self.incidentList.count > 0) {
//            ZLTaskIncidentListModel *dataModel = self.incidentList[indexPath.row];
//
//            cell.dataModel = dataModel;
//
//            if (indexPath.row == 0) {
//
//                cell.topLineView.hidden = YES;
//
//            }
//
//        }
//        return cell;
//    }
    return nil;
}




- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        
        [_mainTableView registerClass:[ZLEventInfoCell class] forCellReuseIdentifier:@"ZLEventInfoCell"];
        [_mainTableView registerClass:[ZLEventDealDetailCell class] forCellReuseIdentifier:@"ZLEventDealDetailCell"];
        [_mainTableView registerClass:[ZLTimeLineTableViewCell class] forCellReuseIdentifier:@"ZLTimeLineTableViewCell"];

        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 150;
        
        //        _mainTableView.contentInset = UIEdgeInsetsMake(20 - 35, 0, 0, 0);
    }
    return _mainTableView;
}


- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"事件详情" attributes:dic];
    
    return title;
    
}
@end
