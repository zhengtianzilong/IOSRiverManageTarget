//
//  ZLLabelAndTextFieldWithImageV.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/17.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLLabelAndTextFieldWithImageV.h"
@interface ZLLabelAndTextFieldWithImageV ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *placeHolder;
@property (nonatomic, strong) NSString *imageString;
@end
@implementation ZLLabelAndTextFieldWithImageV

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeHolder:(NSString *)placeHolder imageString:(NSString *)imageString{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.title = title;
        self.placeHolder = placeHolder;
        self.imageString = imageString;
        [self addSubview:self.titleLabel];
        [self addSubview:self.infoTextField];
        [self addSubview:self.lineView];
        [self addSubview:self.imageV];
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
        make.width.mas_equalTo(80);
    }];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self);
//        make.bottom.equalTo(self.lineView.mas_top).offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.infoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.imageV.mas_left);
    }];
}

- (void)tapclick{
    
    
    
}

- (UIImageView *)imageV{
    
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
        _imageV.image = [UIImage imageNamed:self.imageString];
    }
    return _imageV;
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setText:self.title];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = CHINESE_SYSTEM(15);
        
    }
    return _titleLabel;
}

- (UITextField *)infoTextField{
    if (!_infoTextField) {
        _infoTextField = [[UITextField alloc]init];
        _infoTextField.placeholder = self.placeHolder;
        _infoTextField.backgroundColor = [UIColor whiteColor];
        [_infoTextField setValue:CHINESE_SYSTEM(15) forKeyPath:@"_placeholderLabel.font"];
//        [_infoTextField setEnabled:NO];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick)];
        [_infoTextField addGestureRecognizer:tap];
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
