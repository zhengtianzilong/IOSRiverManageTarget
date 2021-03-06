//
//  ZLMyAssignedSelectInfoView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/8.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyAssignedSelectInfoView.h"
@interface ZLMyAssignedSelectInfoView ()
@property (nonatomic, strong) UIView *lineView;
@end

@implementation ZLMyAssignedSelectInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.eventName];
        
        [self addSubview:self.createEndTimeView];
        [self addSubview:self.createStartTimeView];
        
        [self addSubview:self.completeEndTimeView];
        [self addSubview:self.completeStartTimeView];
        
        
        [self.eventName mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(0);
            make.top.equalTo(self).offset(0);
            make.height.mas_equalTo(41);
            make.right.equalTo(self.mas_right);
        }];
        
        [self.createStartTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right).offset(0);
            make.top.equalTo(self.eventName.mas_bottom).offset(0);
            make.height.mas_equalTo(41);
        }];
        
        
        [self.createEndTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right).offset(0);
            make.top.equalTo(self.createStartTimeView.mas_bottom).offset(0);
            make.height.mas_equalTo(41);
        }];
        
        
        
        
        [self.completeStartTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right).offset(0);
            make.top.equalTo(self.createEndTimeView.mas_bottom).offset(0);
            make.height.mas_equalTo(41);
        }];
        
        
        
        [self.completeEndTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right).offset(0);
            make.top.equalTo(self.completeStartTimeView.mas_bottom).offset(0);
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
        
        _eventName = [[ZLLabelAndTextFieldView alloc]initWithFrame:CGRectZero title:@"事项名称：" placeHolder:@"请输入事项名称"];
        
    }
    return _eventName;
}

- (ZLTimeSelectView *)createStartTimeView{
    if (!_createStartTimeView) {
        
        _createStartTimeView = [[ZLTimeSelectView alloc]init];
        _createStartTimeView.timeLabel.text = @"交办时间：";
    }
    return _createStartTimeView;
}

- (ZLTimeSelectView *)createEndTimeView{
    if (!_createEndTimeView) {
        
        _createEndTimeView = [[ZLTimeSelectView alloc]init];
        
        _createEndTimeView.timeLabel.text = @"";
        
    }
    return _createEndTimeView;
}

- (ZLTimeSelectView *)completeStartTimeView{
    if (!_completeStartTimeView) {
        
        _completeStartTimeView = [[ZLTimeSelectView alloc]init];
        _completeStartTimeView.timeLabel.text = @"完成时限：";
    }
    return _completeStartTimeView;
}

- (ZLTimeSelectView *)completeEndTimeView{
    if (!_completeEndTimeView) {
        
        _completeEndTimeView = [[ZLTimeSelectView alloc]init];
        
        _completeEndTimeView.timeLabel.text = @"";
        
    }
    return _completeEndTimeView;
}

@end
