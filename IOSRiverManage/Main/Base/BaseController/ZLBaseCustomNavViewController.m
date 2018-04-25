//
//  ZLBaseCustomNavViewController.m
//  AIProduct
//
//  Created by mac on 2017/8/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ZLBaseCustomNavViewController.h"

@interface ZLBaseCustomNavViewController ()

@end

@implementation ZLBaseCustomNavViewController
-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //监听网络变化
    Reachability *reach = [Reachability reachabilityWithHostName:kURL_Reachability__Address];
    
    self.hostReach = reach;
    [[NSNotificationCenter defaultCenter]addObserver:self  selector:@selector(netStatusChange:) name:kReachabilityChangedNotification object:nil];
    //实现监听
    [reach startNotifier];
}




//通知监听回调 网络状态发送改变 系统会发出一个kReachabilityChangedNotification通知，然后会触发此回调方法
- (void)netStatusChange:(NSNotification *)noti{
    ZLLog(@"-----%@",noti.userInfo);
    //判断网络状态
    switch (self.hostReach.currentReachabilityStatus) {
        case NotReachable:
            [MBProgressHUD showInfo:@"当前网络连接失败，请查看设置" ToView:self.view];
            break;
        case ReachableViaWiFi:
            ZLLog(@"wifi上网2");
            break;
        case ReachableViaWWAN:
            ZLLog(@"手机上网2");
            break;
        default:
            break;
    }
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
