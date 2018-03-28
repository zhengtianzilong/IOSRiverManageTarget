//
//  ZLQueryOverSeeView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/6.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ZLTimeSelectView.h"
//#import "ZLThreeButtonView.h"
#import "UIView+RoundedCorner.h"
#import "ZLAssignedSelectInfoView.h"
@interface ZLQueryAssignedView : UIView
@property (nonatomic, strong) UIButton *queryButton;

@property (nonatomic, strong) ZLAssignedSelectInfoView *selectInfoView;

//@property (nonatomic, strong) ZLThreeButtonView *threeButton;
@end
