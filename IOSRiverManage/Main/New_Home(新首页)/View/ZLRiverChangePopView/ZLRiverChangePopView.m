//
//  ZLRiverChangePopView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/7.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverChangePopView.h"

@interface ZLRiverChangePopView()

@property (nonatomic, strong) UIView *maskView;

@end

@implementation ZLRiverChangePopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //        self.alpha = 0.8;
        [self setUpUI];
        
    }
    return self;
}

- (void)setUpUI{
    
    [self addSubview:self.maskView];
    
    [self addSubview:self.collectionView];
    
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10);
        
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_centerY);
        
        make.height.mas_equalTo(((Main_Screen_Width - 20) / 3 / 1.5 ) + 40);
    }];

}

- (ZLRiverChangeCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[ZLRiverChangeCollectionView alloc]init];
    }
    return _collectionView;
}

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:self.bounds];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}


- (void)tapClick:(UIGestureRecognizer *)ges{
    
//    CGPoint point = [ges locationInView:self];
//
//    BOOL isTouch = CGRectContainsPoint(self.collectionView.frame, point);
//
//    if (!isTouch) {
//
//
//    }
    [self dismissView];
}

- (void)dismissView{
    [self removeFromSuperview];
}

@end
