//
//  ZLLoginTextFieldView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/23.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLLoginTextFieldView.h"

@implementation ZLLoginTextFieldView

-(instancetype)initWithImage:(NSString *)img holdStr:(NSString *)holderStr{
    
    
    if (self = [super init]) {
        
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.left.equalTo(self);
            make.width.equalTo(self);
            make.height.mas_equalTo(1);
            
        }];
        _loginTextField = [[UITextField alloc]init];
        
        [self addSubview:_loginTextField];
        
        
        
        UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:img]];
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, imageV.frame.size.width + 10, imageV.frame.size.height)];
        [leftView addSubview:imageV];
        
        _loginTextField.leftView = leftView;
        _loginTextField.leftViewMode = UITextFieldViewModeAlways;
        _loginTextField.placeholder = holderStr;
        // "通过KVC修改占位文字的颜色"
        [_loginTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        _loginTextField.textColor = [UIColor whiteColor];
        [_loginTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self);
            make.bottom.equalTo(lineView.mas_top);
            
        }];
        
        
    }
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    
}



@end
