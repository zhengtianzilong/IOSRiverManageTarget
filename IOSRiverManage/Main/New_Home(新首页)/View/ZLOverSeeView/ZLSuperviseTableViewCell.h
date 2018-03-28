//
//  ZLSuperviseTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSuperviseRowDetailModel.h"
@interface ZLSuperviseTableViewCell : UITableViewCell
/**
 颜色指示器
 */
@property(nonatomic, strong) UIImageView *colorIndicator;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *state;

@property (nonatomic, strong) UILabel *initiatorLabel;
// 事项名称
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *name;

// 督办单位
@property (nonatomic, strong) UILabel *supDepartmentLabel;
@property (nonatomic, strong) UILabel *supDepartment;

// 交办单编号
@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UILabel *code;

// 责任单位
@property (nonatomic, strong) UILabel *departmentLabel;
@property (nonatomic, strong) UILabel *department;

// 责任人
@property (nonatomic, strong) UILabel *peopleLabel;
@property (nonatomic, strong) UILabel *people;

// 督办时间
@property (nonatomic, strong) UILabel *superviseTimeLabel;
@property (nonatomic, strong) UILabel *superviseTime;

//// 完成时间
//@property (nonatomic, strong) UILabel *completeTimeLabel;
//@property (nonatomic, strong) UILabel *completeTime;
@property (nonatomic, strong) UIView *lineViewTop;

@property (nonatomic, strong) ZLSuperviseRowDetailModel *detailModel;
@end
