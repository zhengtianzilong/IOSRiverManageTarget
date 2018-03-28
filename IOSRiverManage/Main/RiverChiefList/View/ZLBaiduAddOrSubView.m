//
//  ZLBaiduAddOrSubView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/20.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLBaiduAddOrSubView.h"

@implementation ZLBaiduAddOrSubView

- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_addButton setImage:[UIImage imageNamed:@"baidu_add"] forState:(UIControlStateNormal)];
        _addButton.layer.cornerRadius = 5;
        _addButton.clipsToBounds = YES;
        [self addSubview:_addButton];
    }
    return _addButton;
}

- (UIButton *)subButton{
    
    if (!_subButton) {
        _subButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_subButton setImage:[UIImage imageNamed:@"baidu_sub"] forState:(UIControlStateNormal)];
        [self addSubview:_subButton];
        _subButton.layer.cornerRadius = 5;
        _subButton.clipsToBounds = YES;
    }
    return _subButton;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
        
    }
    return self;
}

- (void)setUpUI{
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = HEXCOLOR(0xe1e1e1);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
        make.height.mas_equalTo(1);
        
    }];
    
   
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.width.mas_equalTo(37);
        make.bottom.equalTo(lineView.mas_top);
        make.top.equalTo(self);
        
    }];
    

    
    

    [self.subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.mas_equalTo(37);
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(lineView.mas_bottom);
        
    }];
    
}


@end
