//
//  ZLGaodeBottomView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/5.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLGaodeBottomView.h"

@implementation ZLGaodeBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.startAndEndButton];
    
    [self addSubview:self.reportButton];
    [self addSubview:self.downTaskButton];
    [self.reportButton setImagePosition:(LXMImagePositionLeft) spacing:1];
    [self.downTaskButton setImagePosition:(LXMImagePositionLeft) spacing:1];
    [self.startAndEndButton setImagePosition:(LXMImagePositionLeft) spacing:10];
    

    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.startAndEndButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-15);
        make.width.mas_equalTo(152 * kScreenWidthRatio);
        make.height.mas_equalTo(44 * kScreenHeightRatio);
        make.centerY.equalTo(self);
        
    }];
    
    [self.reportButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.width.mas_equalTo(85 * kScreenWidthRatio);
        make.height.mas_equalTo(44 * kScreenHeightRatio);
        make.centerY.equalTo(self);
    }];
    
    [self.downTaskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.reportButton.mas_right).offset(10);
        make.width.mas_equalTo(85 * kScreenWidthRatio);
        make.height.mas_equalTo(44 * kScreenHeightRatio);
        make.centerY.equalTo(self);
        
    }];
    
}


- (UIButton *)startAndEndButton{
    if (!_startAndEndButton) {
        _startAndEndButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
//#if WanApp
         [_startAndEndButton setTitle:S_StartRiverInfo forState:(UIControlStateNormal)];
//#else
//         [_startAndEndButton setTitle:@"开始巡河" forState:(UIControlStateNormal)];
//#endif
        
       
        [_startAndEndButton setImage:[UIImage imageNamed:@"GaodeStartRiver"] forState:(UIControlStateNormal)];
        
//        [_startAndEndButton setTitle:@"结束巡河" forState:(UIControlStateSelected)];
//        [_startAndEndButton setImage:[UIImage imageNamed:@"river_end"] forState:(UIControlStateSelected)];
        [_startAndEndButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _startAndEndButton.backgroundColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
        _startAndEndButton.layer.cornerRadius = 5;
        _startAndEndButton.clipsToBounds = YES;
        _startAndEndButton.titleLabel.font = CHINESE_SYSTEM(14);
        _startAndEndButton.adjustsImageWhenHighlighted = NO;
    }
    return _startAndEndButton;
}

- (UIButton *)downTaskButton{
    if (!_downTaskButton) {
        
        _downTaskButton = [[UIButton alloc]init];
        [_downTaskButton setTitle:@"下发" forState:(UIControlStateNormal)];
        [_downTaskButton setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
        [_downTaskButton setImage:[UIImage imageNamed:@"GaodeDownSelected"] forState:UIControlStateNormal];
//        [_downTaskButton setImage:[UIImage imageNamed:@"GaodeDownSelected"] forState:UIControlStateSelected];
//        _downTaskButton.backgroundColor = HEXCOLOR(KNavBarBG_color_blue);
        _downTaskButton.layer.cornerRadius = 5;
        
        _downTaskButton.layer.borderColor = HEXCOLOR(CNAVGATIONBAR_COLOR).CGColor;
        _downTaskButton.layer.borderWidth = 1;
        _downTaskButton.clipsToBounds = YES;
        _downTaskButton.titleLabel.font = CHINESE_SYSTEM(14);
        _downTaskButton.adjustsImageWhenHighlighted = NO;
    }
    return _downTaskButton;
}

- (UIButton *)reportButton{
    
    if (!_reportButton) {
        _reportButton = [[UIButton alloc]init];
        [_reportButton setTitle:@"上报" forState:(UIControlStateNormal)];
        [_reportButton setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
        [_reportButton setImage:[UIImage imageNamed:@"GaodeReportSelected"] forState:UIControlStateNormal];
//        [_reportButton setImage:[UIImage imageNamed:@"GaodeReportSelected"] forState:UIControlStateSelected];
//        _reportButton.backgroundColor = HEXCOLOR(KNavBarBG_color_blue);
        _reportButton.layer.cornerRadius = 5;
        _reportButton.layer.borderColor = HEXCOLOR(CNAVGATIONBAR_COLOR).CGColor;
        _reportButton.layer.borderWidth = 1;
        _reportButton.clipsToBounds = YES;
        _reportButton.titleLabel.font = CHINESE_SYSTEM(14);
        _reportButton.adjustsImageWhenHighlighted = NO;
        
        
    }
    return _reportButton;
    
}


@end
