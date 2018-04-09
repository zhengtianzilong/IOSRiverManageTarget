//
//  ZLRiverInfoBaseView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/1/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLRiverInfoBaseModel.h"

typedef void(^riverInfoBaseViewBlock)(ZLRiverInfoBaseModel *infoBaseModel);

@interface ZLRiverInfoBaseView : UITableViewCell
// 河道编号
@property (nonatomic, strong) UILabel *riverCountLabel;
@property (nonatomic, strong) UILabel *riverCount;

// 河道起点
@property (nonatomic, strong) UILabel *riverStartLabel;
@property (nonatomic, strong) UILabel *riverStart;

// 河道终点
@property (nonatomic, strong) UILabel *riverEndLabel;
@property (nonatomic, strong) UILabel *riverEnd;

// 河道职责
@property (nonatomic, strong) UILabel *riverDutyLabel;
@property (nonatomic, strong) UILabel *riverDuty;

// 治理目标
@property (nonatomic, strong) UILabel *riverTargetLabel;
@property (nonatomic, strong) UILabel *riverTarget;

// 所属区县
@property (nonatomic, strong) UILabel *riverCountyLabel;
@property (nonatomic, strong) UILabel *riverCounty;

// 编辑按钮
@property (nonatomic, strong) UIButton *editBtn;


// 所属级别
@property (nonatomic, strong) UILabel *riverLevelLabel;
@property (nonatomic, strong) UILabel *riverLevel;

// 河道长度
@property (nonatomic, strong) UILabel *riverLengthLabel;
@property (nonatomic, strong) UILabel *riverLength;

@property (nonatomic, strong) UIButton *checkAddressBtn;

@property (nonatomic, strong) ZLRiverInfoBaseModel *infoBaseModel;

@property (nonatomic, strong) riverInfoBaseViewBlock infoBaseView;

@end
