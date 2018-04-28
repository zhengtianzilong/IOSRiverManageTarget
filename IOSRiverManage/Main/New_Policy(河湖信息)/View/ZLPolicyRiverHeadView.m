//
//  ZLPolicyRiverHeadView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/5.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLPolicyRiverHeadView.h"

@implementation ZLPolicyRiverHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.loopTopView];
    [self addSubview:self.riverCategoryView];
    [self addSubview:self.riverInfoView];
    
    [self.loopTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(0);
        make.width.mas_equalTo(Main_Screen_Width);
        make.height.mas_equalTo(Main_Screen_Width / 2.0 - 10);
    }];
    
    [self.riverCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.loopTopView.mas_bottom);
        make.width.mas_equalTo(Main_Screen_Width);
        //        make.height.mas_equalTo(AdaptedHeight(225));
    }];
    
    
    
    [self.riverInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.riverCategoryView.mas_bottom);
        make.width.mas_equalTo(Main_Screen_Width);
        make.bottom.equalTo(self.mas_bottom);
        //        make.height.mas_equalTo(AdaptedHeight(225));
    }];
}


- (void)layoutSubviews{
    [super layoutSubviews];

    
    
    
}

- (ZLHomeLoopTopView *)loopTopView{
    
    if (!_loopTopView) {
        
        _loopTopView = [[ZLHomeLoopTopView alloc]init];
        
        
    }
    return _loopTopView;
    
}

- (ZLPolicyRiverCategoryView *)riverCategoryView{
    
    if (!_riverCategoryView) {
        
        _riverCategoryView = [[ZLPolicyRiverCategoryView alloc]init];
        
    }
    return _riverCategoryView;
    
}

- (ZLPolicyRiverInfoView *)riverInfoView{
    
    if (!_riverInfoView) {
        
        _riverInfoView = [[ZLPolicyRiverInfoView alloc]init];

        
    }
    return _riverInfoView;
    
}

@end
