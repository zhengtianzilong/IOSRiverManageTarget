//
//  ZLPolicyALlRiverCollectionViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLPolicyALlRiverCollectionViewCell.h"

@interface ZLPolicyALlRiverCollectionViewCell ()

@end

@implementation ZLPolicyALlRiverCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        
    }
    return self;
    
}

- (void)setupUI{
    
    [self.contentView addSubview:self.titleButton];
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
}

- (void)setAreaModel:(ZLPolicyAllRiverAreaModel *)areaModel{
    
    _areaModel = areaModel;
    
    [_titleButton setTitle:areaModel.title forState:(UIControlStateNormal)];
    
    _titleButton.selected = areaModel.isSelect;

}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.contentView);
        make.height.mas_equalTo(25 );
        make.width.equalTo(self.contentView).multipliedBy(0.7);
        
    }];
    

    
    
}

- (UIImage*)createImageWithColor:(UIColor*)color{
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context= UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


#pragma mark -- 懒加载
- (UIButton *)titleButton{
    
    if (!_titleButton)
    {
        _titleButton = [[UIButton alloc]init];
//        [_customBtn setTitle:@"我的任务" forState:(UIControlStateNormal)];
        _titleButton.titleLabel.font = CHINESE_SYSTEM(14);
        _titleButton.userInteractionEnabled = NO;
        [_titleButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_titleButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];

        [_titleButton setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
        [_titleButton setBackgroundImage:[self createImageWithColor:HEXCOLOR(CNAVGATIONBAR_COLOR)] forState:(UIControlStateSelected)];
//        _titleButton.font = CHINESE_SYSTEM(15);
        
//        _titleButton.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleButton;
    
}


@end
