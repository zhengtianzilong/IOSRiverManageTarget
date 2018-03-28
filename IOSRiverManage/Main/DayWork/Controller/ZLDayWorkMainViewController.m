//
//  ZLDayWorkMainViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/14.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLDayWorkMainViewController.h"
#import "ZLPagerView.h"
@interface ZLDayWorkMainViewController ()

@end

@implementation ZLDayWorkMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // @property (strong, nonatomic) UIColor *selectColor; /**<  选中时的颜色   **/
//    @property (strong, nonatomic) UIColor *unselectColor; /**<  未选中时的颜色   **/
//    @property (strong, nonatomic) UIColor *underlineColor; /**<  下划线的颜色   **/
//    @property (strong, nonatomic) UIColor *topTabColor; /**<  顶部菜单栏的背景颜色   **/

    self.automaticallyAdjustsScrollViewInsets = NO;
    UIColor *selectColor = HEXCOLOR(0x11a9e2);
    UIColor *unselectColor = HEXCOLOR(0x616161);
    UIColor *underlineColor = HEXCOLOR(0x11a9e2);
    UIColor *topTabColor = [UIColor whiteColor];
    
    NSArray *colors = @[selectColor,unselectColor,underlineColor,topTabColor];

//    ZLDayAddressBookViewController *addressBookVC = [[ZLDayAddressBookViewController alloc]init];
//    ZLDayAnalyzeViewController *analyzeVC = [[ZLDayAnalyzeViewController alloc]init];
//    ZLDayNesViewController *newsVC = [[ZLDayNesViewController alloc]init];
//    
//    
//    ZLPagerView *pageView = [[ZLPagerView alloc]initWithPagerStyle:(ZLPagerStyleBottomLine) WithTitles:@[@"通讯录",@"统计分析",@"新闻公告"] WithVCs:@[addressBookVC,analyzeVC,newsVC] WithColorArrays:colors];
//    
//    [self.view addSubview:pageView];

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
