//
//  ZLNewReportBottomView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/17.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLNewReportBottomView : UIView
@property (nonatomic, strong) UIButton *saveButton;

@property (nonatomic, strong) UIButton *reportButton;

//@property (nonatomic, strong) UIButton *deleteButton;

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles;
@end
