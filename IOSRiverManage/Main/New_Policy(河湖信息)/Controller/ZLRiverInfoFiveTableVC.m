//
//  ZLRiverInfoFiveTableVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/1/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverInfoFiveTableVC.h"
#import "ZLPolicyRiverFiveTableViewCell.h"
#import "ZLPolicyFiveModel.h"
#import "ZLRiverInfoQuestionVC.h"
@interface ZLRiverInfoFiveTableVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end

@implementation ZLRiverInfoFiveTableVC

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
        
        make.height.mas_equalTo(5 * 50);
        
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
    
    ZLRiverInfoQuestionVC *vc = [[ZLRiverInfoQuestionVC alloc]init];
    
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
        
        NSArray *titleArray = @[@"问题清单",
                                @"目标清单",
                                @"任务清单",
                                @"措施清单",
                                @"责任清单",
                                ];
        NSArray *imageArray = @[@"info_question",
                                @"info_target",
                                @"info_task",
                                @"info_measure",
                                @"info_duty",
                                ];
        for (int i = 0; i < 5; i++) {
            
            ZLPolicyFiveModel *model = [[ZLPolicyFiveModel alloc]init];
            model.title = titleArray[i];
            model.imageName = imageArray[i];
            
            [_dataSourceArray addObject:model];
        }
        
    }
    
    return _dataSourceArray;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
