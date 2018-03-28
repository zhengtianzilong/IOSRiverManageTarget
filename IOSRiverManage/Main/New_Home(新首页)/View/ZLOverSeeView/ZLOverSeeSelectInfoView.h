//
//  ZLOverSeeSelectInfoView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLTimeSelectView.h"
#import "ZLLabelAndTextFieldView.h"
@interface ZLOverSeeSelectInfoView : UIView
@property (nonatomic, strong) ZLTimeSelectView *createStartTimeView;
@property (nonatomic, strong) ZLTimeSelectView *createEndTimeView;


@property (nonatomic, strong) ZLLabelAndTextFieldView *eventName;
@property (nonatomic, strong) ZLLabelAndTextFieldView *department;
@property (nonatomic, strong) ZLLabelAndTextFieldView *people;


@property (nonatomic, strong) ZLLabelAndTextFieldView *code;
// 责任单位
@property (nonatomic, strong) ZLLabelAndTextFieldView *resDepartment;

@end
