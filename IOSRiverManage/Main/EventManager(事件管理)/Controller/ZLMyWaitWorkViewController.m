//
//  ZLMyWaitWorkViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/28.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLMyWaitWorkViewController.h"
#import "ZLEventManagerTopView.h"
#import "ZLMyEventCell.h"
@interface ZLMyWaitWorkViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) ZLEventManagerTopView *topView;
@property (nonatomic, strong) UITableView *mainTableView;
@end

@implementation ZLMyWaitWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.topView];
     [self.view addSubview:self.mainTableView];
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(10);
        make.height.mas_equalTo(Main_Screen_Height / 3);
    }];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right).offset(-10);
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(313);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLMyEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyEventCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _mainTableView.backgroundColor = [UIColor lightGrayColor];
        [_mainTableView registerClass:[ZLMyEventCell class] forCellReuseIdentifier:@"ZLMyEventCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.sectionFooterHeight = 10;
        _mainTableView.sectionHeaderHeight = 0;
        _mainTableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
//        _mainTableView.scrollEnabled = NO;
        
    }
    return _mainTableView;
}


- (ZLEventManagerTopView *)topView{
    if (!_topView) {
        _topView = [[ZLEventManagerTopView alloc]init];
    }
    return _topView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
