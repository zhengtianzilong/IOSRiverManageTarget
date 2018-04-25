//
//  ZLTimeSelectView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/28.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLTimeSelectView.h"
#import "BRPickerView.h"
@interface ZLTimeSelectView ()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation ZLTimeSelectView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.timeLabel];
        [self addSubview:self.selectButton];
        [self addSubview:self.selectTimeLabel];
        [self addSubview:self.lineView];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(1);
            
            
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self.mas_top).offset(0);
            make.bottom.equalTo(self.lineView.mas_bottom).offset(0);
            make.width.mas_equalTo(80);
        }];
        
        
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(self.timeLabel).offset(0);
            make.bottom.equalTo(self.lineView.mas_bottom).offset(0);
            make.width.mas_equalTo(30);
            
        }];
        
        [self.selectTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.selectButton.mas_left).offset(0);
            make.top.equalTo(self.timeLabel).offset(0);
            make.bottom.equalTo(self.lineView.mas_bottom).offset(0);
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
    
    [BRDatePickerView showDatePickerWithTitle:@"请选择日期" dateType:(UIDatePickerModeDateAndTime) defaultSelValue:nil minDateStr:nil maxDateStr:nil isAutoSelect:NO resultBlock:^(NSString *selectValue) {
        
        self.selectTimeLabel.text = selectValue;
        
        NSLog(@"%@", selectValue);
        
    }];
    
}

- (void)longGesClick:(UILongPressGestureRecognizer *)sender{
    
    if (![_selectTimeLabel.text isEqualToString:@"请选择时间"]) {
        
        if (sender.state == UIGestureRecognizerStateBegan) {
            
            
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
            
            [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                
                if (buttonIndex == 1) {
                    [_selectTimeLabel setText:@"请选择时间"];
                    
                }
                
            } title:@"提示" message:@"确定清除这个时间吗?" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
        }
    }
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        [_timeLabel setText:@"日 期:"];
        _timeLabel.font = Font(12);
    }
    return _timeLabel;
}

- (UILabel *)selectTimeLabel{
    if (!_selectTimeLabel) {
        
        _selectTimeLabel = [[UILabel alloc]init];
        _selectTimeLabel.textAlignment = NSTextAlignmentRight;
        [_selectTimeLabel setText:@"请选择时间"];
        _selectTimeLabel.font = CHINESE_SYSTEM(12);
        _selectTimeLabel.textColor = [UIColor lightGrayColor];
        _selectTimeLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectClick)];
        
        [_selectTimeLabel addGestureRecognizer:tap];
        
        UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longGesClick:)];
        
        [_selectTimeLabel addGestureRecognizer:longGes];
        
        
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

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    }
    return _lineView;
}

@end
