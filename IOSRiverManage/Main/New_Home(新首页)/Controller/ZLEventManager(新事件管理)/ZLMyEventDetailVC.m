//
//  ZLMyEventDetailVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyEventDetailVC.h"
#import "ZLMyEventLaunchTableViewCell.h"
#import "ZLMyEventContinueTableViewCell.h"
#import "ZLMyEventCompletedTableViewCell.h"
#import "ZLMyEventAdviseVC.h"
@interface ZLMyEventDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIButton *floatBtn;

@end

@implementation ZLMyEventDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    
    [self.view addSubview:self.mainTableView];
    
    [self.view addSubview:self.floatBtn];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];
    
    
    [self.floatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(-80);
        make.width.mas_equalTo(Main_Screen_Width / 3);
        make.height.mas_equalTo(50);
    }];
    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
   
    
    
}

- (void)clickAddButton{
    
    ZLMyEventAdviseVC *vc = [[ZLMyEventAdviseVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}





#pragma mark -- 列表的代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    return self.sourceData.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        
        ZLMyEventLaunchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyEventLaunchTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    

    if (indexPath.row == 1) {
        
        ZLMyEventContinueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyEventContinueTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.row == 2) {
        
        ZLMyEventCompletedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyEventCompletedTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    return nil;
    
    //    ZLFlotillaReportModel *model = self.sourceData[indexPath.section];
    //
    //    cell.flotillaModel = model;
    
    
}


- (UIButton *)floatBtn{
    if (!_floatBtn) {
        _floatBtn = [[UIButton alloc] init];
        _floatBtn.layer.cornerRadius = 21.5;
        [_floatBtn addTarget:self action:@selector(clickAddButton) forControlEvents:UIControlEventTouchUpInside];
        [_floatBtn setBackgroundImage:[UIImage imageNamed:@"my_advise"] forState:UIControlStateNormal];
    }
    return _floatBtn;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLMyEventLaunchTableViewCell class] forCellReuseIdentifier:@"ZLMyEventLaunchTableViewCell"];
        
        [_mainTableView registerClass:[ZLMyEventContinueTableViewCell class] forCellReuseIdentifier:@"ZLMyEventContinueTableViewCell"];
        
        [_mainTableView registerClass:[ZLMyEventCompletedTableViewCell class] forCellReuseIdentifier:@"ZLMyEventCompletedTableViewCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 44;
        
        
    }
    return _mainTableView;
}
@end
