//
//  ZLMyAdviseBottomView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLMyAdviseBottomView : UIView
@property (nonatomic, strong) UIButton *startButton;

@property (nonatomic, strong) UIButton *endButton;

@property (nonatomic, strong) NSArray *titles;

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles;

@end
