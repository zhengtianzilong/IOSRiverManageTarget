//
//  ZLRiverRecordTopView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/25.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLRiverRecordTopView.h"
#import "ZLTimeSelectView.h"
@interface ZLRiverRecordTopView ()

@property (nonatomic, strong) UILabel *riverLabel;

@property (nonatomic, strong) UITextField *riverTextField;

@property (nonatomic, strong) ZLTimeSelectView *timeSelectView;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation ZLRiverRecordTopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.riverLabel];
        [self addSubview:self.riverTextField];
        [self addSubview:self.lineView];
        [self addSubview:self.timeSelectView];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.riverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(0);
        make.height.mas_equalTo(40);
        
    }];
    
    [self.riverTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.riverLabel.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.mas_right);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self.riverTextField.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
        make.right.equalTo(self.mas_right);
    }];
    
    [self.timeSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.lineView.mas_bottom).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        
    }];
    

    
}

- (UILabel *)riverLabel{
    if (!_riverLabel) {
        
        _riverLabel = [[UILabel alloc]init];
        
        
        [_riverLabel setText:[NSString stringWithFormat:@"%@：",S_BaseName]];
        _riverLabel.font = SYSTEMFONT(20);
        
    }
    return _riverLabel;
    
    
}

- (UITextField *)riverTextField{
    if (!_riverTextField) {
        _riverTextField = [[UITextField alloc]init];
        _riverTextField.placeholder = [NSString stringWithFormat:@"请输入%@名称", S_BaseName];
        
    }
    return _riverTextField;
}

- (ZLTimeSelectView *)timeSelectView{
    if (!_timeSelectView) {
        
        _timeSelectView = [[ZLTimeSelectView alloc]init];
        
    }
    return _timeSelectView;
}


- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        
        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
}

@end
