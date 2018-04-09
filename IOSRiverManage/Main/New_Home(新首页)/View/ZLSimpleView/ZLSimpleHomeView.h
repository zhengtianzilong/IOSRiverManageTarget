//
//  ZLSimpleHomeView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/9.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLHomeLoopTopView.h"
@interface ZLSimpleHomeView : UIView
/**
 开始巡河
 */
@property (nonatomic, strong) UIButton *startRiverBtn;

/**
 巡河记录
 */
@property (nonatomic, strong) UIButton *riverRecordBtn;

/**
 事件管理
 */
@property (nonatomic, strong) UIButton *eventManageBtn;

/**
 任务管理
 */
@property (nonatomic, strong) UIButton *taskManageBtn;

@property (nonatomic, strong) ZLHomeLoopTopView *homeLoopImageView;

@end
