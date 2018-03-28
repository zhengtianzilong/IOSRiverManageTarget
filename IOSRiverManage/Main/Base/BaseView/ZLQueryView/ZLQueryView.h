//
//  ZLQueryView.h
//  HongZeHaiShi
//
//  Created by 蔡紫龙 on 2018/1/17.
//  Copyright © 2018年 xgzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLTimeSelectView.h"
#import "ZLThreeButtonView.h"
#import "UIView+RoundedCorner.h"
#import "ZLSelectInfoView.h"
@interface ZLQueryView : UIView
@property (nonatomic, strong) UIButton *queryButton;
@property (nonatomic, strong) ZLSelectInfoView *selectInfoView;

@property (nonatomic, strong) ZLThreeButtonView *threeButton;
@end
