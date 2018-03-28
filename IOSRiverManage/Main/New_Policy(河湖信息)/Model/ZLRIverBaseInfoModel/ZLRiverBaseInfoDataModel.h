//
//  ZLRiverBaseInfoDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ZLRiverInfoBaseModel.h"
#import "ZLPublicityBrandModel.h"
#import "ZLSewageOutletModel.h"
#import "ZLPumpingPortModel.h"
@interface ZLRiverBaseInfoDataModel : JSONModel

@property (nonatomic, strong) NSArray<ZLRiverInfoBaseModel, Optional> *riverInfo;

@property (nonatomic, strong) NSArray<ZLPublicityBrandModel, Optional> *PublicityBrand;
@property (nonatomic, strong) NSArray<ZLSewageOutletModel, Optional> *SewageOutlet;
@property (nonatomic, strong) NSArray<ZLPumpingPortModel, Optional> *PumpingPort;
@end
