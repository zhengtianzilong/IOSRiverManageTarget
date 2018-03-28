//
//  ZLLoginTopView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/12.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLLoginTopView.h"

@implementation ZLLoginTopView
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    [self addSubview:self.titleImageV];
    [self addSubview:self.logoImageV];
    
    [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(90);
        make.height.height.mas_equalTo(90);
        
    }];
    
    [self.titleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(self.logoImageV.mas_bottom).offset(15);
        make.height.mas_equalTo(35);
        
        make.bottom.equalTo(self.mas_bottom) ;
        
    }];
    
    
    
    
    
}


- (UIImageView *)logoImageV{
    
    if (!_logoImageV) {
        
        _logoImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"new_login_logo"]];
        
        
    }
    return _logoImageV;
    
}

- (UIImageView *)titleImageV{
    
    if (!_titleImageV) {
        
        _titleImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"new_login_title"]];
        
        
    }
    return _titleImageV;
    
}


@end
