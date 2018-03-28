//
//  ZLGaodeViewController.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/4.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLBaseCustomNavViewController.h"
#import "ZLRiverDemandModel.h"

#import "ZLNewUserRiversDataModel.h"

@interface ZLGaodeViewController : ZLBaseCustomNavViewController



@property (nonatomic, strong) NSString *uid;
/**
 巡河任务ID
 */
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *type;


/**
 河道信息model
 */
//@property (nonatomic, strong) ZLRiverDemandModel *demandModel;


/**
 河道信息model
 */
@property (nonatomic, strong) ZLNewUserRiversDataModel *riverDataModel;

@end
