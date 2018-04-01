//
//  ZLMyventDealDetailVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyventDealDetailVC.h"
#import "ZLMyEventDealDetailCell.h"
#import "ZLMyEventAdviseVC.h"
#import "ZLMyAdviseBottomView.h"
#import "ZLNewContiEventReportVC.h"
#import "ZLMyEventAdviseVC.h"
#import "ZLEventManagerDetailService.h"
#import "ZLEventDetailModel.h"
#import "ZLRiverPeopleNameAndEditBtnView.h"
#import "ZLEventInfoCell.h"
@interface ZLMyventDealDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) ZLEventDetailDataModel *dataModel;



@end

@implementation ZLMyventDealDetailVC

- (void)getData{
    
    ZLEventManagerDetailService *service = [[ZLEventManagerDetailService alloc]initWitheventId:self.eventId];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLEventDetailModel *detailModel = [[ZLEventDetailModel alloc]initWithString:request.responseString error:nil];
        
        if ([detailModel.code isEqualToString:@"0"]) {
            
            ZLRiverIncidentDetailListModel *model = detailModel.data.riverIncidentDetailList.lastObject;
            
            self.dataModel = detailModel.data;
            
            if (model) {
                self.dataModel.receiverDepartName = model.groupName;
                self.dataModel.receiverPersonName = model.userName;
                
            }
            
        }
       
        [self.mainTableView reloadData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    
    [self.view addSubview:self.mainTableView];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];

    
}

#pragma mark -- 列表的代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    return self.sourceData.count;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    ZLRiverPeopleNameAndEditBtnView *head;
    if (section == 0) {
        head = [[ZLRiverPeopleNameAndEditBtnView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 45) WithName:@"事件信息"];
    }
    head.nameLable.textColor = [UIColor blackColor];
    [view addSubview:head];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLEventInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLEventInfoCell" forIndexPath:indexPath];
    
    if (_dataModel) {
        cell.dataModel = self.dataModel;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
    return cell;
}

- (void)startButtonClick{
    
    ZLNewContiEventReportVC *vc = [[ZLNewContiEventReportVC alloc]init];
    
    vc.incidentid = self.dataModel.ID;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

/**
 事件反馈
 */
- (void)endButtonClick{
    ZLMyEventAdviseVC *vc = [[ZLMyEventAdviseVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLEventInfoCell class] forCellReuseIdentifier:@"ZLEventInfoCell"];
        
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 100;
        
        UIView *headerView = [[UIView alloc] init];

        headerView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        ZLMyAdviseBottomView *bottomView = [[ZLMyAdviseBottomView alloc]initWithFrame:CGRectMake(0, 50, Main_Screen_Width, 50 * kScreenHeightRatio)withTitles:@[@"继续上报", @"事件反馈"]];
        
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
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"事件处理" attributes:dic];
    return title;
    
    
}

@end
