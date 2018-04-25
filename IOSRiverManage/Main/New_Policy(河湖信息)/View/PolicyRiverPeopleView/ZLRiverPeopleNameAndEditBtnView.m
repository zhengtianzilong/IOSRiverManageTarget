//
//  ZLRiverPeopleNameAndEditBtnView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverPeopleNameAndEditBtnView.h"
@interface ZLRiverPeopleNameAndEditBtnView ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSString *name;;
@end
@implementation ZLRiverPeopleNameAndEditBtnView

-(instancetype)initWithFrame:(CGRect)frame WithName:(NSString *)name
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _name = name;
        
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.nameLable];
//    [self addSubview:self.editBtn];
    
    [self addSubview:self.lineView];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10);
        //        make.width.mas_equalTo(150);
        make.top.equalTo(self).offset(10);
        make.height.mas_equalTo(25);
        //        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    //    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.right.equalTo(self.mas_right).offset(-10);
    //        make.top.equalTo(self).offset(10);
    //        make.height.mas_equalTo(20);
    //        make.width.mas_equalTo(20);
    //    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
    }];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];

}

- (UILabel *)nameLable{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLable.text = _name;
        _nameLable.font = Font(16);
        _nameLable.textColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    }
    return _nameLable;
}

- (UIView *)lineView{
    if (!_lineView) {
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    }
    return _lineView;
}

//
//- (UIButton *)editBtn{
//    if (!_editBtn) {
//        _editBtn = [[UIButton alloc]initWithFrame:CGRectZero];
//        [_editBtn setBackgroundImage:[UIImage imageNamed:@"info_edit"] forState:UIControlStateNormal];
//    }
//    return _editBtn;
//}
@end
