//
//  ZLOverSeeManagerVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/6.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLOverSeeManagerVC.h"
#import "ZLOverSeeVC.h"
#import "ZLAssignedVC.h"
#import "ZLMyAssignedVC.h"
#import "NinaPagerView.h"
@interface ZLOverSeeManagerVC ()

@end

@implementation ZLOverSeeManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIColor *selectColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    UIColor *unselectColor = [UIColor blackColor];
    UIColor *underlineColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    UIColor *topTabColor = [UIColor whiteColor];
    ZLAssignedVC *assignedVC = [[ZLAssignedVC alloc]init];
    ZLOverSeeVC *overSeeVC = [[ZLOverSeeVC alloc]init];
    ZLMyAssignedVC *myAssignedVC = [[ZLMyAssignedVC alloc]init];
    NinaPagerView *pageView = [[NinaPagerView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-TopBarHeight) WithTitles:@[@"交办事项",@"督办事项", @"我的交办"] WithVCs:@[assignedVC,overSeeVC, myAssignedVC]];
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
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"交办督办" attributes:dic];
    
    return title;
    
}

@end
