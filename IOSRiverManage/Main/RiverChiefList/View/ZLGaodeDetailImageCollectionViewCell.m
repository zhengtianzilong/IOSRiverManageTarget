//
//  ZLGaodeDetailImageCollectionViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/27.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLGaodeDetailImageCollectionViewCell.h"

@implementation ZLGaodeDetailImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUpView];
        
    }
    return self;
    
}

- (void)setUpView{
    
    [self.contentView addSubview:self.imageView];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = [UIColor blueColor];
    }
    return _imageView;
}

@end
