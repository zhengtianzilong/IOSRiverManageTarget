//
//  ZLLabelAndTextFieldView.h
//  HongZeHaiShi
//
//  Created by 蔡紫龙 on 2018/1/24.
//  Copyright © 2018年 xgzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLLabelAndTextFieldView : UIView
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextField *infoTextField;

@property (nonatomic, strong) UIView *lineView;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeHolder:(NSString *)placeHolder;
@end
