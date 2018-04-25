//
//  ZLRiverRecordView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/25.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLRiverRecordView.h"
#import "ZLRiverRecordTopView.h"
#import "ZLRiverThreeButton.h"
@interface ZLRiverRecordView ()

@property (nonatomic, strong) ZLRiverRecordTopView *topView;
@property (nonatomic, strong) UIView *topBaseView;

@property (nonatomic, strong) ZLRiverThreeButton *threeButton;

@property (nonatomic, strong) UIButton *queryButton;

@end

@implementation ZLRiverRecordView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor grayColor];
        _topView = [[ZLRiverRecordTopView alloc]init];
        
        _topBaseView = [[UIView alloc]init];
        _topBaseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_topBaseView];
        
        [_topBaseView addSubview:_topView];
        
        [self addSubview:self.threeButton];
        
        [self addSubview:self.queryButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_topBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(80);
        
    }];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_topBaseView);
        make.right.equalTo(_topBaseView.mas_right);
        make.top.equalTo(_topBaseView.mas_top).offset(0);
        make.height.mas_equalTo(80);
        
    }];
    
    [self.threeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(_topBaseView.mas_bottom).offset(20);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(Main_Screen_Width * 3 / 4);
    }];
    
    [self.queryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(self.threeButton.mas_bottom).offset(20);
        make.height.mas_equalTo(55);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
}

- (ZLRiverThreeButton *)threeButton{
    
    if (!_threeButton) {
        _threeButton = [[ZLRiverThreeButton alloc]init];
        
    }
    return _threeButton;
    
}

- (UIButton *)queryButton{
    if (!_queryButton) {
        _queryButton = [[UIButton alloc]init];
        _queryButton.backgroundColor = [UIColor blueColor];
        
        [_queryButton setTitle:@"查询" forState:(UIControlStateNormal)];
        
    }
    return _queryButton;
    
}


@end
