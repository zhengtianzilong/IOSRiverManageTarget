//
//  ZLLoginForgetAndRegistView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/15.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLLoginForgetAndRegistView.h"

@interface ZLLoginForgetAndRegistView ()
@property(nonatomic,strong)UIButton *forgetButton;
@property(nonatomic,strong)UIButton *registerButton;
@end

@implementation ZLLoginForgetAndRegistView

- (UIButton *)forgetButton{
    
    if (!_forgetButton) {
        _forgetButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _forgetButton.titleLabel.font = AdaptedFontSize(18);
        [_forgetButton setTitle:@"忘记密码?" forState:(UIControlStateNormal)];
        [_forgetButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self addSubview:_forgetButton];
    }
    return _forgetButton;
}

- (UIButton *)registerButton{
    
    if (!_registerButton) {
        
        _registerButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_registerButton setTitle:@"立即注册" forState:(UIControlStateNormal)];
        _registerButton.titleLabel.font = AdaptedFontSize(18);
        [_registerButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self addSubview:_registerButton];
    }
    return _registerButton;
    
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(2);
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(lineView.mas_left).offset(-5);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(AdaptedWidth(170));
        
    }];

    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lineView.mas_right).offset(5);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(AdaptedWidth(170));
        
    }];

    
    
}


@end
