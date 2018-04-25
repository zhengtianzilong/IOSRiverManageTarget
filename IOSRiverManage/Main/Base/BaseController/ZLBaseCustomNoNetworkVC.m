//
//  ZLBaseCustomNoNetworkVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/24.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseCustomNoNetworkVC.h"

@interface ZLBaseCustomNoNetworkVC ()

@end

@implementation ZLBaseCustomNoNetworkVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIColor *)set_colorBackground{
    return HEXCOLOR(CNAVGATIONBAR_COLOR);
}

- (UIButton *)set_leftButton{
    
    UIImage* backItemImage = [UIImage imageNamed:@"nav_left"];
    //    UIImage* backItemHlImage = [[UIImage imageNamed:@"login_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backButton setImage:backItemImage forState:UIControlStateNormal];
    
    //    [backButton setBackgroundImage:backItemImage forState:(UIControlStateNormal)];
    
    
    
    //    [backButton setImage:backItemHlImage forState:UIControlStateHighlighted];
    //    [backButton sizeToFit];
    return backButton;
}

- (void)left_button_event:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
