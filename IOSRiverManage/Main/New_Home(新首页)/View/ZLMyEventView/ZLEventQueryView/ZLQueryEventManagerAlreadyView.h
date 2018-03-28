//
//  ZLQueryEventManagerAlreadyView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/17.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLEventManagerAlreadySelectInfoView.h"
@interface ZLQueryEventManagerAlreadyView : UIView
@property (nonatomic, strong) UIButton *queryButton;

@property (nonatomic, strong) ZLEventManagerAlreadySelectInfoView *selectInfoView;
@end
