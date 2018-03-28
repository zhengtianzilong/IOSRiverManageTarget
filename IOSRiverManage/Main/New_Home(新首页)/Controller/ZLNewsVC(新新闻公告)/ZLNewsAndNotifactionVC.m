//
//  ZLNewsAndNotifactionVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewsAndNotifactionVC.h"
#import "ZLDayNotifactionVC.h"
#import "ZLDayNesVC.h"
#import "NinaPagerView.h"
@interface ZLNewsAndNotifactionVC ()

@end

@implementation ZLNewsAndNotifactionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIColor *selectColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    UIColor *unselectColor = [UIColor blackColor];
    UIColor *underlineColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    UIColor *topTabColor = [UIColor whiteColor];
    ZLDayNotifactionVC *dayNotifactionVC = [[ZLDayNotifactionVC alloc]init];
    ZLDayNesVC *dayNesVC = [[ZLDayNesVC alloc]init];
    NinaPagerView *pageView = [[NinaPagerView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-TopBarHeight) WithTitles:@[@"通知公告",@"新闻动态"] WithVCs:@[dayNotifactionVC,dayNesVC]];
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
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"新闻公告" attributes:dic];
    
    return title;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
