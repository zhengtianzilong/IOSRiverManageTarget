//
//  ZLBaiduReportBottomView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/21.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLBaiduReportBottomView.h"

@implementation ZLBaiduReportBottomView

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
    
    self.startReportButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.startReportButton setTitle:@"立即上报" forState:(UIControlStateNormal)];
    [self.startReportButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.startReportButton.backgroundColor = HEXCOLOR(KNavBarBG_color_blue);
    self.startReportButton.layer.cornerRadius = 5;
    self.startReportButton.clipsToBounds = YES;
    self.startReportButton.adjustsImageWhenHighlighted = NO;
    self.startReportButton.titleLabel.font = AdaptedFontSize(24);
    [self addSubview:self.startReportButton];
    [self.startReportButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_centerX).offset(-10);
        make.width.mas_equalTo(152 * kScreenWidthRatio);
        make.height.mas_equalTo(44 * kScreenHeightRatio);
        make.centerY.equalTo(self);
        
    }];
    
    self.endReportButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.endReportButton setTitle:@"取消上报" forState:(UIControlStateNormal)];
    [self.endReportButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self addSubview:self.endReportButton];
    self.endReportButton.layer.cornerRadius = 5;
    self.endReportButton.clipsToBounds = YES;
    self.endReportButton.backgroundColor = HEXCOLOR(0xf29503);
    self.endReportButton.adjustsImageWhenHighlighted = NO;
    self.endReportButton.titleLabel.font = AdaptedFontSize(24);
    
    [self.endReportButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(10);
        make.width.mas_equalTo(152 * kScreenWidthRatio);
        make.height.mas_equalTo(44 * kScreenHeightRatio);
        make.centerY.equalTo(self);
        
    }];
}

@end
