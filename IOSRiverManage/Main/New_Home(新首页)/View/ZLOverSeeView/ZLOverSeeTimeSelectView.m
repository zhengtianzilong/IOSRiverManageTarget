//
//  ZLOverSeeTimeSelectView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/6.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLOverSeeTimeSelectView.h"
#import "BRPickerView.h"

@interface ZLOverSeeTimeSelectView ()



@end

@implementation ZLOverSeeTimeSelectView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.timeLabel];
        [self addSubview:self.selectButton];
        [self addSubview:self.selectTimeLabel];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.top.equalTo(self.mas_top).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.width.mas_equalTo(15);
        }];
        
        
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(0);
            make.top.equalTo(self.timeLabel).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.width.mas_equalTo(30);
            
        }];
        
        [self.selectTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.selectButton.mas_left).offset(-10);
            make.top.equalTo(self.timeLabel).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.left.equalTo(self.timeLabel.mas_right);
            
        }];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
}

- (void)selectClick{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    [BRDatePickerView showDatePickerWithTitle:@"请选择日期" dateType:(UIDatePickerModeDate) defaultSelValue:nil minDateStr:nil maxDateStr:nil isAutoSelect:NO resultBlock:^(NSString *selectValue) {

        self.selectTimeLabel.text = selectValue;

        NSLog(@"%@", selectValue);

    }];

}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        [_timeLabel setText:@"从"];
        _timeLabel.font = CHINESE_SYSTEM(15);
    }
    return _timeLabel;
}

- (UILabel *)selectTimeLabel{
    if (!_selectTimeLabel) {
        
        _selectTimeLabel = [[UILabel alloc]init];
        _selectTimeLabel.textAlignment = NSTextAlignmentRight;
        [_selectTimeLabel setText:@"请选择时间"];
        _selectTimeLabel.font = CHINESE_SYSTEM(14);
        _selectTimeLabel.textColor = [UIColor lightGrayColor];
        _selectTimeLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectClick)];
        
        [_selectTimeLabel addGestureRecognizer:tap];
    }
    return _selectTimeLabel;
}

- (UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_selectButton setImage:[UIImage imageNamed:@"home_time"] forState:(UIControlStateNormal)];
        [_selectButton addTarget:self action:@selector(selectClick) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _selectButton;
}
@end
