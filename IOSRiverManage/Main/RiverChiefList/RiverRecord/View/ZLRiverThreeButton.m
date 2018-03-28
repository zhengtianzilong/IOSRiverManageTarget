//
//  ZLRiverThreeButton.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/25.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLRiverThreeButton.h"
@interface ZLRiverThreeButton ()

@end

@implementation ZLRiverThreeButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.sevenDayBtn];
        
        [self addSubview:self.oneMonthBtn];
        
        [self addSubview:self.threeMonthBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.sevenDayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.height.mas_equalTo(40);
        make.width.equalTo(self.mas_width).multipliedBy(0.3);
    }];
    
    [self.oneMonthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.sevenDayBtn.mas_right).offset(0);
        make.top.equalTo(self).offset(0);
        make.height.mas_equalTo(40);
        make.width.equalTo(self.mas_width).multipliedBy(0.3);
    }];
    
    [self.threeMonthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.oneMonthBtn.mas_right).offset(0);
        make.top.equalTo(self).offset(0);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.mas_right);
    }];
    

}

- (UIButton *)threeMonthBtn{
    if (!_threeMonthBtn) {
        
        _threeMonthBtn = [[UIButton alloc]init];
        [_threeMonthBtn setTitle:@"三个月" forState:(UIControlStateNormal)];
        [_threeMonthBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    }
    return _threeMonthBtn;
}

- (UIButton *)oneMonthBtn{
    if (!_oneMonthBtn) {
        
        _oneMonthBtn = [[UIButton alloc]init];
        [_oneMonthBtn setTitle:@"一个月" forState:(UIControlStateNormal)];
        [_oneMonthBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    }
    return _oneMonthBtn;
}


- (UIButton *)sevenDayBtn{
    if (!_sevenDayBtn) {
        
        _sevenDayBtn = [[UIButton alloc]init];
        [_sevenDayBtn setTitle:@"七天" forState:(UIControlStateNormal)];
        [_sevenDayBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    }
    return _sevenDayBtn;
}


@end
