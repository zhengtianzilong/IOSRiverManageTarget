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
#import "NinaPagerView.h"
#import "ZLNewLoginModel.h"
@interface ZLRiverInfoManagerVC ()
@property (nonatomic, strong) YTKKeyValueStore *store;
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
    twoTableVC.riverCode = self.riverCodeString;
    ZLRiverInfoTwoPictureVC *twoPictureVC = [[ZLRiverInfoTwoPictureVC alloc]init];
    twoPictureVC.riverCode = self.riverCodeString;

    //    ZLRiverInfoQualityVC *qualityVC = [[ZLRiverInfoQualityVC alloc]init];
    
    
    NSMutableArray *nameArray = [NSMutableArray arrayWithArray:@[@"基本信息",@"河长信息"]];
    
    NSMutableArray *vcArray = [NSMutableArray arrayWithArray:@[baseVC,peopleVC]];
    
    self.store = [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
    
    NSString *tableName = DBUserTable;
    
    [self.store createTableWithName:tableName];
    NSString *userModel = [self.store getStringById:DBLoginModel fromTable:DBUserTable];
    
    ZLNewLoginModel *newLoginModel = [[ZLNewLoginModel alloc]initWithString:userModel error:nil];
    
    for (ZLFunctionListModel *funcModel in newLoginModel.data.functionList) {
        

        if ([funcModel.functionName isEqualToString:@"五个清单"] && [funcModel.functionCode isEqualToString:@"100207"]) {
            
            [nameArray addObject:funcModel.functionName];
            [vcArray addObject:fiveVC];
            
        }
        
        if ([funcModel.functionName isEqualToString:@"两张表"] && [funcModel.functionCode isEqualToString:@"100208"]) {
            
            [nameArray addObject:funcModel.functionName];
            [vcArray addObject:twoTableVC];
            
        }
        
        if ([funcModel.functionName isEqualToString:@"两张图"]) {
            
            [nameArray addObject:funcModel.functionName];
            [vcArray addObject:twoPictureVC];
            
        }
        
    }
    
//    NinaPagerView *pageView = [[NinaPagerView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-TopBarHeight) WithTitles:@[@"基本信息",@"河长信息",@"五个清单",@"两张表",@"两张图"] WithVCs:@[baseVC,peopleVC,fiveVC,twoTableVC,twoPictureVC]];
    
    NinaPagerView *pageView = [[NinaPagerView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-TopBarHeight) WithTitles:nameArray WithVCs:vcArray];
    
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
