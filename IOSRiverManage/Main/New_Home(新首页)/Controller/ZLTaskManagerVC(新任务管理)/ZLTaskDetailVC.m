//
//  ZLTaskDetailVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLTaskDetailVC.h"
#import "ZLTaskInfoTableViewCell.h"
#import "ZLTimeLineTableViewCell.h"
#import "ZLTaskDealDetailCell.h"
#import "ZLMyEventAdviseVC.h"
#import "ZLRiverPeopleNameAndEditBtnView.h"
#import "ZLTaskDetailByIdService.h"
#import "ZLTaskInfoDetailModel.h"
#import "WJYAlertInputTextView.h"
#import "WJYAlertView.h"
#import "ZLCheckRejectTaskService.h"
#import "ZLCheckOkTaskService.h"

@interface ZLTaskDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;

// 任务跟踪
@property (nonatomic, strong) NSMutableArray *incidentList;

// 任务处理详情列表
@property (nonatomic, strong) NSMutableArray *riverTaskDetailList;

@property (nonatomic, strong) NSMutableArray *sourceArray;;

@property (nonatomic, strong) NSMutableArray *taskInfoList;

@end

@implementation ZLTaskDetailVC

- (void)getData{
    
    ZLTaskDetailByIdService *service = [[ZLTaskDetailByIdService alloc]initWithtaskId:self.code];

    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLTaskInfoDetailModel *detailModel = [[ZLTaskInfoDetailModel alloc]initWithString:request.responseString error:nil];
        
        if ([detailModel.code isEqualToString:@"0"]) {
           
            for (ZLTaskIncidentListModel *model in detailModel.data.incidentList) {
                [self.incidentList addObject:model];
                
            }
            
            for (ZLTaskRiverTaskDetailListModel *model in detailModel.data.riverTaskDetailList) {
                [self.riverTaskDetailList addObject:model];
                
            }
            
            [self.taskInfoList addObject:detailModel.data];
            [self.sourceArray addObject:self.taskInfoList];
            [self.sourceArray addObject:self.riverTaskDetailList];
            [self.sourceArray addObject:self.incidentList];
            
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
    
    self.incidentList = [NSMutableArray array];
    self.riverTaskDetailList = [NSMutableArray array];
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

- (void)clickAddButton{
    
    ZLMyEventAdviseVC *vc = [[ZLMyEventAdviseVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
        head = [[ZLRiverPeopleNameAndEditBtnView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 45) WithName:@"任务信息"];
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
    if (indexPath.section == 0) {
        ZLTaskInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLTaskInfoTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.taskInfoList.count > 0) {
            ZLTaskInfoDetailDataModel *dataModel = self.taskInfoList[indexPath.section];
            cell.dataModel = dataModel;
        }

        return cell;
    }
    
    if (indexPath.section == 1) {
        ZLTaskDealDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLTaskDealDetailCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.riverTaskDetailList.count > 0) {
            ZLTaskRiverTaskDetailListModel *dataModel = self.riverTaskDetailList[indexPath.row];
            
            
            
            cell.dataModel = dataModel;
            
            cell.detailClick = ^(ZLTaskRiverTaskDetailListModel *model) {
                WJYAlertInputTextView *alertView = [[WJYAlertInputTextView alloc]initPagesViewWithTitle:@"审批意见" leftButtonTitle:@"取消" rightButtonTitle:@"确定" placeholderText:@"请输入审批意见"];
                
                
                WJYAlertView *alert = [[WJYAlertView alloc]initWithCustomView:alertView dismissWhenTouchedBackground:YES];
                
                alertView.leftBlock = ^(NSString *text) {
                    [alert dismissWithCompletion:nil];
                };
                
                alertView.rightBlock = ^(NSString *text) {
                    
                    [alert dismissWithCompletion:^{
                        [SVProgressHUD showWithStatus:@"审批上传中"];
                        ZLCheckRejectTaskService *service = [[ZLCheckRejectTaskService alloc]initWithtaskDetailId:model.ID approvalOpinion:text];
                        [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                            
                            ZLBaseModel *baseModel = [[ZLBaseModel alloc]initWithString:request.responseString error:nil];
                            
                            if ([baseModel.code isEqualToString:@"0"]) {
                                [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                                [SVProgressHUD dismissWithDelay:0.3];
                            }else{
                                [SVProgressHUD showErrorWithStatus:baseModel.detail];
                                [SVProgressHUD dismissWithDelay:0.3];
                                
                            }
                        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                            
                            [SVProgressHUD showErrorWithStatus:@"网络错误"];
                            [SVProgressHUD dismissWithDelay:0.3];
                            
                        }];
                    }];
                };
                [alert show];
                
               
            };
            
            if (![cell.completeBtn isHidden]) {
                cell.completeClick = ^(ZLTaskRiverTaskDetailListModel *model) {
                    WJYAlertInputTextView *alertView = [[WJYAlertInputTextView alloc]initPagesViewWithTitle:@"审批意见" leftButtonTitle:@"取消" rightButtonTitle:@"确定" placeholderText:@"请输入审批意见"];
                    
                    
                    WJYAlertView *alert = [[WJYAlertView alloc]initWithCustomView:alertView dismissWhenTouchedBackground:YES];
                    
                    alertView.leftBlock = ^(NSString *text) {
                        [alert dismissWithCompletion:nil];
                    };
                    
                    alertView.rightBlock = ^(NSString *text) {
                        
                        [alert dismissWithCompletion:^{
                            [SVProgressHUD showWithStatus:@"审批上传中"];
                            ZLCheckOkTaskService *service = [[ZLCheckOkTaskService alloc]initWithtaskDetailId:model.ID approvalOpinion:text];
                            [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                                
                                ZLBaseModel *baseModel = [[ZLBaseModel alloc]initWithString:request.responseString error:nil];
                                
                                if ([baseModel.code isEqualToString:@"0"]) {
                                    [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                                    [SVProgressHUD dismissWithDelay:0.3];
                                }else{
                                    [SVProgressHUD showErrorWithStatus:baseModel.detail];
                                    [SVProgressHUD dismissWithDelay:0.3];
                                    
                                }
                            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                                
                                [SVProgressHUD showErrorWithStatus:@"网络错误"];
                                [SVProgressHUD dismissWithDelay:0.3];
                                
                            }];
                        }];
                    };
                    [alert show];
                };
            }
            
            if (![cell.backBtn isHidden]) {
                cell.backClick = ^(ZLTaskRiverTaskDetailListModel *model) {
                    WJYAlertInputTextView *alertView = [[WJYAlertInputTextView alloc]initPagesViewWithTitle:@"审批意见" leftButtonTitle:@"取消" rightButtonTitle:@"确定" placeholderText:@"请输入审批意见"];
                    
                    
                    WJYAlertView *alert = [[WJYAlertView alloc]initWithCustomView:alertView dismissWhenTouchedBackground:YES];
                    
                    alertView.leftBlock = ^(NSString *text) {
                        [alert dismissWithCompletion:nil];
                    };
                    
                    alertView.rightBlock = ^(NSString *text) {
                        
                        [alert dismissWithCompletion:^{
                            [SVProgressHUD showWithStatus:@"审批上传中"];
                            ZLCheckRejectTaskService *service = [[ZLCheckRejectTaskService alloc]initWithtaskDetailId:model.ID approvalOpinion:text];
                            [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                                
                                ZLBaseModel *baseModel = [[ZLBaseModel alloc]initWithString:request.responseString error:nil];
                                
                                if ([baseModel.code isEqualToString:@"0"]) {
                                    [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                                    [SVProgressHUD dismissWithDelay:0.3];
                                }else{
                                    [SVProgressHUD showErrorWithStatus:baseModel.detail];
                                    [SVProgressHUD dismissWithDelay:0.3];
                                    
                                }
                            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                                
                                [SVProgressHUD showErrorWithStatus:@"网络错误"];
                                [SVProgressHUD dismissWithDelay:0.3];
                                
                            }];
                        }];
                    };
                    [alert show];
                    
                };
            }
            
        }
        return cell;
    }
    
    if (indexPath.section == 2) {
        ZLTimeLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLTimeLineTableViewCell" forIndexPath:indexPath];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.incidentList.count > 0) {
            ZLTaskIncidentListModel *dataModel = self.incidentList[indexPath.row];
            
            cell.dataModel = dataModel;
            
            if (indexPath.row == 0) {
                
                cell.topLineView.hidden = YES;
                
            }
            
        }
        return cell;
    }
    return nil;
}




- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        
        [_mainTableView registerClass:[ZLTaskInfoTableViewCell class] forCellReuseIdentifier:@"ZLTaskInfoTableViewCell"];
        [_mainTableView registerClass:[ZLTaskDealDetailCell class] forCellReuseIdentifier:@"ZLTaskDealDetailCell"];
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
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"任务详情" attributes:dic];
    
    return title;
    
}

@end
