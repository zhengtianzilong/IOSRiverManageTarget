//
//  ZLSelectOnlyTimeView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLTimeSelectView.h"
@interface ZLSelectOnlyTimeView : UIView
@property (nonatomic, strong) ZLTimeSelectView *startTimeView;
@property (nonatomic, strong) ZLTimeSelectView *endTimeView;
@end
