//
//  ZLBaiduBottomButtonView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/20.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLBaiduBottomButtonView.h"

@implementation ZLBaiduBottomButtonView

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
    
    self.startButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.startButton setTitle:@"开始巡河" forState:(UIControlStateNormal)];
    [self.startButton setImage:[UIImage imageNamed:@"river_start"] forState:(UIControlStateNormal)];
    [self.startButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.startButton.backgroundColor = HEXCOLOR(KNavBarBG_color_blue);
    self.startButton.layer.cornerRadius = 5;
    self.startButton.clipsToBounds = YES;
    self.startButton.titleLabel.font = AdaptedFontSize(24);
    self.startButton.adjustsImageWhenHighlighted = NO;
    [self addSubview:self.startButton];
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.mas_centerX).offset(-10);
        make.width.mas_equalTo(152 * kScreenWidthRatio);
        make.height.mas_equalTo(44 * kScreenHeightRatio);
        make.centerY.equalTo(self);
        
    }];
    
    [self.startButton setImagePosition:(LXMImagePositionLeft) spacing:10];
    
    self.endButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.endButton setTitle:@"结束巡河" forState:(UIControlStateNormal)];
    [self.endButton setImage:[UIImage imageNamed:@"river_end"] forState:(UIControlStateNormal)];
    [self.endButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self addSubview:self.endButton];
    self.endButton.layer.cornerRadius = 5;
    self.endButton.clipsToBounds = YES;
    self.endButton.backgroundColor = HEXCOLOR(0xf29503);
    self.endButton.titleLabel.font = AdaptedFontSize(24);
    self.endButton.adjustsImageWhenHighlighted = NO;

    [self.endButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(10);
        make.width.mas_equalTo(152 * kScreenWidthRatio);
        make.height.mas_equalTo(44 * kScreenHeightRatio);
        make.centerY.equalTo(self);
        
    }];
    [self.endButton setImagePosition:(LXMImagePositionLeft) spacing:10];
    
}

@end
