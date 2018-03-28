//
//  ZLOverSeeTimeView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/6.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLOverSeeTimeSelectView.h"
@interface ZLOverSeeTimeView : UIView
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) ZLOverSeeTimeSelectView *startTimeView;

@property (nonatomic, strong) ZLOverSeeTimeSelectView *endTimeView;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSString *title;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

@end
