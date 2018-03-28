//
//  ZLReportAndDownTaskView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/27.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLReportAndDownTaskView.h"

@implementation ZLReportAndDownTaskView

- (UIButton *)downTaskButton{
    if (!_downTaskButton) {
        
        _downTaskButton = [[UIButton alloc]init];
        [_downTaskButton setBackgroundImage:[UIImage imageNamed:@"baidu_sendDown"] forState:UIControlStateNormal];
        [self addSubview:_downTaskButton];
    }
    return _downTaskButton;
}

- (UIButton *)reportButton{
    
    if (!_reportButton) {
        _reportButton = [[UIButton alloc]init];
        [_reportButton setBackgroundImage:[UIImage imageNamed:@"baidu_report"] forState:UIControlStateNormal];
        [self addSubview:_reportButton];
    }
    return _reportButton;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
        
    }
    return self;
}

- (void)setUpUI{
    [self.downTaskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(47);
        make.height.mas_equalTo(47);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = HEXCOLOR(0xe1e1e1);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_downTaskButton.mas_top);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
        make.height.mas_equalTo(1);
        
    }];
  
    
    [self.reportButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(lineView.mas_top).offset(0);
        make.width.mas_equalTo(47);
        make.height.mas_equalTo(47);
    }];

    
    
    
}


@end
