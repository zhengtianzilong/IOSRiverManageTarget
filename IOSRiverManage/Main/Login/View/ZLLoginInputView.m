//
//  ZLLoginInputView.m
//  HongZeHaiShi
//
//  Created by 蔡紫龙 on 2018/1/15.
//  Copyright © 2018年 xgzl. All rights reserved.
//

#import "ZLLoginInputView.h"
#import "UIView+RoundedCorner.h"
@interface ZLLoginInputView()


@end

@implementation ZLLoginInputView

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self setUpViews];
        
    }
    return self;
    
}

- (void)setUpViews{
    [self addSubview:self.nameTextField];
    
    [self addSubview:self.passTextField];
    
    [self addSubview:self.loginBtn];
    
    [self addSubview:self.bgImageV];
    
}

- (void)updateConstraints{
    [super updateConstraints];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(20 * kScreenHeightRatio);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
//        make.width.mas_equalTo(Main_Screen_Width * 3 / 4);
        make.height.mas_equalTo(40 * kScreenHeightRatio);
    }];
    
    [self.passTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(self.nameTextField.mas_bottom).offset(5);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(40 * kScreenHeightRatio);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(self.passTextField.mas_bottom).offset(35 * kScreenHeightRatio);
        make.left.equalTo(self.passTextField).offset(10);
        make.right.equalTo(self.passTextField.mas_right).offset(-10);
        make.height.mas_equalTo(45 * kScreenHeightRatio);
        
    }];
    
    
    [self.bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
//        make.top.equalTo(self.loginBtn.mas_bottom).offset(35 * kScreenHeightRatio);
        make.width.mas_equalTo(Main_Screen_Width);
        make.height.mas_equalTo(150);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    [self.loginBtn jm_setCornerRadius:20 * kScreenHeightRatio withBorderColor:HEXCOLOR(CNAVGATIONBAR_COLOR) borderWidth:1];
    
    [self.loginBtn jm_setCornerRadius:8 withBackgroundColor:HEXCOLOR(CNAVGATIONBAR_COLOR)];

    
}

- (UITextField *)nameTextField{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc]init];
        
        _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
        _nameTextField.placeholder = @"请输入用户名";
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 20 * kScreenWidthRatio, 20 * kScreenWidthRatio)];
        imageV.image = [UIImage imageNamed:@"new_login_name"];
        _nameTextField.leftViewMode = UITextFieldViewModeAlways;
        _nameTextField.leftView = imageV;
    }
    return _nameTextField;
}

- (UITextField *)passTextField{
    if (!_passTextField) {
        _passTextField = [[UITextField alloc]init];
        _passTextField.placeholder = @"请输入密码";
        _passTextField.borderStyle = UITextBorderStyleRoundedRect;
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 20 * kScreenWidthRatio, 20 * kScreenWidthRatio)];
        imageV.image = [UIImage imageNamed:@"new_login_password"];
        _passTextField.leftViewMode = UITextFieldViewModeAlways;
        _passTextField.secureTextEntry = YES;
        _passTextField.leftView = imageV;
    }
    return _passTextField;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        [_loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
        _loginBtn.titleLabel.font = CHINESE_SYSTEM(18);
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];

    }
    return _loginBtn;
}

- (UIImageView *)bgImageV{
    if (!_bgImageV) {
        _bgImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"new_login_river"]];
        
    }
    return _bgImageV;
    
}


@end
