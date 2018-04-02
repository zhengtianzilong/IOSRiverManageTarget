//
//  ZLGaodeDownTaskVC.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "MYPresentedController.h"
#import "ZLNewUserRiversDataModel.h"
#import "ZLMapLocationModel.h"
@interface ZLGaodeDownTaskVC : MYPresentedController

@property (nonatomic, strong) ZLNewUserRiversDataModel *userRiverModel;

@property (nonatomic, strong) ZLMapLocationModel *locationModel;

@end
