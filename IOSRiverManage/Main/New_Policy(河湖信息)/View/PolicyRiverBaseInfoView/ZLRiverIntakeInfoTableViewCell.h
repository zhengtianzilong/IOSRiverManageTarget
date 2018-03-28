//
//  ZLRiverIntakeInfoTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPumpingPortModel.h"

typedef void(^deletePumpClick)(ZLPumpingPortModel *pumpModel);

@interface ZLRiverIntakeInfoTableViewCell : UITableViewCell
// 取水口信息
@property (nonatomic, strong) UILabel *title;

// 取水口编码
@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UILabel *code;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *name;
// 所属区县
@property (nonatomic, strong) UILabel *countyLabel;
@property (nonatomic, strong) UILabel *county;

// 位置
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *address;

// 联系人
@property (nonatomic, strong) UILabel *peopleLabel;
@property (nonatomic, strong) UILabel *people;

// 联系人电话
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *phone;

// 取水口用途
@property (nonatomic, strong) UILabel *useLabel;
@property (nonatomic, strong) UILabel *use;

// 删除按钮
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *checkAddressBtn;

@property (nonatomic, strong) ZLPumpingPortModel *pumpingPortModel;

@property (nonatomic, strong) deletePumpClick deletepump;

@end
