//
//  ZLMySetupVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMySetupVC.h"

@interface ZLMySetupVC ()

@end

@implementation ZLMySetupVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"系统设置" attributes:dic];
    
    return title;
    
}



@end
