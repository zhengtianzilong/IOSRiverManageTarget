//
//  ZLRiverInfoManagerVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverInfoManagerVC.h"
#import "ZLRiverInfoBaseVC.h"
#import "ZLRiverInfoPeopleVC.h"
#import "ZLRiverInfoFiveTableVC.h"
#import "ZLRiverInfoTwoTableVC.h"
#import "ZLRiverInfoTwoPictureVC.h"
#import "ZLRiverInfoQualityVC.h"
#import "NinaPagerView.h"
@interface ZLRiverInfoManagerVC ()

@end

@implementation ZLRiverInfoManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIColor *selectColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    UIColor *unselectColor = [UIColor blackColor];
    UIColor *underlineColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    UIColor *topTabColor = [UIColor whiteColor];
    ZLRiverInfoBaseVC *baseVC = [[ZLRiverInfoBaseVC alloc]init];
    baseVC.riverCode = self.riverCodeString;
    
    ZLRiverInfoPeopleVC *peopleVC = [[ZLRiverInfoPeopleVC alloc]init];
    peopleVC.riverCode = self.riverCodeString;
    
    ZLRiverInfoFiveTableVC *fiveVC = [[ZLRiverInfoFiveTableVC alloc]init];
    fiveVC.riverCode = self.riverCodeString;
    ZLRiverInfoTwoTableVC *twoTableVC = [[ZLRiverInfoTwoTableVC alloc]init];
    ZLRiverInfoTwoPictureVC *twoPictureVC = [[ZLRiverInfoTwoPictureVC alloc]init];
//    ZLRiverInfoQualityVC *qualityVC = [[ZLRiverInfoQualityVC alloc]init];
    NinaPagerView *pageView = [[NinaPagerView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-TopBarHeight) WithTitles:@[@"基本信息",@"河长信息",@"五个清单",@"两张表",@"两张图"] WithVCs:@[baseVC,peopleVC,fiveVC,twoTableVC,twoPictureVC]];
    pageView.ninaPagerStyles = NinaPagerStyleBottomLine;
    pageView.nina_navigationBarHidden = NO;
    pageView.selectTitleColor = selectColor;
    pageView.unSelectTitleColor = unselectColor;
    pageView.underlineColor = underlineColor;
    pageView.topTabBackGroundColor = topTabColor;
    
    [self.view addSubview:pageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:self.titleString attributes:dic];
    
    return title;
    
}
@end
