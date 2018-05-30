//
//  ZLSimpleHomeView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/9.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLSimpleHomeView.h"

@implementation ZLSimpleHomeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    
    [self addSubview:self.homeLoopImageView];
    
    [self addSubview:self.startRiverBtn];
    [self addSubview:self.riverRecordBtn];
    [self addSubview:self.eventManageBtn];
    [self addSubview:self.taskManageBtn];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.homeLoopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(0);
        make.width.mas_equalTo(Main_Screen_Width);
        make.height.mas_equalTo(170);
    }];
    
    
    [_startRiverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.homeLoopImageView.mas_bottom).offset(15);
        make.width.mas_equalTo((Main_Screen_Width - 30)/2);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
//        make.height.mas_equalTo(Main_Screen_Height);
    }];
    
    [_riverRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_startRiverBtn.mas_right).offset(10);
        make.top.equalTo(_startRiverBtn);
        make.width.mas_equalTo((Main_Screen_Width - 30)/2);
        make.height.equalTo(_startRiverBtn.mas_height).offset(-20).multipliedBy(1.0/3);
    }];

    [_eventManageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_startRiverBtn.mas_right).offset(10);
        make.centerY.equalTo(self.startRiverBtn);
        make.width.mas_equalTo((Main_Screen_Width - 30)/2);
        make.height.equalTo(_riverRecordBtn);
    }];

    [_taskManageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_startRiverBtn.mas_right).offset(10);
        make.bottom.equalTo(_startRiverBtn.mas_bottom).offset(0);
        make.width.mas_equalTo((Main_Screen_Width - 30)/2);
        make.height.equalTo(_riverRecordBtn);
    }];
    
    [_taskManageBtn setImagePosition:(LXMImagePositionLeft) spacing:10];
    [_eventManageBtn setImagePosition:(LXMImagePositionLeft) spacing:10];
    [_riverRecordBtn setImagePosition:(LXMImagePositionLeft) spacing:10];
    [_startRiverBtn setImagePosition:(LXMImagePositionTop) spacing:10];
    
    
}


- (UIButton *)startRiverBtn{
    if (!_startRiverBtn) {
        UIButton *button = [[UIButton alloc]init];
        
#if WanApp
        [button setTitle:@"开始巡湾" forState:(UIControlStateNormal)];
#else
         [button setTitle:@"开始巡河" forState:(UIControlStateNormal)];
        
        
#endif
        
       
        [button setBackgroundColor:HEXCOLOR(CVIEW_EVENT_TIPS_COLOR)];
        [button setImage:[UIImage imageNamed:@"simple_startRiver"] forState:(UIControlStateNormal)];
        button.layer.cornerRadius = 8;
        button.layer.masksToBounds = YES;
        button.adjustsImageWhenHighlighted = NO;
        
        _startRiverBtn = button;
    }
    return _startRiverBtn;
}

- (UIButton *)riverRecordBtn{
    if (!_riverRecordBtn) {
        UIButton *button = [[UIButton alloc]init];
        
#if WanApp
      [button setTitle:@"巡查记录" forState:(UIControlStateNormal)];
#else
      [button setTitle:@"巡河记录" forState:(UIControlStateNormal)];
#endif
        
//        [button setTitle:@"巡河记录" forState:(UIControlStateNormal)];
        [button setBackgroundColor:HEXCOLOR(0x56befa)];
        button.layer.cornerRadius = 8;
        button.layer.masksToBounds = YES;
        [button setImage:[UIImage imageNamed:@"simple_riverRecord"] forState:(UIControlStateNormal)];
         button.adjustsImageWhenHighlighted = NO;
        _riverRecordBtn = button;
    }
    return _riverRecordBtn;
}

- (UIButton *)eventManageBtn{
    if (!_eventManageBtn) {
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:@"事件管理" forState:(UIControlStateNormal)];
        [button setBackgroundColor:HEXCOLOR(0xf25a93)];
        button.layer.cornerRadius = 8;
        button.layer.masksToBounds = YES;
        [button setImage:[UIImage imageNamed:@"simple_eventManager"] forState:(UIControlStateNormal)];
         button.adjustsImageWhenHighlighted = NO;
        _eventManageBtn = button;
    }
    return _eventManageBtn;
}
- (UIButton *)taskManageBtn{
    if (!_taskManageBtn) {
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:@"任务管理" forState:(UIControlStateNormal)];
        [button setBackgroundColor:HEXCOLOR(0xa970e6)];
        button.layer.cornerRadius = 8;
        button.layer.masksToBounds = YES;
        [button setImage:[UIImage imageNamed:@"simple_taskManager"] forState:(UIControlStateNormal)];
         button.adjustsImageWhenHighlighted = NO;
        _taskManageBtn = button;
    }
    return _taskManageBtn;
}

- (ZLHomeLoopTopView *)homeLoopImageView{
    
    if (!_homeLoopImageView) {
        
        _homeLoopImageView = [[ZLHomeLoopTopView alloc]init];
        
    }
    return _homeLoopImageView;
    
}

@end
