//
//  ZLHomeAddButtonMaskView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/10/24.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLHomeAddButtonMaskView.h"

@implementation ZLHomeAddButtonMaskView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
//        self.alpha = 0.8;
        [self setUpUI];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setUpUI{
    _riverBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
#if WanApp
    [_riverBtn setTitle:@"湾长巡湾" forState:(UIControlStateNormal)];
#else
    [_riverBtn setTitle:@"河长巡河" forState:(UIControlStateNormal)];
#endif
    
    
    _riverBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_riverBtn setImage:[UIImage imageNamed:@"mask_startRiver"] forState:(UIControlStateNormal)];
    [self addSubview:_riverBtn];
    
    
    _taskDownBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_taskDownBtn setTitle:@"任务下发" forState:(UIControlStateNormal)];
    _taskDownBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_taskDownBtn setImage:[UIImage imageNamed:@"mask_taskDown"] forState:(UIControlStateNormal)];
    [self addSubview:_taskDownBtn];
    
  
    
    _eventReportBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_eventReportBtn setTitle:@"事件上报" forState:(UIControlStateNormal)];
    _eventReportBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_eventReportBtn setImage:[UIImage imageNamed:@"mask_eventReport"] forState:(UIControlStateNormal)];
    [self addSubview:_eventReportBtn];
    
    [_eventReportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-5);
        make.bottom.equalTo(_taskDownBtn.mas_top).offset(-5);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(150);
       
    }];
    
    [_riverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-5);
        make.bottom.equalTo(_eventReportBtn.mas_top).offset(-5);
        make.height.equalTo(_eventReportBtn);
        make.width.equalTo(_eventReportBtn);
       
    }];
    [_riverBtn setImagePosition:(LXMImagePositionRight) spacing:15];
    
    [_taskDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.right.equalTo(self.mas_right).offset(-5);
        make.bottom.equalTo(self.mas_bottom).offset(-BottomBarHeight);
        make.height.equalTo(_eventReportBtn);
        make.width.equalTo(_eventReportBtn);
    }];
    [_taskDownBtn setImagePosition:(LXMImagePositionRight) spacing:15];
    
    
    [_eventReportBtn setImagePosition:(LXMImagePositionRight) spacing:15];
    
}


- (void)tapClick:(UIGestureRecognizer *)ges{
    
    [self dismissView];
    
}

- (void)dismissView{
    [self removeFromSuperview];
}

@end
