//
//  ZLRiverInfoBaseChangeVC.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/8.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseCustomNavViewController.h"
#import "ZLMapLocationModel.h"
#import "ZLNewUserRiversDataModel.h"
@interface ZLRiverAddIntakeVC : ZLBaseCustomNavViewController
@property (nonatomic, strong) ZLMapLocationModel *locationModel;

@property (nonatomic, strong) ZLNewUserRiversDataModel *riverDataModel;

@end
