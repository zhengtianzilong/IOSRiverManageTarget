//
//  ZLMyEventLaunchTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLMyEventLaunchTableViewCell : UITableViewCell

// 标题
@property (nonatomic, strong) UILabel *titleLabel;
// 状态:
@property (nonatomic, strong) UILabel *stateLable;
@property (nonatomic, strong) UILabel *state;
// 发起人
@property (nonatomic, strong) UILabel *originatorLabel;
@property (nonatomic, strong) UILabel *originator;
// 接收人
@property (nonatomic, strong) UILabel *receiveLabel;
@property (nonatomic, strong) UILabel *receive;
// 时间
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *time;

// 描述
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UILabel *describe;

@property (nonatomic, strong) UICollectionView *mianCollectionView;
@property (nonatomic, strong) UIView *containerView;

@end
