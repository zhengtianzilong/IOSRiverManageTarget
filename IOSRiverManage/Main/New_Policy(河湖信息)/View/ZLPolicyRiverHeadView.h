//
//  ZLPolicyRiverHeadView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/5.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLHomeLoopTopView.h"
#import "ZLPolicyRiverCategoryView.h"
#import "ZLPolicyRiverInfoView.h"

@interface ZLPolicyRiverHeadView : UIView
@property (nonatomic, strong) ZLHomeLoopTopView *loopTopView;
@property (nonatomic, strong) ZLPolicyRiverCategoryView *riverCategoryView;
@property (nonatomic, strong) ZLPolicyRiverInfoView *riverInfoView;
@end
