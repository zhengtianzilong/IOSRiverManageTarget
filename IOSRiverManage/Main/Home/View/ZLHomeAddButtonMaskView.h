//
//  ZLHomeAddButtonMaskView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/10/24.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIButton+JKImagePosition.h"
@interface ZLHomeAddButtonMaskView : UIView
/**
 事件上报
 */
@property (nonatomic, strong) UIButton *eventReportBtn;


/**
 任务下发
 */
@property (nonatomic, strong) UIButton *taskDownBtn;


/**
 河长巡河
 */
@property (nonatomic, strong) UIButton *riverBtn;


- (void)dismissView;

@end
