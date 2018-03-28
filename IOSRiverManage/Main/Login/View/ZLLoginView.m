//
//  ZLLoginView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/15.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLLoginView.h"

#import "ZLLoginForgetAndRegistView.h"
@interface ZLLoginView ()

@end

@implementation ZLLoginView

- (ZLLoginTextFieldView *)nameFiledView{
    if (!_nameFiledView) {
        
        _nameFiledView = [[ZLLoginTextFieldView alloc]initWithImage:@"login_name" holdStr:@"请输入账号"];
        
    }
    return _nameFiledView;
}

- (ZLLoginTextFieldView *)passwordFiledView{
    
    if (!_passwordFiledView) {
        _passwordFiledView = [[ZLLoginTextFieldView alloc]initWithImage:@"login_password" holdStr:@"请输入密码"];
        _passwordFiledView.loginTextField.secureTextEntry = YES;
    }
    return _passwordFiledView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    UIImageView *bgImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, App_Frame_Width, App_Frame_Height + 20)];
    bgImageV.userInteractionEnabled = YES;
    [self addSubview:bgImageV];
    bgImageV.image = [UIImage imageNamed:@"login_bg"];
    
    
    UIImageView *logoView=[[UIImageView alloc]init];
    [bgImageV addSubview:logoView];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImageV);
        make.top.mas_equalTo(AdaptedHeight(111));
        make.height.mas_equalTo(AdaptedHeight(170));
        make.width.mas_equalTo(AdaptedWidth(192));
    }];
    
    UIImageView *labelImageV=[[UIImageView alloc]init];
    [bgImageV addSubview:labelImageV];
    [labelImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImageV);
        make.top.equalTo(logoView.mas_bottom).offset(AdaptedHeight(45));
    }];
    
#if TouBiao
    labelImageV.image = [UIImage imageNamed:@"zhengjiang_title"];
#else
    labelImageV.image = [UIImage imageNamed:@"login_title"];
#endif
    
    
    logoView.image=[UIImage imageNamed:@"login_logo"];
    
    [bgImageV addSubview:self.nameFiledView];
    [self.nameFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgImageV).offset(-AdaptedWidth(40));
        make.left.equalTo(bgImageV).offset(AdaptedWidth(40));
        make.top.equalTo(labelImageV.mas_bottom).offset(AdaptedHeight(120));
        make.height.mas_equalTo(AdaptedHeight(65));
    }];
    
    
   
    [bgImageV addSubview:self.passwordFiledView];
    [self.passwordFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgImageV).offset(-AdaptedWidth(40));
        make.left.equalTo(bgImageV).offset(AdaptedWidth(40));
        make.top.equalTo(_nameFiledView.mas_bottom).offset(AdaptedHeight(50));
        make.height.mas_equalTo(AdaptedHeight(65));
    }];

    
    _loginBtn=[[UIButton alloc]init];
    [bgImageV addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordFiledView.mas_bottom).offset(AdaptedHeight(86));
        make.height.mas_equalTo(47);
        make.right.equalTo(self).offset(-AdaptedWidth(85));
        make.left.equalTo(self).offset(AdaptedWidth(85));
    }];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn setBackgroundColor:HEXCOLOR(0x0769be)];
    _loginBtn.layer.cornerRadius = 5;
    _loginBtn.clipsToBounds = YES;
    
//    ZLLoginForgetAndRegistView *forgetAndRegistView = [[ZLLoginForgetAndRegistView alloc]init];
//    [self addSubview:forgetAndRegistView];
//    [forgetAndRegistView mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.centerX.equalTo(_loginBtn);
//        make.top.equalTo(_loginBtn.mas_bottom).offset(AdaptedHeight(22));
//        make.height.mas_equalTo(AdaptedHeight(35));
//        make.width.mas_equalTo(AdaptedWidth(400));
//        
//    }];
    
    
    UIImageView *introduceImageV=[[UIImageView alloc]init];
    [bgImageV addSubview:introduceImageV];
    [introduceImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImageV);
        make.bottom.equalTo(bgImageV.mas_bottom).offset(-AdaptedHeight(110));
    }];
    introduceImageV.image = [UIImage imageNamed:@"login_introduce"];
    
    
    
    
}



@end
