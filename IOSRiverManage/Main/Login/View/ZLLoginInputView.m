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

@property (nonatomic, strong) UISegmentedControl *segment;


@end

@implementation ZLLoginInputView

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self setUpViews];
        
        // 1 默认是高级版
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:DBApp_Version];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    return self;
    
}

- (void)setUpViews{
    [self addSubview:self.nameTextField];
    
    [self addSubview:self.passTextField];
    
    [self addSubview:self.segment];
    
    
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
    
    
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.passTextField.mas_bottom).offset(15);
        make.width.mas_equalTo(Main_Screen_Width / 3);
        make.height.mas_equalTo(35);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.segment.mas_bottom).offset(35 * kScreenHeightRatio);
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

- (void)selectItem:(UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex == 0) {
        // 1 是高级版
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:DBApp_Version];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        // 2.是基础班
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:DBApp_Version];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


- (UITextField *)nameTextField{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc]init];
        
        _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
        _nameTextField.placeholder = @"请输入用户名";
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 30 * kScreenWidthRatio, 20 * kScreenWidthRatio)];
        imageV.image = [UIImage imageNamed:@"new_login_name"];
        _nameTextField.leftViewMode = UITextFieldViewModeAlways;
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTextField.leftView = imageV;
    }
    return _nameTextField;
}

- (UITextField *)passTextField{
    if (!_passTextField) {
        _passTextField = [[UITextField alloc]init];
        _passTextField.placeholder = @"请输入密码";
        _passTextField.borderStyle = UITextBorderStyleRoundedRect;
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 30 * kScreenWidthRatio, 20 * kScreenWidthRatio)];
        imageV.image = [UIImage imageNamed:@"new_login_password"];
        _passTextField.leftViewMode = UITextFieldViewModeAlways;
        _passTextField.secureTextEntry = YES;
        _passTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passTextField.leftView = imageV;
    }
    return _passTextField;
}

- (UISegmentedControl *)segment{
    if (!_segment) {
        _segment = [[UISegmentedControl alloc]initWithItems:@[@"高级版",@"基础版"]];
        // 设置初始选中项
        _segment.selectedSegmentIndex = 0;
        // 设置整体的色调
        _segment.tintColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
        [_segment addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventValueChanged];// 添加响应方法
    }
    return _segment;
    
}



- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        [_loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
        _loginBtn.titleLabel.font = CHINESE_SYSTEM(16);
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
