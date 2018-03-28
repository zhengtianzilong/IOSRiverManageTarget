//
//  ZLMyEventCompletedTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLMyEventCompletedTableViewCell : UITableViewCell
// 状态:
@property (nonatomic, strong) UILabel *stateLable;
@property (nonatomic, strong) UILabel *state;
// 处理人
@property (nonatomic, strong) UILabel *completeLabel;
@property (nonatomic, strong) UILabel *completeor;

// 时间
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *time;

// 描述
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UILabel *describe;

@property (nonatomic, strong) UIView *containerView;
@end
