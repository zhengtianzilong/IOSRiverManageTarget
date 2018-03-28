//
//  ZLMyEventWaitCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/23.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyEventWaitCell.h"
#import "UIView+RoundedCorner.h"
@implementation ZLMyEventWaitCell

- (void)setUpUI{
    [super setUpUI];
    
    [self.contentView addSubview:self.dealBtn];
    
    
    [self.dealBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.lineViewBottom.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(55);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.dealBtn jm_setCornerRadius:0.7 withBackgroundColor:[UIColor whiteColor]];
    //    [self.changeBtn jm_setCornerRadius:0.7 withBackgroundColor:[UIColor whiteColor]];
    
}

- (void)deleteBtnClick{
    
    if (_dealClick) {
        self.dealClick();
    }
    
}

- (UIButton *)dealBtn{
    if (!_dealBtn) {
        _dealBtn = [[UIButton alloc]init];
        [_dealBtn setTitle:@"处理" forState:(UIControlStateNormal)];
        [_dealBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _dealBtn.titleLabel.font = CHINESE_SYSTEM(16);
        _dealBtn.layer.borderWidth = 1;
        _dealBtn.layer.cornerRadius = 5;
        _dealBtn.layer.borderColor = HEXCOLOR(CVIEW_GRAY_COLOR).CGColor;
        _dealBtn.layer.masksToBounds = YES;
        [_dealBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _dealBtn;
}
@end
