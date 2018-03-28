//
//  ZLThreeButtonView.m
//  HongZeHaiShi
//
//  Created by 蔡紫龙 on 2018/1/17.
//  Copyright © 2018年 xgzl. All rights reserved.
//

#import "ZLThreeButtonView.h"
#import "UIView+RoundedCorner.h"
@implementation ZLThreeButtonView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.oneMonthBtn];
        [self addSubview:self.oneQuarterBtn];
        [self addSubview:self.halfYearBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.oneQuarterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(1.0 / 3);
    }];
    
    [self.oneMonthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.oneQuarterBtn.mas_left);
    }];
    

    
    [self.halfYearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.oneQuarterBtn.mas_right).offset(0);
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    [self.oneQuarterBtn jm_setJMRadius:JMRadiusMake(0, 0, 0, 0) withBorderColor:[UIColor blackColor] borderWidth:1];
    
}

- (UIButton *)oneQuarterBtn{
    if (!_oneQuarterBtn) {
        
        _oneQuarterBtn = [[UIButton alloc]init];
        [_oneQuarterBtn setTitle:@"本季度" forState:(UIControlStateNormal)];
        [_oneQuarterBtn setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
    }
    return _oneQuarterBtn;
}

- (UIButton *)oneMonthBtn{
    if (!_oneMonthBtn) {
        
        _oneMonthBtn = [[UIButton alloc]init];
        [_oneMonthBtn setTitle:@"本月" forState:(UIControlStateNormal)];
        [_oneMonthBtn setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
    }
    return _oneMonthBtn;
}


- (UIButton *)halfYearBtn{
    if (!_halfYearBtn) {
        
        _halfYearBtn = [[UIButton alloc]init];
        [_halfYearBtn setTitle:@"半年" forState:(UIControlStateNormal)];
        [_halfYearBtn setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
    }
    return _halfYearBtn;
}

@end
