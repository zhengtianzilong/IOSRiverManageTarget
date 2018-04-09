//
//  ZLRiverInfoManagerViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/1/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverInfoManagerViewController.h"
#import "ZLRiverInfoBaseVC.h"
#import "ZLRiverInfoPeopleVC.h"
#import "ZLRiverInfoFiveTableVC.h"
#import "ZLRiverInfoTwoTableVC.h"
#import "ZLRiverInfoTwoPictureVC.h"
#import "NinaPagerView.h"
@interface ZLRiverInfoManagerViewController ()

@end

@implementation ZLRiverInfoManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIColor *selectColor = [UIColor blueColor];
    UIColor *unselectColor = [UIColor blackColor];
    UIColor *underlineColor = [UIColor blueColor];
    UIColor *topTabColor = [UIColor whiteColor];
    ZLRiverInfoBaseVC *baseVC = [[ZLRiverInfoBaseVC alloc]init];
    ZLRiverInfoPeopleVC *peopleVC = [[ZLRiverInfoPeopleVC alloc]init];
    ZLRiverInfoFiveTableVC *fiveVC = [[ZLRiverInfoFiveTableVC alloc]init];
    ZLRiverInfoTwoTableVC *twoTableVC = [[ZLRiverInfoTwoTableVC alloc]init];
    ZLRiverInfoTwoPictureVC *twoPictureVC = [[ZLRiverInfoTwoPictureVC alloc]init];
    NinaPagerView *pageView = [[NinaPagerView alloc]initWithFrame:CGRectMake(0, TopBarHeight, Main_Screen_Width, Main_Screen_Height-TopBarHeight) WithTitles:@[@"基本信息",@"河长信息",@"五个清单",@"两张表",@"两张图"] WithVCs:@[baseVC,peopleVC,fiveVC,twoTableVC,twoPictureVC]];
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
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"事件管理" attributes:dic];
    
    return title;
    
}


@end
