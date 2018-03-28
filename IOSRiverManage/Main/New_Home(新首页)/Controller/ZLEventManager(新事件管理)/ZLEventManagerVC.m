//
//  ZLEventManagerVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManagerVC.h"
#import "ZLEventManagerReportVC.h"
#import "ZLEventManagerAlreadyVC.h"
#import "ZLEventManagerWaitVC.h"
#import "ZLEventManagerCheckVC.h"
#import "NinaPagerView.h"
@interface ZLEventManagerVC ()

@end

@implementation ZLEventManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIColor *selectColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    UIColor *unselectColor = [UIColor blackColor];
    UIColor *underlineColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    UIColor *topTabColor = [UIColor whiteColor];
    ZLEventManagerReportVC *reportVC = [[ZLEventManagerReportVC alloc]init];
    ZLEventManagerAlreadyVC *alreadyVC = [[ZLEventManagerAlreadyVC alloc]init];
    ZLEventManagerWaitVC *waitVC = [[ZLEventManagerWaitVC alloc]init];
    ZLEventManagerCheckVC *checkVC = [[ZLEventManagerCheckVC alloc]init];
    
    NinaPagerView *pageView = [[NinaPagerView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-TopBarHeight) WithTitles:@[@"事件上报",@"待办事件",@"已办事件",@"事件查询"] WithVCs:@[reportVC,waitVC,alreadyVC,checkVC]];
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
@end
