//
//  ZLMyAssignedSelectInfoView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/8.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLTimeSelectView.h"
#import "ZLLabelAndTextFieldView.h"
@interface ZLMyAssignedSelectInfoView : UIView
@property (nonatomic, strong) ZLTimeSelectView *createStartTimeView;
@property (nonatomic, strong) ZLTimeSelectView *createEndTimeView;

@property (nonatomic, strong) ZLTimeSelectView *completeStartTimeView;
@property (nonatomic, strong) ZLTimeSelectView *completeEndTimeView;

@property (nonatomic, strong) ZLLabelAndTextFieldView *eventName;
@end
