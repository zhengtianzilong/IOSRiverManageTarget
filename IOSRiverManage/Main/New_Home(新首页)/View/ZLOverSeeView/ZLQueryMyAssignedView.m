//
//  ZLQueryMyAssignedView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/8.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLQueryMyAssignedView.h"

@implementation ZLQueryMyAssignedView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        [self addSubview:self.selectInfoView];
        [self addSubview:self.queryButton];
        [self.selectInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right).offset(0);
            make.top.equalTo(self).offset(10);
        }];
        [self.queryButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self);
            make.top.equalTo(self.selectInfoView.mas_bottom).offset(10);
            make.height.mas_equalTo(40);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.queryButton jm_setCornerRadius:6 withBackgroundColor:HEXCOLOR(CNAVGATIONBAR_COLOR)];
    
    
}


- (ZLMyAssignedSelectInfoView *)selectInfoView{
    if (!_selectInfoView) {
        _selectInfoView = [[ZLMyAssignedSelectInfoView alloc]init];
        
    }
    return _selectInfoView;
}

- (UIButton *)queryButton{
    if (!_queryButton) {
        _queryButton = [[UIButton alloc]init];
        [_queryButton setTitle:@"查询" forState:(UIControlStateNormal)];
        
    }
    return _queryButton;
    
}
@end
