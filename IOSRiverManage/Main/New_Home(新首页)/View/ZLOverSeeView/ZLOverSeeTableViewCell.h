//
//  ZLOverSeeTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/6.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLAssignTaskRowDetailModel.h"
@interface ZLOverSeeTableViewCell : UITableViewCell


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

// 责任单位
@property (nonatomic, strong) UILabel *departmentLabel;
@property (nonatomic, strong) UILabel *department;

// 责任人
@property (nonatomic, strong) UILabel *peopleLabel;
@property (nonatomic, strong) UILabel *people;

// 交办时间
@property (nonatomic, strong) UILabel *assignedTimeLabel;
@property (nonatomic, strong) UILabel *assignedTime;

// 完成时间
@property (nonatomic, strong) UILabel *completeTimeLabel;
@property (nonatomic, strong) UILabel *completeTime;
@property (nonatomic, strong) UIView *lineViewTop;

@property (nonatomic, strong) ZLAssignTaskRowDetailModel *assignModel;

// 交办的类型
@property (nonatomic, strong) NSString *assignType;


@end
