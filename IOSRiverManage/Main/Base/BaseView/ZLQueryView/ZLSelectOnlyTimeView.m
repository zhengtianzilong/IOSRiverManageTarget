//
//  ZLSelectOnlyTimeView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLSelectOnlyTimeView.h"
@interface ZLSelectOnlyTimeView ()
@property (nonatomic, strong) UIView *lineView;
@end

@implementation ZLSelectOnlyTimeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.startTimeView];
        [self addSubview:self.lineView];
        [self addSubview:self.endTimeView];
        
        [self.startTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right).offset(0);
            make.top.equalTo(self).offset(0);
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
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
   
}

- (ZLTimeSelectView *)startTimeView{
    if (!_startTimeView) {
        
        _startTimeView = [[ZLTimeSelectView alloc]init];
        _startTimeView.timeLabel.text = @"开始时间:";
    }
    return _startTimeView;
}

- (ZLTimeSelectView *)endTimeView{
    if (!_endTimeView) {
        
        _endTimeView = [[ZLTimeSelectView alloc]init];
        
        _endTimeView.timeLabel.text = @"结束时间:";
        
    }
    return _endTimeView;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        
        _lineView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    }
    return _lineView;
}

@end
