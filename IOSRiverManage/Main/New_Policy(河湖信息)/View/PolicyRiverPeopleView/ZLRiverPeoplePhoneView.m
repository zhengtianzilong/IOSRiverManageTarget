//
//  ZLRiverPeoplePhoneView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverPeoplePhoneView.h"

@interface ZLRiverPeoplePhoneView ()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *verticLineView;

@end


@implementation ZLRiverPeoplePhoneView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}



- (void)setupUI{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.nameLable];
    [self.contentView addSubview:self.phoneBtn];
}

- (void)setDataModel:(ZLRIverPeopleDataModel *)dataModel{
    
    _dataModel = dataModel;
    
    _titleLabel.text = _dataModel.dutyName;
    
    _nameLable.text = _dataModel.realName;
    
    
}

- (void)setLowerModel:(ZLRiverPeopleLowerModel *)lowerModel{
    
    _lowerModel = lowerModel;
    
    _titleLabel.text = _lowerModel.duty;
    
    _nameLable.text = _lowerModel.realName;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(100);
//        make.top.equalTo(self.contentView).offset(10);
        
        make.centerY.equalTo(self.contentView);
        
        make.height.mas_equalTo(20);
//        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right);
//        make.top.equalTo(self.contentView).offset(5);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel.mas_right).offset(20);
        make.right.equalTo(self.phoneBtn.mas_left);
        make.top.equalTo(self.titleLabel);
        make.height.mas_equalTo(20);
//        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.text = @"区县河长";
        _titleLabel.font = SYSTEMFONT(15);
    }
    return _titleLabel;
}

- (UILabel *)nameLable{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLable.text = @"xxxx";
        _nameLable.font = SYSTEMFONT(15);
    }
    return _nameLable;
}



- (UIButton *)phoneBtn{
    if (!_phoneBtn) {
        _phoneBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_phoneBtn setImage:[UIImage imageNamed:@"phone"] forState:(UIControlStateNormal)];
    }
    return _phoneBtn;
}

@end
