//
//  ZLQueryMyAssignedView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/8.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+RoundedCorner.h"
#import "ZLMyAssignedSelectInfoView.h"
@interface ZLQueryMyAssignedView : UIView
@property (nonatomic, strong) UIButton *queryButton;

@property (nonatomic, strong) ZLMyAssignedSelectInfoView *selectInfoView;
@end
