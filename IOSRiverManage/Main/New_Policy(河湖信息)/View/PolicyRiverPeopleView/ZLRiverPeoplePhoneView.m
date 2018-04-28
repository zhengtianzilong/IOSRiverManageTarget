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

@property (nonatomic, strong) NSString *phoneString;

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
    self.phoneString = _dataModel.phone;
    
}

- (void)setLowerModel:(ZLRiverPeopleLowerModel *)lowerModel{
    
    _lowerModel = lowerModel;
    
    _titleLabel.text = _lowerModel.dutyName;
    
    _nameLable.text = _lowerModel.realName;
    self.phoneString = _lowerModel.phone;
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
        _titleLabel.font = Font(13);
    }
    return _titleLabel;
}

- (UILabel *)nameLable{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLable.text = @"xxxx";
        _nameLable.font = Font(13);
    }
    return _nameLable;
}



- (UIButton *)phoneBtn{
    if (!_phoneBtn) {
        _phoneBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_phoneBtn setImage:[UIImage imageNamed:@"phone"] forState:(UIControlStateNormal)];
        [_phoneBtn addTarget:self action:@selector(call) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _phoneBtn;
}

-(void)call{
    if (self.phoneString.length > 0) {
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.phoneString];
        // ZLLog(@"str======%@",str);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}


@end
