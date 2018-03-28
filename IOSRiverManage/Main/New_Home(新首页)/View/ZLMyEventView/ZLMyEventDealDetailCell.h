//
//  ZLMyEventDealDetailCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLMyEventDealDetailCell : UITableViewCell
// 标题
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *lineView;

// 事件名称
@property (nonatomic, strong) UILabel *eventLabel;
@property (nonatomic, strong) UILabel *event;
// 状态:
@property (nonatomic, strong) UILabel *stateLable;
@property (nonatomic, strong) UILabel *state;
// 发起人
@property (nonatomic, strong) UILabel *originatorLabel;
@property (nonatomic, strong) UILabel *originator;
// 接收人
@property (nonatomic, strong) UILabel *receiveLabel;
@property (nonatomic, strong) UILabel *receive;

// 接收部门
@property (nonatomic, strong) UILabel *departLabel;
@property (nonatomic, strong) UILabel *depart;

// 时间
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *time;

// 描述
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UILabel *describe;

@property (nonatomic, strong) UIView *containerView;


// 附件
@property (nonatomic, strong) UILabel *attachmentLabel;
@property (nonatomic, strong) UILabel *attachment;

@end
