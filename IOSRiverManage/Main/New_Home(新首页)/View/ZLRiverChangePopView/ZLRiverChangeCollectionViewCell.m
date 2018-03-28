//
//  ZLRiverChangeCollectionViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/8.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverChangeCollectionViewCell.h"

@interface ZLRiverChangeCollectionViewCell ()

@property (nonatomic, strong) UIView *vertLineView;

@property (nonatomic, strong) UIView *horLineView;

@end
@implementation ZLRiverChangeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        
    }
    return self;
    
}

- (void)setupUI{
    
    
//    [self.contentView addSubview:self.tipBtn];
    
    [self.contentView addSubview:self.horLineView];
    [self.contentView addSubview:self.vertLineView];
    [self.contentView addSubview:self.customBtn];
    
    [self.vertLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.mas_equalTo(1);
        
    }];
    
    [self.horLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right);
        make.left.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(1);
        
    }];
    
    [self.customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.center.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.horLineView.mas_top);
        //        make.height.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.vertLineView.mas_left);
        //        make.width.equalTo(self.contentView);
        
    }];
    
    
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    

    
    [self.customBtn setImagePosition:LXMImagePositionTop spacing:5];
    
//    [self.tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(self.contentView.mas_right);
//        make.top.equalTo(self.contentView);
//        make.width.equalTo(self.contentView).multipliedBy(0.25);
//        make.height.equalTo(self.contentView).multipliedBy(0.25);
//
//    }];
//
    
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
        
//        [_customBtn addTarget:self action:@selector(customBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        //        [_customBtn setImage:[UIImage imageNamed:@"day_rivers_total"] forState:(UIControlStateNormal)];
        
    }
    return _customBtn;
    
}

//- (void)customBtnClick{
//
//
//
//}


//- (UIButton *)tipBtn{
//    if (!_tipBtn) {
//
//        _tipBtn = [[UIButton alloc]init];
//
//        [_tipBtn setTitle:@"500" forState:(UIControlStateNormal)];
//        _tipBtn.titleLabel.font = CHINESE_SYSTEM(14);
//        [_tipBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
//        _tipBtn.backgroundColor = [UIColor redColor];
//
//    }
//    return _tipBtn;
//}

- (UIView *)vertLineView{
    if (!_vertLineView) {
        _vertLineView = [[UIView alloc]init];
        _vertLineView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    }
    return _vertLineView;
}
- (UIView *)horLineView{
    if (!_horLineView) {
        _horLineView = [[UIView alloc]init];
        _horLineView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    }
    return _horLineView;
}
@end
