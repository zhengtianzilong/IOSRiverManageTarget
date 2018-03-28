//
//  ZLPolicyRiverInfoView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLPolicyRiverInfoView.h"

@interface ZLPolicyRiverInfoView ()

@property (nonatomic, strong) UILabel *riverLable;



@end


@implementation ZLPolicyRiverInfoView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.riverLable];
    [self addSubview:self.watchAllButton];
    
    [self.riverLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(AdaptedWidth(10));
        make.width.mas_equalTo(150);
        make.top.equalTo(self);
        make.height.mas_equalTo(30);
        
    }];
    
    [self.watchAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-5);
        make.top.equalTo(self).offset(5);
        make.height.mas_equalTo(AdaptedHeight(40));
        make.width.mas_equalTo(120);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    
    
    
}


- (void)layoutSubviews{
    [super layoutSubviews];

}

- (UILabel *)riverLable{
    if (!_riverLable) {
        _riverLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _riverLable.text = @"河道水质信息";
        _riverLable.font = SYSTEMFONT(18);
    }
    return _riverLable;
}

- (UIButton *)watchAllButton{
    if (!_watchAllButton) {
        _watchAllButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_watchAllButton setTitle:@"查看所有河道" forState:(UIControlStateNormal)];
        
        [_watchAllButton setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
        
        _watchAllButton.layer.borderColor = HEXCOLOR(CNAVGATIONBAR_COLOR).CGColor;
        _watchAllButton.layer.borderWidth = 1;
        _watchAllButton.layer.masksToBounds = YES;
        _watchAllButton.layer.cornerRadius = 3;
        _watchAllButton.titleLabel.font = SYSTEMFONT(15);
    }
    return _watchAllButton;
}



@end
