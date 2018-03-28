//
//  ZLRiverInfoQuestionVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/6.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverInfoQuestionVC.h"

@interface ZLRiverInfoQuestionVC ()

@end

@implementation ZLRiverInfoQuestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(clickBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        
    }];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)clickBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (BOOL)shouldAutorotate

{
    
    return NO;
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations

{
    
    return UIInterfaceOrientationMaskLandscape;
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation

{
    
    return UIInterfaceOrientationLandscapeRight;
    
}
@end
