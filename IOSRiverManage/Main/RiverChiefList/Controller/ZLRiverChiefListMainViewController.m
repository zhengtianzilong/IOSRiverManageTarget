//
//  ZLRiverChiefListMainViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/14.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLRiverChiefListMainViewController.h"
#import "ZLBaiduTrackViewController.h"
#import "ZLBaiduiImportanceViewController.h"
@interface ZLRiverChiefListMainViewController ()


@end

@implementation ZLRiverChiefListMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIButton *startButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 100, 100)];
    startButton.backgroundColor = [UIColor redColor];
    
    [startButton addTarget:self action:@selector(startClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:startButton];
    
    UIButton *endButton = [[UIButton alloc]initWithFrame:CGRectMake(200, 100, 100, 100)];
    endButton.backgroundColor = [UIColor redColor];
    
    [endButton addTarget:self action:@selector(endClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:endButton];
}

- (void)startClick{
    
    ZLBaiduTrackViewController *baiduVC = [[ZLBaiduTrackViewController alloc]init];
    
    [self.navigationController pushViewController:baiduVC animated:YES];
    
    
}

- (void)endClick{
    
    ZLBaiduiImportanceViewController *baiduVC = [[ZLBaiduiImportanceViewController alloc]init];
    
    [self.navigationController pushViewController:baiduVC animated:YES];
    
    
}

@end
