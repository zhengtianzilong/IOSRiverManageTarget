//
//  ZLDayNotifictionTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLDayNotifictionTableViewCell.h"

@implementation ZLDayNotifictionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.timeLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(25);
        make.right.equalTo(self.contentView.mas_right);
        //        make.width.mas_equalTo(20);
        
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(20);
        //                make.width.mas_equalTo(100);
        
    }];
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.detailLabel.mas_bottom);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(50);
        
    }];
    
    
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
}

- (void)setListDataModel:(ZLNewListDataModel *)listDataModel{
    
    _listDataModel = listDataModel;
    
    self.titleLabel.text = _listDataModel.TITLE;
    self.detailLabel.text = _listDataModel.TITLE_PLUS;
    
    self.timeLabel.text = _listDataModel.CREATE_TIME;
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
   
    
    
}



- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        //        _title.textColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
        _detailLabel.text = @"2018年1月26日洪泽湖解除封航信息";
        _detailLabel.font = CHINESE_SYSTEM(11);
    }
    return _detailLabel;
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"请查看公告通知!";
        _titleLabel.font = Font(15);
    }
    return _titleLabel;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"XXXXX";
        _timeLabel.font = CHINESE_SYSTEM(11);
    }
    return _timeLabel;
}
@end
