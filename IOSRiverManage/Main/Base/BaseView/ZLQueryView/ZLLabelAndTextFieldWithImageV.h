//
//  ZLLabelAndTextFieldWithImageV.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/17.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectBlock)(UITextField *textField);

@interface ZLLabelAndTextFieldWithImageV : UIView
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextField *infoTextField;

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) selectBlock selectBlock;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeHolder:(NSString *)placeHolder imageString:(NSString *)imageString;
@end
