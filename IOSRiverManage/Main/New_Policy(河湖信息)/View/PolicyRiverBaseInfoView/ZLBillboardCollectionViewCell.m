//
//  ZLBillboardCollectionViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBillboardCollectionViewCell.h"

@implementation ZLBillboardCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupUI];
        
    }
    return self;
    
}

- (void)setupUI{
    
    [self.contentView addSubview:self.imageV];
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.contentView);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
//        make.height.equalTo(self.contentView);
        make.width.equalTo(self.contentView);
        
    }];
    
    
    
    
}


#pragma mark -- 懒加载
- (UIImageView *)imageV{
    
    if (!_imageV)
    {
        _imageV = [[UIImageView alloc]init];
        _imageV.backgroundColor = [UIColor redColor];
        
    }
    return _imageV;
    
}
@end
