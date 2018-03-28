//
//  ZLRiverBaseInfoView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLHomeLoopTopView.h"
#import "ZLRiverInfoBaseView.h"
#import "ZLBillboardInfoView.h"

@interface ZLRiverBaseInfoView : UIView

@property (nonatomic, strong) ZLHomeLoopTopView *loopTopView;

@property (nonatomic, strong) ZLRiverInfoBaseView *centerInfoView;
@property (nonatomic, strong) ZLBillboardInfoView *billboardView;
@end
