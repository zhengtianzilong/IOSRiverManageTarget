//
//  ZLPolicyRiverCategoryView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLPolicyRiverCategoryView.h"

@interface ZLPolicyRiverCategoryView ()

@end

@implementation ZLPolicyRiverCategoryView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.riverInfoButton];
    [self addSubview:self.riverInfoImageV];
    
    [self.riverInfoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(AdaptedWidth(40));
        make.left.equalTo(self).offset(AdaptedWidth(10));
        make.right.equalTo(self.mas_right).offset(-AdaptedHeight(10));
        make.top.equalTo(self).offset(5);
    }];
    
    [self.riverInfoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.riverInfoImageV.mas_right);
        make.top.equalTo(self.riverInfoImageV.mas_bottom).offset(0);
        make.height.mas_equalTo(AdaptedHeight(40));
        make.width.mas_equalTo(115);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];


    
    
    
}

- (UIImageView *)riverInfoImageV{
    if (!_riverInfoImageV) {
        _riverInfoImageV = [[UIImageView alloc]initWithFrame:CGRectZero];
        _riverInfoImageV.image = [UIImage imageNamed:@"home_riverLevel"];
        _riverInfoImageV.userInteractionEnabled = YES;
    }
    return _riverInfoImageV;
}

- (UIButton *)riverInfoButton{
    if (!_riverInfoButton) {
        _riverInfoButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_riverInfoButton setTitle:@"水质类别说明" forState:(UIControlStateNormal)];
        
        [_riverInfoButton setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
        
        _riverInfoButton.titleLabel.font = Font(12);
        [_riverInfoButton setImage:[UIImage imageNamed:@"home_riverQuality"] forState:(UIControlStateNormal)];
        [_riverInfoButton setImagePosition:(LXMImagePositionLeft) spacing:5];
        
        _riverInfoButton.adjustsImageWhenHighlighted = NO;
        
        
    }
    return _riverInfoButton;
}




@end
