//
//  ZLDayNewsTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLDayNewsTableViewCell.h"

@implementation ZLDayNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI{
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.timeLabel];
    
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
}

- (void)setListDataModel:(ZLNewListDataModel *)listDataModel{
    
    _listDataModel = listDataModel;
    
    self.titleLabel.text = _listDataModel.TITLE;
    self.detailLabel.text = _listDataModel.TITLE_PLUS;
    
    self.timeLabel.text = _listDataModel.CREATE_TIME;
    
    [self.imageV sd_setImageWithURL: [NSURL URLWithString:_listDataModel.img] placeholderImage:[UIImage imageNamed:@"event_placeImage"]];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
        
        make.width.mas_equalTo(Main_Screen_Width / 3);
        make.height.equalTo(self.contentView.mas_height).offset(-10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.imageV.mas_left).offset(-10);
        
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.right.equalTo(self.titleLabel.mas_right);
        make.height.mas_equalTo(20);
        //                make.width.mas_equalTo(100);
        
    }];
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.detailLabel.mas_bottom);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.titleLabel.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        //        make.width.mas_equalTo(50);
        
    }];
    
    
}

- (UIImageView *)imageV{
    
    if (!_imageV) {
        
        _imageV = [[UIImageView alloc]init];
        _imageV.backgroundColor = [UIColor redColor];
        
    }
    return _imageV;
    
}


- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        //        _title.textColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
        _detailLabel.text = @"2018年1月26日洪泽湖解除封航信息";
        _detailLabel.font = CHINESE_SYSTEM(13);
    }
    return _detailLabel;
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"请查看公告通知!";
        _titleLabel.font = CHINESE_SYSTEM(17);
    }
    return _titleLabel;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"XXXXX";
        _timeLabel.font = CHINESE_SYSTEM(13);
    }
    return _timeLabel;
}
@end
