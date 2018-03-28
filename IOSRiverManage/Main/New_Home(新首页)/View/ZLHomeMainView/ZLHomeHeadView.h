//
//  ZLHomeHeadView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/5.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLHomeLoopTopView.h"
#import "ZLHomeCenterView.h"

#import "ZLHomeRiverRunningView.h"

@interface ZLHomeHeadView : UIView
@property (nonatomic, strong) ZLHomeCenterView *homeCenterView;
@property (nonatomic, strong) ZLHomeLoopTopView *homeLoopImageView;

@property (nonatomic, strong) ZLHomeRiverRunningView *runningView;

@property (nonatomic, assign) BOOL isHideRunningView;



@end
