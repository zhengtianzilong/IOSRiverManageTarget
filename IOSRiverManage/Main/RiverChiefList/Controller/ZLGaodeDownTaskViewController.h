//
//  ZLGaodeDownTaskViewController.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/6.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "MYPresentedController.h"
//#import "ZLRiverDemandModel.h"
#import "ZLNewUserRiversDataModel.h"
#import <CoreLocation/CoreLocation.h>
@interface ZLGaodeDownTaskViewController : MYPresentedController
//@property (nonatomic, strong) ZLRiverDemandModel *demandModel;

@property (nonatomic, strong) ZLNewUserRiversDataModel *demandModel;

@property (nonatomic, strong) NSString *uid;
/**
 巡河任务ID
 */
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, strong) NSString *address;
@end
