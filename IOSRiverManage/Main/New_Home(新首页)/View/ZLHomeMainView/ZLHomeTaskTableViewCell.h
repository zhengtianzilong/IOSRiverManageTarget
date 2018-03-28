//
//  ZLHomeTaskTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/10/24.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLHomeTaskTableViewCell : UITableViewCell


/**
 颜色指示器
 */
@property(nonatomic, strong) UIImageView *colorIndicator;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *state;

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *initiatorLabel;
/**
 发起人
 */
@property (nonatomic, strong) UILabel *initiatorName;
@property (nonatomic, strong) UILabel *receivedLabel;
/**
 接收人
 */
@property (nonatomic, strong) UILabel *receivedName;

@property (nonatomic, strong) UILabel *contentLabel;
/**
 内容
 */
@property (nonatomic, strong) UILabel *content;

/**
 时间
 */
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *lineViewTop;

@property (nonatomic, strong) UIView *lineViewBottom;

@end
