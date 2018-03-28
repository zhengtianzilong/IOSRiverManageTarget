//
//  ZLRiverInfoTwoPictureVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/1/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverInfoTwoPictureVC.h"
#import "ZLPolicyRiverFiveTableViewCell.h"
#import "ZLPolicyFiveModel.h"
@interface ZLRiverInfoTwoPictureVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end

@implementation ZLRiverInfoTwoPictureVC

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
    
    //    ZLRiverInfoManagerVC *vc = [[ZLRiverInfoManagerVC alloc]init];
    //    vc.title = @"呵呵呵";
    //    [self.navigationController pushViewController:vc animated:YES];
    
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
        
        NSArray *titleArray = @[@"河道现状图",
                                @"河道治理与保护工程示意图",
                                ];
        NSArray *imageArray = @[@"info_status",
                                @"info_protect",
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
