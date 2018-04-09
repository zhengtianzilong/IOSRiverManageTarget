//
//  ZLEventManagerCheckSelectInfoView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/17.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManagerCheckSelectInfoView.h"

@interface ZLEventManagerCheckSelectInfoView ()
@end

@implementation ZLEventManagerCheckSelectInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.eventName];
        [self addSubview:self.people];
        [self addSubview:self.executorPeople];
        [self addSubview:self.state];
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
        
        [self.people mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(0);
            make.top.equalTo(self.eventName.mas_bottom).offset(0);
            make.height.mas_equalTo(41);
            make.right.equalTo(self.mas_right);
        }];
        
        [self.executorPeople mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.top.equalTo(self.people.mas_bottom).offset(0);
            make.height.mas_equalTo(41);
            make.right.equalTo(self.mas_right);
        }];
        
        [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self).offset(0);
            make.top.equalTo(self.executorPeople.mas_bottom).offset(0);
            make.height.mas_equalTo(41);
            make.right.equalTo(self.mas_right);
            
        }];
        
        
        
        [self.createStartTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right).offset(0);
            make.top.equalTo(self.state.mas_bottom).offset(0);
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
        
        _eventName = [[ZLLabelAndTextFieldView alloc]initWithFrame:CGRectZero title:@"事件名称：" placeHolder:@"请输入事件名称"];
        
    }
    return _eventName;
}

- (ZLLabelAndTextFieldView *)people{
    if (!_people) {
        
        _people = [[ZLLabelAndTextFieldView alloc]initWithFrame:CGRectZero title:@"创建人：" placeHolder:@"请输入创建人"];
        
    }
    return _people;
}

- (ZLLabelAndTextFieldView *)executorPeople{
    
    if (!_executorPeople) {
        _executorPeople = [[ZLLabelAndTextFieldView alloc]initWithFrame:CGRectZero title:@"执行人：" placeHolder:@"请输入执行人"];
    }
    return _executorPeople;
    
}

- (ZLLabelAndTextFieldWithImageV *)state{
    if (!_state) {
        _state = [[ZLLabelAndTextFieldWithImageV alloc]initWithFrame:CGRectZero title:@"当前状态：" placeHolder:@"请选择当前状态" imageString:@"currentState"];
    }
    return _state;
}

- (ZLTimeSelectView *)createStartTimeView{
    if (!_createStartTimeView) {
        
        _createStartTimeView = [[ZLTimeSelectView alloc]init];
        _createStartTimeView.timeLabel.text = @"创建时间：";
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
        _completeStartTimeView.timeLabel.text = @"完成时间：";
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
