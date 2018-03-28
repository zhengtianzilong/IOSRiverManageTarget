//
//  ZLSureBtnFooterView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/9.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLSureBtnFooterView.h"

@implementation ZLSureBtnFooterView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        [self addSubview:self.sureButton];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(50);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
//        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
    [self.sureButton jm_setCornerRadius:6 withBackgroundColor:HEXCOLOR(CNAVGATIONBAR_COLOR)];
    
    
}


- (UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = [[UIButton alloc]init];
        //        _queryButton.backgroundColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
        
        [_sureButton setTitle:@"确定" forState:(UIControlStateNormal)];
        
    }
    return _sureButton;
    
}

@end
