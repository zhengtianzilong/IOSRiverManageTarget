//
//  ZLPolicyAllRiverHeadView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/5.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLPolicyAllRiverHeadView.h"

@implementation ZLPolicyAllRiverHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    
    [self addSubview:self.searchBar];
    [self addSubview:self.mainCollectionView];

}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(40);
        
        make.top.equalTo(self).offset(10);
        
    }];
    
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(150);
        make.top.equalTo(self.searchBar.mas_bottom).offset(15);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
    
    
    
}

- (ZLSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [ZLSearchBar searchBar];
//        _searchBar.frame = CGRectMake(10, 10, Main_Screen_Width - 20, 40);
        self.searchBar.returnKeyType = UIReturnKeySearch;
//        self.searchBar.delegate = self;
    }
    return _searchBar;
}

- (ZLPolicyAllRiverCollectionView *)mainCollectionView{
    
    if (!_mainCollectionView) {
        _mainCollectionView = [[ZLPolicyAllRiverCollectionView alloc]initWithFrame:CGRectZero];
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _mainCollectionView;
    
}


@end
