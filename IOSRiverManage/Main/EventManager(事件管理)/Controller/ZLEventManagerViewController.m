//
//  ZLEventManagerViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/28.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLEventManagerViewController.h"
#import "NinaPagerView.h"
#import "ZLMyWaitWorkViewController.h"
#import "ZLMyAlreadyWorkViewController.h"
#import "ZLMyLaunchWorkViewController.h"
@interface ZLEventManagerViewController ()



@end

@implementation ZLEventManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIColor *selectColor = [UIColor blueColor];
    UIColor *unselectColor = [UIColor blackColor];
    UIColor *underlineColor = [UIColor blueColor];
    UIColor *topTabColor = [UIColor whiteColor];
    ZLMyWaitWorkViewController *waitVC = [[ZLMyWaitWorkViewController alloc]init];
    ZLMyAlreadyWorkViewController *alreadyVC = [[ZLMyAlreadyWorkViewController alloc]init];
    ZLMyLaunchWorkViewController *launchVC = [[ZLMyLaunchWorkViewController alloc]init];
    NinaPagerView *pageView = [[NinaPagerView alloc]initWithFrame:CGRectMake(0, TopBarHeight, Main_Screen_Width, Main_Screen_Height-TopBarHeight) WithTitles:@[@"我的代办",@"我的已办",@"我的发起"] WithVCs:@[waitVC,alreadyVC,launchVC]];
    pageView.ninaPagerStyles = NinaPagerStyleBottomLine;
    pageView.nina_navigationBarHidden = NO;
    pageView.selectTitleColor = selectColor;
    pageView.unSelectTitleColor = unselectColor;
    pageView.underlineColor = underlineColor;
    pageView.topTabBackGroundColor = topTabColor;
    
    [self.view addSubview:pageView];
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"事件管理" attributes:dic];
    
    return title;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
