//
//  ZLLeftViewController.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/19.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLLoginModel.h"
@interface ZLLeftViewController : UIViewController

@property (nonatomic, strong) ZLLoginModel *loginModel;
- (void)showFromLeft;
@end
