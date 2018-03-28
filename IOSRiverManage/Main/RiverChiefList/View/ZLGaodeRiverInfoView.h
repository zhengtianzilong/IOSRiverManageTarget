//
//  ZLGaodeRiverInfoView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/5.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ZLRiverDemandModel.h"

#import "ZLNewUserRiversDataModel.h"

@interface ZLGaodeRiverInfoView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) UILabel *startLabel;

@property (nonatomic, strong) UILabel *startAddressLabel;

@property (nonatomic, strong) UILabel *endLabel;
@property (nonatomic, strong) UILabel *endAddressLabel;

//@property (nonatomic, strong) ZLRiverDemandModel *demandModel;
@property (nonatomic, strong) ZLNewUserRiversDataModel *demandModel;
@end
