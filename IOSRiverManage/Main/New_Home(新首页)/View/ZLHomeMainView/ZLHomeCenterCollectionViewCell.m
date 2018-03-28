//
//  ZLHomeCenterCollectionViewCell.m
//  HongZeHaiShi
//
//  Created by 蔡紫龙 on 2018/1/17.
//  Copyright © 2018年 xgzl. All rights reserved.
//

#import "ZLHomeCenterCollectionViewCell.h"

@interface ZLHomeCenterCollectionViewCell ()

@end

@implementation ZLHomeCenterCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        
    }
    return self;
    
}

- (void)setupUI{
    
    [self.contentView addSubview:self.customBtn];
    [self.contentView addSubview:self.tipBtn];
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self.customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.contentView);
        make.height.equalTo(self.contentView);
        make.width.equalTo(self.contentView);
        
    }];
    
    [self.customBtn setImagePosition:LXMImagePositionTop spacing:5];
    
    [self.tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView);
        make.width.equalTo(self.contentView).multipliedBy(0.25);
        make.height.equalTo(self.contentView).multipliedBy(0.25);
        
    }];
    

}

-(void)setModel:(ZLHomeCenterCollectionModel *)model{
    
    if (nil != model) {
        _model = model;
        
        [_customBtn setTitle:self.model.title forState:(UIControlStateNormal)];
        [_customBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_customBtn setImage:[UIImage imageNamed:self.model.imageTitle] forState:(UIControlStateNormal)];
    }
    
    
    
    
}


#pragma mark -- 懒加载
- (UIButton *)customBtn{
    
    if (!_customBtn)
    {
        _customBtn = [[UIButton alloc]init];
        //        [_customBtn setTitle:@"我的任务" forState:(UIControlStateNormal)];
        [_customBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _customBtn.titleLabel.font = CHINESE_SYSTEM(14);
        _customBtn.userInteractionEnabled = NO;
        //        [_customBtn setImage:[UIImage imageNamed:@"day_rivers_total"] forState:(UIControlStateNormal)];
        
    }
    return _customBtn;
    
}

- (UIButton *)tipBtn{
    if (!_tipBtn) {
        
        _tipBtn = [[UIButton alloc]init];
        
        [_tipBtn setTitle:@"500" forState:(UIControlStateNormal)];
        _tipBtn.titleLabel.font = CHINESE_SYSTEM(14);
        _tipBtn.hidden = YES;
        [_tipBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _tipBtn.backgroundColor = [UIColor redColor];
        
    }
    return _tipBtn;
    
}


@end
