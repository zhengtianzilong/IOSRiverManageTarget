//
//  ZLAddressBookDetailTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/4.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLAddressBookDetailTableViewCell.h"

@implementation ZLAddressBookDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI{

    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
//        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(60);
    }];
    
    [_titleLabel setContentCompressionResistancePriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];

    [_titleLabel setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    
    
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self.titleLabel.mas_trailing).offset(10);
//        make.centerY.equalTo(self.contentView.mas_centerY);
        make.top.equalTo(self.titleLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_greaterThanOrEqualTo(20);
        
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        
        //                make.width.mas_equalTo(100);
    }];
//    [_detailLabel setContentCompressionResistancePriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    
    
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
//    [self.titleLabel changeAlignmentRightandLeft];
    
}



- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        //        _title.textColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
        _detailLabel.text = @"玄武区河长";
        _detailLabel.numberOfLines = 0;
        _detailLabel.font = CHINESE_SYSTEM(13);
    }
    return _detailLabel;
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"徐倩";
        _titleLabel.font = Font(13);
    }
    return _titleLabel;
}


@end
