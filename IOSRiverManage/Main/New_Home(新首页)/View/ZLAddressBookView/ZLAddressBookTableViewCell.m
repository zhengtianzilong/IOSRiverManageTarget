//
//  ZLAddressBookTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLAddressBookTableViewCell.h"

@implementation ZLAddressBookTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI{
    [self.contentView addSubview:self.phoneBtn];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.phoneBtn];
    [self.contentView addSubview:self.phoneLabel];
    
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10).priorityHigh();
        make.centerY.equalTo(self.contentView);
        
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.phoneBtn).offset(-10);
        
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(20);
        //                make.width.mas_equalTo(100);
        
    }];
    
    [_detailLabel setContentCompressionResistancePriority:(UILayoutPriorityFittingSizeLevel) forAxis:(UILayoutConstraintAxisHorizontal)];
    
    [_detailLabel setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.detailLabel.mas_right).offset(10);
        make.top.equalTo(self.detailLabel);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.phoneBtn.mas_left);
        //        make.width.mas_equalTo(50);
        
    }];
    
    [_phoneLabel setContentCompressionResistancePriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
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
    if (_phoneLabel.text.length > 0) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_phoneLabel.text];
        // ZLLog(@"str======%@",str);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        //        _title.textColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
//        _detailLabel.text = @"玄武区河长";
        _detailLabel.font = CHINESE_SYSTEM(11);
    }
    return _detailLabel;
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
//        _titleLabel.text = @"徐倩";
        _titleLabel.font = Font(15);
    }
    return _titleLabel;
}
- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
//        _phoneLabel.text = @"15951751095";
        _phoneLabel.font = CHINESE_SYSTEM(11);
    }
    return _phoneLabel;
}

@end
