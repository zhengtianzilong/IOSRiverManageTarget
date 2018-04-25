//
//  ZLRiverRecordCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/26.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLRiverRecordCell.h"

@implementation ZLRiverRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
    
}

- (void)setUpView{
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.startLabel];
    [self.contentView addSubview:self.startTime];
    
    [self.contentView addSubview:self.endTimeLabel];
    [self.contentView addSubview:self.endTime];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
//        make.height.mas_equalTo(35);
        
    }];
    
    [self.startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel).offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
//        make.width.mas_equalTo(0);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.startLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                             forAxis:UILayoutConstraintAxisHorizontal];
    [self.startLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.startLabel.mas_right).offset(0);
        make.top.equalTo(self.startLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        
        make.height.equalTo(self.startLabel);
        
    }];
    
    
    [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startLabel);
        make.top.equalTo(self.startLabel.mas_bottom);
        make.height.equalTo(self.startLabel);
        
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        
//        make.width.mas_equalTo(0);
    }];
    
    [self.endTimeLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                     forAxis:UILayoutConstraintAxisHorizontal];
    [self.endTimeLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.endTimeLabel.mas_right).offset(0);
        make.top.equalTo(self.endTimeLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.equalTo(self.endTimeLabel);
        
    }];
    
    
    
}

- (void)setListDataModel:(ZLRiverRecordDataModel *)listDataModel{
    
    _listDataModel = listDataModel;
    self.startTime.text = _listDataModel.START_TIME;
    self.titleLabel.text = _listDataModel.riverName;
    self.endTime.text = _listDataModel.END_TIME;
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = Font(13);
    }
    return _titleLabel;
}

- (UILabel *)startLabel{
    if (!_startLabel) {
        _startLabel = [[UILabel alloc]init];
        [_startLabel setText:@"开始时间："];
        _startLabel.font = Font(11);
    }
    return _startLabel;
}

- (UILabel *)startTime{
    if (!_startTime) {
        _startTime = [[UILabel alloc]init];
        _startTime.font = CHINESE_SYSTEM(11);
        
    }
    return _startTime;
}

- (UILabel *)endTimeLabel{
    if (!_endTimeLabel) {
        _endTimeLabel = [[UILabel alloc]init];
        [_endTimeLabel setText:@"结束时间："];
        _endTimeLabel.font = Font(11);
    }
    return _endTimeLabel;
}

- (UILabel *)endTime{
    if (!_endTime) {
        _endTime = [[UILabel alloc]init];
        _endTime.font = CHINESE_SYSTEM(11);
        
    }
    return _endTime;
}


@end
