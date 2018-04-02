//
//  ZLFeedBackCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLTaskFeedBackDataModel.h"
@interface ZLFeedBackCell : UITableViewCell
@property (nonatomic, strong) UIView *lineView;

// 执行人
@property (nonatomic, strong) UILabel *originatorLabel;
@property (nonatomic, strong) UILabel *originator;
// 反馈时间
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *time;

// 反馈描述
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UILabel *describe;

@property (nonatomic, strong) UIView *containerView;


@property (nonatomic, strong) ZLTaskFeedBackDataModel *dataModel;
@end
