//
//  ZLRiverInfoPeopleVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/1/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverInfoPeopleVC.h"
#import "ZLHomeLoopTopView.h"
#import "ZLRiverPeoplePhoneView.h"
#import "ZLRiverPeopleNameAndEditBtnView.h"

#import "ZLGetRiverManageByRiverIdService.h"
#import "ZLRiverManagePeopleModel.h"
@interface ZLRiverInfoPeopleVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) ZLHomeLoopTopView *loopTopView;

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *lowerRiverManageArray;

@property (nonatomic, strong) NSMutableArray *riverManageArray;

@end

@implementation ZLRiverInfoPeopleVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.mainTableView.mj_header beginRefreshing];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    
    self.lowerRiverManageArray = [NSMutableArray array];
    self.riverManageArray = [NSMutableArray array];
    
    [self.view addSubview:self.mainTableView];
    
//    [self getData];
}

/**
 得到数据
 */
- (void)getData{
    
    ZLGetRiverManageByRiverIdService *service = [[ZLGetRiverManageByRiverIdService alloc]initWithriverId:self.riverCode];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self.lowerRiverManageArray removeAllObjects];
        [self.riverManageArray removeAllObjects];

        ZLRiverManagePeopleModel *infoModel = [[ZLRiverManagePeopleModel alloc]initWithString:request.responseString error:nil];

        if ([infoModel.code isEqualToString:@"0"]) {

            if (infoModel.data.riverManage.count > 0) {

                for (ZLRIverPeopleDataModel *peopleModel in infoModel.data.riverManage) {
                    [self.riverManageArray addObject:peopleModel];
                }
            }

            if (infoModel.data.lowerRiverManage.count > 0) {
                for (ZLRIverPeopleDataModel *peopleModel in infoModel.data.lowerRiverManage) {

                    [self.lowerRiverManageArray addObject:peopleModel];

                }
            }

        }
        
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        [self.mainTableView reloadData];
        ZLLog(@"%@",request.responseString);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        
    }];
    
    
    
}



- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//
//    if (self.lowerRiverManageArray.count <= 0 || self.riverManageArray.count <= 0) {
//
//        return 1;
//
//    }else{
//        return 2;
//    }
    
    return 2;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return self.riverManageArray.count;
        
    }else{
        return  self.lowerRiverManageArray.count;
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    ZLRiverPeopleNameAndEditBtnView *head;
    if (section == 0) {
         head = [[ZLRiverPeopleNameAndEditBtnView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50) WithName:@"河长联系方式"];
    }else{
         head = [[ZLRiverPeopleNameAndEditBtnView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50) WithName:@"下级河长"];
    }
    [view addSubview:head];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        ZLRiverPeoplePhoneView *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLRiverPeoplePhoneView" forIndexPath:indexPath];
        
        ZLRIverPeopleDataModel *model = self.riverManageArray[indexPath.row];
        cell.dataModel = model;
        return cell;
    }else{
        ZLRiverPeoplePhoneView *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLRiverPeoplePhoneView" forIndexPath:indexPath];
        ZLRiverPeopleLowerModel *model = self.lowerRiverManageArray[indexPath.row];
        
        cell.lowerModel = model;
        
        return cell;
        
    }
    
    return nil;
}



- (ZLHomeLoopTopView *)loopTopView{
    
    if (!_loopTopView) {
        
        _loopTopView = [[ZLHomeLoopTopView alloc]init];
        
        
    }
    return _loopTopView;
    
}


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        
        [_mainTableView registerClass:[ZLRiverPeoplePhoneView class] forCellReuseIdentifier:@"ZLRiverPeoplePhoneView"];
        
        _mainTableView.delegate = self;
        
        _mainTableView.dataSource = self;
        
        _mainTableView.tableHeaderView = [[ZLHomeLoopTopView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width / 2.0 - 15)];
        
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self getData];
            
        }];

        
    }
    return _mainTableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
