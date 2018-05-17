//
//  ZLMyExamineManagerVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/15.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyExamineManagerVC.h"
#import "NinaPagerView.h"
#import "ZLHaveNoExamineVC.h"
#import "ZLHaveExamineVC.h"
@interface ZLMyExamineManagerVC ()

@end

@implementation ZLMyExamineManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIColor *selectColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    UIColor *unselectColor = [UIColor blackColor];
    UIColor *underlineColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    UIColor *topTabColor = [UIColor whiteColor];
    ZLHaveNoExamineVC *haveNoExamineVC = [[ZLHaveNoExamineVC alloc]init];
    ZLHaveExamineVC *haveExamineVC = [[ZLHaveExamineVC alloc]init];
   
    NinaPagerView *pageView = [[NinaPagerView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-TopBarHeight) WithTitles:@[@"未评考核",@"已评考核"] WithVCs:@[haveNoExamineVC,haveExamineVC]];
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
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"我的考核" attributes:dic];
    
    return title;
    
}
@end
