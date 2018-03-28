//
//  ZLMyEventCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/1/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyEventCell.h"
#import "UIView+RoundedCorner.h"
@implementation ZLMyEventCell

- (void)setUpUI{
    [super setUpUI];
    
    [self.contentView addSubview:self.changeBtn];
    [self.contentView addSubview:self.deleteBtn];
    
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.lineViewBottom.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(55);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.deleteBtn.mas_left).offset(-5);
        make.top.equalTo(self.deleteBtn);
        make.height.equalTo(self.deleteBtn);
        make.width.equalTo(self.deleteBtn);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.deleteBtn jm_setCornerRadius:0.7 withBackgroundColor:[UIColor whiteColor]];
//    [self.changeBtn jm_setCornerRadius:0.7 withBackgroundColor:[UIColor whiteColor]];
    
}

- (void)deleteBtnClick{
    
    if (_deleteClick) {
        self.deleteClick();
    }
    
}

- (void)changeBtnClick{
    if (_changeClick) {
        self.changeClick();
    }
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc]init];
        [_deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
        [_deleteBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        _deleteBtn.layer.borderWidth = 1;
        _deleteBtn.layer.cornerRadius = 5;
        _deleteBtn.layer.borderColor = HEXCOLOR(CVIEW_GRAY_COLOR).CGColor;
        _deleteBtn.titleLabel.font = CHINESE_SYSTEM(16);
        _deleteBtn.layer.masksToBounds = YES;
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _deleteBtn;
}

- (UIButton *)changeBtn{
    if (!_changeBtn) {
        _changeBtn = [[UIButton alloc]init];
        [_changeBtn setTitle:@"修改" forState:(UIControlStateNormal)];
        [_changeBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        _changeBtn.titleLabel.font = CHINESE_SYSTEM(16);
        _changeBtn.layer.borderWidth = 1;
        _changeBtn.layer.masksToBounds = NO;
        _changeBtn.layer.cornerRadius = 5;
        _changeBtn.layer.borderColor = HEXCOLOR(CVIEW_GRAY_COLOR).CGColor;
        _changeBtn.clipsToBounds = YES;
        
    }
    return _changeBtn;
}


@end
