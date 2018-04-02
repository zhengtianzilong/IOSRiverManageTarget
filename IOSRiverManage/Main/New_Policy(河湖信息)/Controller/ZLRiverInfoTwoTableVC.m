//
//  ZLRiverInfoTwoTableVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/1/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverInfoTwoTableVC.h"
#import "ZLPolicyRiverFiveTableViewCell.h"
#import "ZLPolicyFiveModel.h"
#include "ZLRiverInfoFiveDetailVC.h"
@interface ZLRiverInfoTwoTableVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end

@implementation ZLRiverInfoTwoTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    
    [self.view addSubview:self.mainTableView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(10);
        //        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
        
        make.height.mas_equalTo(2 * 50);
        
        make.width.mas_equalTo(Main_Screen_Width);
    }];
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLPolicyRiverFiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLPolicyRiverFiveTableViewCell" forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    ZLPolicyFiveModel *model = self.dataSourceArray[indexPath.row];
    
    cell.fiveModel = model;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLRiverInfoFiveDetailVC *vc = [[ZLRiverInfoFiveDetailVC alloc]init];
    
    NSArray *array = @[self.riverCode,[NSString stringWithFormat:@"%ld",(long)indexPath.row + 5]];
    
    vc.riverCodeAndIndex = array;
    
    [self presentViewController:vc animated:YES completion:nil];
}


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLPolicyRiverFiveTableViewCell class] forCellReuseIdentifier:@"ZLPolicyRiverFiveTableViewCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.bounces = NO;
        
        
    }
    return _mainTableView;
}

- (NSMutableArray *)dataSourceArray{
    
    if (!_dataSourceArray) {
        
        _dataSourceArray = [NSMutableArray array];
        
        NSArray *titleArray = @[@"目标任务分析表",
                                @"计划实施安排表",
                                ];
        NSArray *imageArray = @[@"info_analysis",
                                @"info_plan",
                                ];
        for (int i = 0; i < titleArray.count; i++) {
            
            ZLPolicyFiveModel *model = [[ZLPolicyFiveModel alloc]init];
            model.title = titleArray[i];
            model.imageName = imageArray[i];
            
            [_dataSourceArray addObject:model];
        }
        
    }
    
    return _dataSourceArray;
    
}

@end
