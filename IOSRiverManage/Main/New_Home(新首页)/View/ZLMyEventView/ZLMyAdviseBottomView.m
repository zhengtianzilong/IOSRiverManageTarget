//
//  ZLMyAdviseBottomView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyAdviseBottomView.h"

@implementation ZLMyAdviseBottomView

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        self.titles = titles;
        
        [self setUpUI];
    }
    return self;
}

- (void)setStartButtonHidden:(BOOL)ishidden{
    
    if (ishidden) {
        
        self.startButton.hidden = ishidden;
        [self.startButton removeFromSuperview];
        
        [self.endButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
//            make.width.mas_equalTo(152 * kScreenWidthRatio);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.mas_equalTo(44 * kScreenHeightRatio);
            make.centerY.equalTo(self);
            
        }];
        
        
    }
    
}
- (void)setendButtonHidden:(BOOL)ishidden{
    
    if (ishidden) {
        
        self.endButton.hidden = ishidden;
        [self.endButton removeFromSuperview];
        
        [self.startButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            //            make.width.mas_equalTo(152 * kScreenWidthRatio);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.mas_equalTo(44 * kScreenHeightRatio);
            make.centerY.equalTo(self);
            
        }];
        
        
    }

    
}

- (void)setUpUI{
    
    self.startButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.startButton setTitle:_titles[0] forState:(UIControlStateNormal)];
    [self.startButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.startButton.backgroundColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    self.startButton.layer.cornerRadius = 5;
    self.startButton.clipsToBounds = YES;
    self.startButton.titleLabel.font = CHINESE_SYSTEM(14);
    self.startButton.adjustsImageWhenHighlighted = NO;
    [self addSubview:self.startButton];
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_centerX).offset(-10);
        make.width.mas_equalTo(152 * kScreenWidthRatio);
        make.height.mas_equalTo(44 * kScreenHeightRatio);
        make.centerY.equalTo(self);
        
    }];
    
    
    self.endButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.endButton setTitle:_titles[1] forState:(UIControlStateNormal)];
    [self.endButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self addSubview:self.endButton];
    self.endButton.layer.cornerRadius = 5;
    self.endButton.clipsToBounds = YES;
    self.endButton.backgroundColor = HEXCOLOR(0xf29503);
    self.endButton.titleLabel.font = CHINESE_SYSTEM(14);
    self.endButton.adjustsImageWhenHighlighted = NO;
    
    [self.endButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(10);
        make.width.mas_equalTo(152 * kScreenWidthRatio);
        make.height.mas_equalTo(44 * kScreenHeightRatio);
        make.centerY.equalTo(self);
        
    }];
    
}
@end
