//
//  ZLOverSeeTimeView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/6.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLOverSeeTimeView.h"

@implementation ZLOverSeeTimeView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.title = title;
        [self addSubview:self.titleLabel];
        [self addSubview:self.startTimeView];
        [self addSubview:self.endTimeView];
        [self addSubview:self.lineView];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.height.mas_equalTo(1);
            make.right.equalTo(self.mas_right);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(0);
            make.bottom.equalTo(self.lineView.mas_top).offset(0);
            make.width.mas_equalTo(80);
        }];
        
        [self.startTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(-5);
            make.top.equalTo(self.mas_top).offset(0);
            make.bottom.equalTo(self.titleLabel.mas_bottom);
            //        make.right.equalTo(self.mas_right);
            make.width.mas_equalTo((Main_Screen_Width - 80)/ 2);
            
        }];
        
        [self.endTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.startTimeView.mas_right).offset(-5);
            make.top.equalTo(self.mas_top).offset(0);
            make.bottom.equalTo(self.titleLabel.mas_bottom);
            //        make.width.mas_equalTo((Main_Screen_Width - 80)/ 2);
            make.right.equalTo(self.mas_right);
            
        }];
        
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
   
    
}

//- (void)startBtn{
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
//
//    [BRDatePickerView showDatePickerWithTitle:@"请选择日期" dateType:(UIDatePickerModeDate) defaultSelValue:nil minDateStr:nil maxDateStr:nil isAutoSelect:NO resultBlock:^(NSString *selectValue) {
//
//        self.startTimeView.selectTimeLabel.text = selectValue;
//
//        NSLog(@"%@", selectValue);
//
//    }];
//
//}
//
//- (void)endBtn{
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
//
//    [BRDatePickerView showDatePickerWithTitle:@"请选择日期" dateType:(UIDatePickerModeDate) defaultSelValue:nil minDateStr:nil maxDateStr:nil isAutoSelect:NO resultBlock:^(NSString *selectValue) {
//
//        self.endTimeView.selectTimeLabel.text = selectValue;
//
//        NSLog(@"%@", selectValue);
//
//    }];
//
//}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setText:self.title];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = CHINESE_SYSTEM(13);
        
    }
    return _titleLabel;
}

- (ZLOverSeeTimeSelectView *)startTimeView{
    if (!_startTimeView) {
        _startTimeView = [[ZLOverSeeTimeSelectView alloc]init];
        _startTimeView.timeLabel.text = @"从";
//        [_startTimeView.selectButton addTarget:self action:@selector(startBtn) forControlEvents:(UIControlEventTouchUpInside)];
        _startTimeView.backgroundColor = [UIColor whiteColor];
        
    }
    return _startTimeView;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        
        _lineView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    }
    return _lineView;
}


- (ZLOverSeeTimeSelectView *)endTimeView{
    if (!_endTimeView) {
        _endTimeView = [[ZLOverSeeTimeSelectView alloc]init];
        _endTimeView.timeLabel.text = @"到";
//        [_endTimeView.selectButton addTarget:self action:@selector(endBtn) forControlEvents:(UIControlEventTouchUpInside)];
        _endTimeView.backgroundColor = [UIColor whiteColor];
        
    }
    return _endTimeView;
}

@end
