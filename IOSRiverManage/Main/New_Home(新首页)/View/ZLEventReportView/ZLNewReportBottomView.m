//
//  ZLNewReportBottomView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/17.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewReportBottomView.h"
#import "UIView+RoundedCorner.h"
@interface ZLNewReportBottomView()

@property (nonatomic, strong) NSArray *titles;


@end

@implementation ZLNewReportBottomView

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor whiteColor];
        self.titles = titles;
        [self setUpUI];
        
    }
    return self;
}

- (void)setUpUI{
    
   
    [self addSubview:self.saveButton];
    [self addSubview:self.reportButton];
//    [self addSubview:self.deleteButton];
    
    [self.reportButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(10);
        make.width.mas_equalTo(152 * kScreenWidthRatio);
        make.height.mas_equalTo(44 * kScreenHeightRatio);
        make.centerY.equalTo(self);
        
       
    }];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_centerX).offset(-10);
        make.width.mas_equalTo(152 * kScreenWidthRatio);
        make.height.mas_equalTo(44 * kScreenHeightRatio);
        make.centerY.equalTo(self);
        
    }];
    
//    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.reportButton.mas_right).offset(15);
//        make.width.equalTo(self.reportButton);
//        make.height.equalTo(self.reportButton);
//        make.centerY.equalTo(self);
//
//    }];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.saveButton jm_setCornerRadius:5 withBackgroundColor:HEXCOLOR(CNAVGATIONBAR_COLOR)];
    [self.reportButton jm_setCornerRadius:5 withBackgroundColor:HEXCOLOR(0xf29503)];
//    [self.deleteButton jm_setCornerRadius:5 withBackgroundColor:[UIColor whiteColor]];
}


- (UIButton *)saveButton{
    
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_saveButton setTitle:_titles[0] forState:(UIControlStateNormal)];
        [_saveButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
//        _saveButton.backgroundColor = HEXCOLOR(KNavBarBG_color_blue);
//        _saveButton.layer.cornerRadius = 5;
//        _saveButton.clipsToBounds = YES;
        _saveButton.titleLabel.font = CHINESE_SYSTEM(14);
        _saveButton.adjustsImageWhenHighlighted = NO;
    }
    return _saveButton;
    
}

- (UIButton *)reportButton{
    
    if (!_reportButton) {
        _reportButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_reportButton setTitle:_titles[1] forState:(UIControlStateNormal)];
        [_reportButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        //        _saveButton.backgroundColor = HEXCOLOR(KNavBarBG_color_blue);
        //        _saveButton.layer.cornerRadius = 5;
        //        _saveButton.clipsToBounds = YES;
        _reportButton.titleLabel.font = CHINESE_SYSTEM(14);
        _reportButton.adjustsImageWhenHighlighted = NO;
    }
    return _reportButton;
    
}

//- (UIButton *)deleteButton{
//
//    if (!_deleteButton) {
//        _deleteButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        [_deleteButton setTitle:_titles[2] forState:(UIControlStateNormal)];
//        [_deleteButton setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
//        //        _saveButton.backgroundColor = HEXCOLOR(KNavBarBG_color_blue);
//        //        _saveButton.layer.cornerRadius = 5;
//        //        _saveButton.clipsToBounds = YES;
//        _deleteButton.titleLabel.font = AdaptedFontSize(24);
//        _deleteButton.adjustsImageWhenHighlighted = NO;
//    }
//    return _deleteButton;
//
//}

@end
