//
//  ZLSelectInfoView.h
//  HongZeHaiShi
//
//  Created by 蔡紫龙 on 2018/1/17.
//  Copyright © 2018年 xgzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLTimeSelectView.h"
#import "ZLLabelAndTextFieldView.h"
@interface ZLSelectInfoView : UIView
@property (nonatomic, strong) ZLTimeSelectView *startTimeView;
@property (nonatomic, strong) ZLTimeSelectView *endTimeView;
@property (nonatomic, strong) ZLLabelAndTextFieldView *nameAndTextField;
@end
