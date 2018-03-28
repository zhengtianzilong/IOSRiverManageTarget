//
//  ZLQueryOverSeeView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+RoundedCorner.h"
#import "ZLOverSeeSelectInfoView.h"
@interface ZLQueryOverSeeView : UIView
@property (nonatomic, strong) UIButton *queryButton;

@property (nonatomic, strong) ZLOverSeeSelectInfoView *selectInfoView;
@end
