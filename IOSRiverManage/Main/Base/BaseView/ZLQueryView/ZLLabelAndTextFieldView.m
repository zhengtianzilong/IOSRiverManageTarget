//
//  ZLLabelAndTextFieldView.m
//  HongZeHaiShi
//
//  Created by 蔡紫龙 on 2018/1/24.
//  Copyright © 2018年 xgzl. All rights reserved.
//

#import "ZLLabelAndTextFieldView.h"
@interface ZLLabelAndTextFieldView ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *placeHolder;

@end
@implementation ZLLabelAndTextFieldView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeHolder:(NSString *)placeHolder{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.title = title;
        self.placeHolder = placeHolder;
        [self addSubview:self.titleLabel];
        [self addSubview:self.infoTextField];
        [self addSubview:self.lineView];

    }
    
    return self;
}




- (void)layoutSubviews{
    [super layoutSubviews];
    
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
        make.width.mas_equalTo(87);
    }];
    
    [self.infoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        
    }];
    


}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setText:self.title];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = Font(12);
        
    }
    return _titleLabel;
}

- (UITextField *)infoTextField{
    if (!_infoTextField) {
        _infoTextField = [[UITextField alloc]init];
        _infoTextField.placeholder = self.placeHolder;
        _infoTextField.backgroundColor = [UIColor whiteColor];
        _infoTextField.font = CHINESE_SYSTEM(12);
        [_infoTextField setValue:CHINESE_SYSTEM(12) forKeyPath:@"_placeholderLabel.font"];
    }
    return _infoTextField;
}





- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        
        _lineView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    }
    return _lineView;
}

@end
