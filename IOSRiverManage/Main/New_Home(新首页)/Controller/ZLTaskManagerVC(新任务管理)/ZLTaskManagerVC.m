//
//  ZLTaskManagerVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLTaskManagerVC.h"
#import "ZLTaskWaitVC.h"
#import "ZLTaskMyDownVC.h"
#import "ZLTaskMyAlreadyWorkVC.h"
#import "NinaPagerView.h"
#import "ZLTaskMyCheckVC.h"
@interface ZLTaskManagerVC ()

@end

@implementation ZLTaskManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIColor *selectColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    UIColor *unselectColor = [UIColor blackColor];
    UIColor *underlineColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    UIColor *topTabColor = [UIColor whiteColor];
    ZLTaskMyCheckVC *checkVC = [[ZLTaskMyCheckVC alloc]init];
    ZLTaskWaitVC *waitVC = [[ZLTaskWaitVC alloc]init];
    ZLTaskMyAlreadyWorkVC *alreadyVC = [[ZLTaskMyAlreadyWorkVC alloc]init];
    ZLTaskMyDownVC *downVC = [[ZLTaskMyDownVC alloc]init];
    NinaPagerView *pageView = [[NinaPagerView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-TopBarHeight) WithTitles:@[@"下发任务",@"待办任务",@"已办任务",@"任务查询"] WithVCs:@[downVC,waitVC,alreadyVC,checkVC]];
    pageView.ninaPagerStyles = NinaPagerStyleBottomLine;
    pageView.nina_navigationBarHidden = NO;
    pageView.selectTitleColor = selectColor;
    pageView.unSelectTitleColor = unselectColor;
    pageView.underlineColor = underlineColor;
    pageView.topTabBackGroundColor = topTabColor;
    
    
//    [self.hostReach stopNotifier];
    
    [self.view addSubview:pageView];
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"任务管理" attributes:dic];
    
    return title;
    
}
@end
