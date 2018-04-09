//
//  ZLEventDownManagerSelectInfoView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventDownManagerSelectInfoView.h"

@implementation ZLEventDownManagerSelectInfoView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.eventName];
        [self addSubview:self.startTimeView];
        [self addSubview:self.endTimeView];
        
        [self.eventName mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(0);
            make.top.equalTo(self).offset(0);
            make.height.mas_equalTo(41);
            make.right.equalTo(self.mas_right);
        }];
        
        [self.startTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right).offset(0);
            make.top.equalTo(self.eventName.mas_bottom).offset(0);
            make.height.mas_equalTo(41);
        }];
        
        
        [self.endTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right).offset(0);
            make.top.equalTo(self.startTimeView.mas_bottom).offset(0);
            make.height.mas_equalTo(41);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
}

- (ZLLabelAndTextFieldView *)eventName{
    if (!_eventName) {
        
        _eventName = [[ZLLabelAndTextFieldView alloc]initWithFrame:CGRectZero title:@"事件名称：" placeHolder:@"请输入事件名称"];
        
    }
    return _eventName;
}

- (ZLTimeSelectView *)startTimeView{
    if (!_startTimeView) {
        
        _startTimeView = [[ZLTimeSelectView alloc]init];
        _startTimeView.timeLabel.text = @"创建时间：";
    }
    return _startTimeView;
}

- (ZLTimeSelectView *)endTimeView{
    if (!_endTimeView) {
        
        _endTimeView = [[ZLTimeSelectView alloc]init];
        
        _endTimeView.timeLabel.text = @"";
        
    }
    return _endTimeView;
}


@end
