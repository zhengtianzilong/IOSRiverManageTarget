//
//  ZLEventManagerAlreadySelectInfoView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/17.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLLabelAndTextFieldView.h"
#import "ZLTimeSelectView.h"

@interface ZLEventManagerAlreadySelectInfoView : UIView
@property (nonatomic, strong) ZLLabelAndTextFieldView *eventName;
@property (nonatomic, strong) ZLLabelAndTextFieldView *people;
@property (nonatomic, strong) ZLTimeSelectView *createStartTimeView;
@property (nonatomic, strong) ZLTimeSelectView *createEndTimeView;

@property (nonatomic, strong) ZLTimeSelectView *completeStartTimeView;
@property (nonatomic, strong) ZLTimeSelectView *completeEndTimeView;

@end
