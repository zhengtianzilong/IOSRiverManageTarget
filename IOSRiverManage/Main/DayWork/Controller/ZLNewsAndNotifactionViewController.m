//
//  ZLNewsAndNotifactionViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewsAndNotifactionViewController.h"
#import "ZLPagerView.h"
#import "ZLDayNotifactionViewController.h"
#import "ZLDayNesViewController.h"
@interface ZLNewsAndNotifactionViewController ()

@end

@implementation ZLNewsAndNotifactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIColor *selectColor = HEXCOLOR(0x11a9e2);
    UIColor *unselectColor = HEXCOLOR(0x616161);
    UIColor *underlineColor = HEXCOLOR(0x11a9e2);
    UIColor *topTabColor = [UIColor whiteColor];
    
    NSArray *colors = @[selectColor,unselectColor,underlineColor,topTabColor];
    ZLDayNotifactionViewController *noticVC = [[ZLDayNotifactionViewController alloc]init];
    ZLDayNesViewController *newsVC = [[ZLDayNesViewController alloc]init];
    ZLPagerView *pageView = [[ZLPagerView alloc]initWithPagerStyle:(ZLPagerStyleBottomLine) WithTitles:@[@"通知公告",@"新闻动态"] WithVCs:@[noticVC,newsVC] WithColorArrays:colors];
    
    [self.view addSubview:pageView];
    
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"日常办公" attributes:dic];
    
    return title;
    
}

- (UIButton *)set_leftButton{
    return  nil;
}

@end
