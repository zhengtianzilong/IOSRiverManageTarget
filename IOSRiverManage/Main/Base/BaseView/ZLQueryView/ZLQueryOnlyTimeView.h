//
//  ZLQueryOnlyTimeView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLTimeSelectView.h"
#import "ZLThreeButtonView.h"
#import "UIView+RoundedCorner.h"
#import "ZLSelectOnlyTimeView.h"
@interface ZLQueryOnlyTimeView : UIView
@property (nonatomic, strong) UIButton *queryButton;
@property (nonatomic, strong) ZLSelectOnlyTimeView *selectInfoView;

@property (nonatomic, strong) ZLThreeButtonView *threeButton;
@end
