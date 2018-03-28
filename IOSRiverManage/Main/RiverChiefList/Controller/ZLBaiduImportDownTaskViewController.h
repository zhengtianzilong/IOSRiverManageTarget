//
//  ZLBaiduImportDownTaskViewController.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/26.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "MYPresentedController.h"
#import "ZLRiverDemandModel.h"
#import <CoreLocation/CoreLocation.h>
@interface ZLBaiduImportDownTaskViewController : MYPresentedController
@property (nonatomic, assign)BOOL isHaveInfoView;
@property (nonatomic, strong) ZLRiverDemandModel *demandModel;

@property (nonatomic, strong) NSString *uid;
/**
 巡河任务ID
 */
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, strong) NSString *address;
@end
