//
//  ZLHomeWebViewViewController.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/18.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLBaseCustomNavViewController.h"
#import "ZLLoginModel.h"
@interface ZLHomeWebViewViewController : ZLBaseCustomNavViewController

@property (nonatomic, strong) ZLLoginModel *loginModel;

@property (nonatomic, strong) NSDictionary *userInfo;

@property (nonatomic, strong) NSMutableArray *riverSourceArray;


@end
