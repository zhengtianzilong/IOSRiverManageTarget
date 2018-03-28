//
//  ZLRiverBaseInfoView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverBaseInfoView.h"

@interface ZLRiverBaseInfoView ()

@end
@implementation ZLRiverBaseInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.loopTopView];
        
        [self addSubview:self.centerInfoView];
        [self addSubview:self.billboardView];
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.loopTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(0);
        make.width.mas_equalTo(Main_Screen_Width);
//        make.height.mas_equalTo(AdaptedHeight(220));
    }];
    
    
    [self.centerInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.loopTopView.mas_bottom).offset(10);
        make.width.mas_equalTo(Main_Screen_Width);
        //        make.height.mas_equalTo(AdaptedHeight(280));
    }];
    
    [self.billboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.centerInfoView.mas_bottom).offset(10);
        make.width.mas_equalTo(Main_Screen_Width);
        
        make.bottom.equalTo(self.mas_bottom);
        
        //        make.height.mas_equalTo(AdaptedHeight(280));
    }];
}


- (ZLHomeLoopTopView *)loopTopView{
    
    if (!_loopTopView) {
        
        _loopTopView = [[ZLHomeLoopTopView alloc]init];
        
        
    }
    return _loopTopView;
    
}

- (ZLRiverInfoBaseView *)centerInfoView{
    
    if (!_centerInfoView) {
        
        _centerInfoView = [[ZLRiverInfoBaseView alloc]init];
        
        
    }
    return _centerInfoView;
    
}


- (ZLBillboardInfoView *)billboardView{
    
    if (!_billboardView) {
        _billboardView = [[ZLBillboardInfoView alloc]init];
    }
    return _billboardView;
    
}

@end
