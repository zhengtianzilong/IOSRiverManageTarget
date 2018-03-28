//
//  ZLOverSeeSelectInfoView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLOverSeeSelectInfoView.h"
@interface ZLOverSeeSelectInfoView ()
@property (nonatomic, strong) UIView *lineView;
@end

@implementation ZLOverSeeSelectInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.eventName];
        [self addSubview:self.department];
        [self addSubview:self.people];
        [self addSubview:self.code];
        [self addSubview:self.resDepartment];
        [self addSubview:self.createEndTimeView];
        [self addSubview:self.createStartTimeView];
        
        [self.eventName mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(0);
            make.top.equalTo(self).offset(0);
            make.height.mas_equalTo(41);
            make.right.equalTo(self.mas_right);
        }];
        
        [self.department mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(0);
            make.top.equalTo(self.eventName.mas_bottom).offset(0);
            make.height.mas_equalTo(41);
            make.right.equalTo(self.mas_right);
        }];
        
        [self.code mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(0);
            make.top.equalTo(self.department.mas_bottom).offset(0);
            make.height.mas_equalTo(41);
            make.right.equalTo(self.mas_right);
        }];
        
        [self.resDepartment mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(0);
            make.top.equalTo(self.code.mas_bottom).offset(0);
            make.height.mas_equalTo(41);
            make.right.equalTo(self.mas_right);
        }];
        
        [self.people mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(0);
            make.top.equalTo(self.resDepartment.mas_bottom).offset(0);
            make.height.mas_equalTo(41);
            make.right.equalTo(self.mas_right);
        }];
        
     
        [self.createStartTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right).offset(0);
            make.top.equalTo(self.people.mas_bottom).offset(0);
            make.height.mas_equalTo(41);
        }];
        
        
        [self.createEndTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right).offset(0);
            make.top.equalTo(self.createStartTimeView.mas_bottom).offset(0);
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
        
        _eventName = [[ZLLabelAndTextFieldView alloc]initWithFrame:CGRectZero title:@"事项名称:" placeHolder:@"请输入事项名称"];
        
    }
    return _eventName;
}
- (ZLLabelAndTextFieldView *)department{
    if (!_department) {
        
        _department = [[ZLLabelAndTextFieldView alloc]initWithFrame:CGRectZero title:@"督办单位:" placeHolder:@"请输入督办单位"];
        
    }
    return _department;
}
- (ZLLabelAndTextFieldView *)people{
    if (!_people) {
        
        _people = [[ZLLabelAndTextFieldView alloc]initWithFrame:CGRectZero title:@"责任人:" placeHolder:@"请输入责任人"];
        
    }
    return _people;
}
- (ZLLabelAndTextFieldView *)code{
    if (!_code) {
        
        _code = [[ZLLabelAndTextFieldView alloc]initWithFrame:CGRectZero title:@"交办单编号:" placeHolder:@"请输入编号"];
        
    }
    return _code;
}
- (ZLLabelAndTextFieldView *)resDepartment{
    if (!_resDepartment) {
        
        _resDepartment = [[ZLLabelAndTextFieldView alloc]initWithFrame:CGRectZero title:@"责任单位:" placeHolder:@"请输入责任单位"];
        
    }
    return _resDepartment;
}
- (ZLTimeSelectView *)createStartTimeView{
    if (!_createStartTimeView) {
        
        _createStartTimeView = [[ZLTimeSelectView alloc]init];
        _createStartTimeView.timeLabel.text = @"督办时间:";
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

@end
