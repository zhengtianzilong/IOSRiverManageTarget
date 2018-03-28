//
//  ZLOverSeeSelectInfoView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/6.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ZLOverSeeTimeView.h"
#import "ZLTimeSelectView.h"
#import "ZLLabelAndTextFieldView.h"
@interface ZLAssignedSelectInfoView : UIView

@property (nonatomic, strong) ZLTimeSelectView *createStartTimeView;
@property (nonatomic, strong) ZLTimeSelectView *createEndTimeView;

@property (nonatomic, strong) ZLTimeSelectView *completeStartTimeView;
@property (nonatomic, strong) ZLTimeSelectView *completeEndTimeView;

@property (nonatomic, strong) ZLLabelAndTextFieldView *eventName;
@property (nonatomic, strong) ZLLabelAndTextFieldView *department;
@property (nonatomic, strong) ZLLabelAndTextFieldView *people;

@end
