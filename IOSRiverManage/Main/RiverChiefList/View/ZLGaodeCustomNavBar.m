//
//  ZLGaodeCustomNavBar.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/11.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLGaodeCustomNavBar.h"

@implementation ZLGaodeCustomNavBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
//        [self setBackgroundColor:HEXCOLOR(CNAVGATIONBAR_COLOR)];
//
//        // 创建一个导航栏
//        UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 44, frame.size.width, TopBarHeight)];
//        // 导航栏背景颜色
//        navBar.barTintColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
//
//        // 自定义导航栏的title，用UILabel实现
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 50, TopBarHeight)];
//        _titleLabel.text = @"自定义";
//        _titleLabel.textColor = [UIColor whiteColor];
//        _titleLabel.font = [UIFont systemFontOfSize:18];
//
//        // 创建导航栏组件
//        UINavigationItem *navItem = [[UINavigationItem alloc] init];
//        // 设置自定义的title
//        navItem.titleView = _titleLabel;
//
//        // 创建左侧按钮
//
//        UIImage* backItemImage = [UIImage imageNamed:@"nav_left"];
//
//        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 44, 30, 30)];
//        [_backButton setImage:backItemImage forState:(UIControlStateNormal)];
//
//        _leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
//
//        // 添加左侧、右侧按钮
//        [navItem setLeftBarButtonItem:_leftButton animated:false];
//        // 把导航栏组件加入导航栏
//        [navBar pushNavigationItem:navItem animated:false];
//
//        // 导航栏添加到view上
//        [self addSubview:navBar];
        
        [self setupUI];
    }
    return self;
    
    
}

- (void)setupUI{
    [self addSubview:self.backButton];
    [self addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(Main_Screen_Width / 3);
    }];
    
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        
        make.centerY.equalTo(self.titleLabel);
        
        make.left.equalTo(self).offset(16);
    }];
    

    
}

- (UIButton *)backButton{
    
    if (!_backButton) {
        _backButton = [[UIButton alloc]init];
        [_backButton setImage:[UIImage imageNamed:@"nav_left"] forState:(UIControlStateNormal)];
    }
    return _backButton;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = AdaptedFontBoldSize(26);
        
//        _titleLabel.backgroundColor = [UIColor redColor];
    }
    return _titleLabel;
}

@end
