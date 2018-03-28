//
//  ZLQueryEventManageView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/17.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLQueryEventManageView.h"
#import "UIView+RoundedCorner.h"
@implementation ZLQueryEventManageView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        [self addSubview:self.selectInfoView];
        [self addSubview:self.queryButton];
        [self.selectInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right).offset(0);
            make.top.equalTo(self).offset(10);
            //        make.height.mas_equalTo(40);
        }];
        

        [self.queryButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self);
            make.top.equalTo(self.selectInfoView.mas_bottom).offset(20);
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

- (ZLEventManagerSelectInfoView *)selectInfoView{
    if (!_selectInfoView) {
        _selectInfoView = [[ZLEventManagerSelectInfoView alloc]init];
    }
    return _selectInfoView;
}
- (UIButton *)queryButton{
    if (!_queryButton) {
        _queryButton = [[UIButton alloc]init];
        //        _queryButton.backgroundColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
        
        [_queryButton setTitle:@"查询" forState:(UIControlStateNormal)];
        
    }
    return _queryButton;
    
}

@end
