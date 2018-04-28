//
//  ZLRiverOutletInfoTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSewageOutletModel.h"

typedef void(^selectOutletDelete)(ZLSewageOutletModel *model);

typedef void(^sewageOutletAddressBlock)(ZLSewageOutletModel *outletModel);

@interface ZLRiverOutletInfoTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *title;

// 编码
@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UILabel *code;

// 排污口信息
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

// 主要污染而不
@property (nonatomic, strong) UILabel *pollutantsLabel;
@property (nonatomic, strong) UILabel *pollutants;

// 删除按钮
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *checkAddressBtn;

@property (nonatomic, strong) ZLSewageOutletModel *outletModel;

@property (nonatomic, strong) selectOutletDelete outletDelete;
@property (nonatomic, strong) sewageOutletAddressBlock sewageOutletAddress;

@property (nonatomic, weak) UIView *containerView;

// 照片
@property (nonatomic, strong) UILabel *pictureLabel;


@end
