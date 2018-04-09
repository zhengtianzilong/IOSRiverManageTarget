//
//  ZLRiverInfoMapVC.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/9.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseCustomNavViewController.h"
#import "ZLPublicityBrandModel.h"
#import "ZLPumpingPortModel.h"
#import "ZLSewageOutletModel.h"
#import "ZLRiverInfoBaseModel.h"
@interface ZLRiverInfoMapVC : ZLBaseCustomNavViewController

@property (nonatomic, strong) ZLPublicityBrandModel *publicityBrandModel;

@property (nonatomic, strong) ZLPumpingPortModel *pumpingPortModel;

@property (nonatomic, strong) ZLSewageOutletModel *sewageOutletModel;

@property (nonatomic, strong) ZLRiverInfoBaseModel *riverInfoBaseModel;

@end
