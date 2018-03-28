//
//  ZLEventManagerTopView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/28.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLEventManagerTopView.h"
#import "ZLTimeSelectView.h"
#import "ZLRiverThreeButton.h"
@interface ZLEventManagerTopView ()
@property (nonatomic, strong) ZLTimeSelectView *startTimeView;
@property (nonatomic, strong) ZLTimeSelectView *endTimeView;
@property (nonatomic, strong) ZLRiverThreeButton *threeButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *queryButton;
@end

@implementation ZLEventManagerTopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.startTimeView];
        [self addSubview:self.lineView];
        [self addSubview:self.endTimeView];
        [self addSubview:self.threeButton];
        [self addSubview:self.queryButton];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.startTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self.startTimeView.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
        make.right.equalTo(self.mas_right);
    }]; 
    
    [self.endTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.lineView.mas_bottom).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    [self.threeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(self.endTimeView.mas_bottom).offset(10);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(Main_Screen_Width * 3 / 4);
    }];
    
    [self.queryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(self.threeButton.mas_bottom).offset(10);
        make.height.mas_equalTo(50);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    
    
}

- (ZLTimeSelectView *)startTimeView{
    if (!_startTimeView) {
        
        _startTimeView = [[ZLTimeSelectView alloc]init];
        _startTimeView.backgroundColor = [UIColor whiteColor];
        _startTimeView.timeLabel.text = @"开始时间:";
    }
    return _startTimeView;
}

- (ZLTimeSelectView *)endTimeView{
    if (!_endTimeView) {
        
        _endTimeView = [[ZLTimeSelectView alloc]init];
        _endTimeView.backgroundColor = [UIColor whiteColor];
        _endTimeView.timeLabel.text = @"结束时间:";
        
    }
    return _endTimeView;
}

- (ZLRiverThreeButton *)threeButton{
    
    if (!_threeButton) {
        _threeButton = [[ZLRiverThreeButton alloc]init];
        
    }
    return _threeButton;
    
}

- (UIButton *)queryButton{
    if (!_queryButton) {
        _queryButton = [[UIButton alloc]init];
        _queryButton.backgroundColor = [UIColor blueColor];
        
        [_queryButton setTitle:@"查询" forState:(UIControlStateNormal)];
        
    }
    return _queryButton;
    
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        
        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
}

@end
