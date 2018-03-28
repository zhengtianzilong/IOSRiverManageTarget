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
    
    [self.contentView addSubview:self.kilometresLabel];
    [self.contentView addSubview:self.kilometres];
    [self.contentView addSubview:self.totalTimeLabel];
    [self.contentView addSubview:self.totalTime];
    
    [self.contentView addSubview:self.startLabel];
    [self.contentView addSubview:self.startTime];
    
    
}

- (void)setListDataModel:(ZLRiverRecordDataModel *)listDataModel{
    
    _listDataModel = listDataModel;
    
    NSInteger startTime = [ZLUtility getTimestampByDate:_listDataModel.START_TIME type:4];
    
    NSInteger endTime = [ZLUtility getTimestampByDate:_listDataModel.END_TIME type:4];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date1 = [formatter dateFromString:_listDataModel.START_TIME];
    
    NSDate *date2 = [formatter dateFromString:_listDataModel.END_TIME];
    
    NSTimeInterval aTimer = [date2 timeIntervalSinceDate:date1];
    
    
    
    int hour = (int)(aTimer/3600);
    
    int minute = (int)(aTimer)/60;
    
    int second = aTimer - hour*3600 - minute*60;
    
    NSString *dural = [NSString stringWithFormat:@"%d分", minute];
    
    
    self.kilometres.text = @"10公里";
    self.totalTime.text = dural;
    self.startTime.text = _listDataModel.START_TIME;
    self.titleLabel.text = _listDataModel.riverName;
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.4);
        
    }];
    
    [self.kilometresLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom);
//        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.25);
        
    }];
    
    [self.kilometres mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.kilometresLabel.mas_right).offset(0);
        make.top.equalTo(self.kilometresLabel);
        make.width.mas_equalTo(80);
        make.height.equalTo(self.kilometresLabel);
        
    }];
    
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.kilometres.mas_right).offset(0);
        make.top.equalTo(self.kilometresLabel);
        make.height.equalTo(self.kilometresLabel);
        
    }];
    
    [self.totalTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.totalTimeLabel.mas_right).offset(0);
        make.top.equalTo(self.kilometresLabel);
        make.width.mas_equalTo(100);
        make.height.equalTo(self.kilometresLabel);
        
    }];
    
    [self.startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.kilometresLabel);
        make.top.equalTo(self.kilometresLabel.mas_bottom);
        make.height.equalTo(self.kilometresLabel);
        
    }];
    
    [self.startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.startLabel.mas_right).offset(0);
        make.top.equalTo(self.startLabel);
        make.right.equalTo(self.contentView.mas_right).offset(50);
        make.height.equalTo(self.kilometresLabel);
        
    }];
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = CHINESE_SYSTEM(18);
        
    }
    return _titleLabel;
}

- (UILabel *)kilometresLabel{
    if (!_kilometresLabel) {
        _kilometresLabel = [[UILabel alloc]init];
        [_kilometresLabel setText:@"公里数:"];
        _kilometresLabel.font = CHINESE_SYSTEM(16);
        
    }
    return _kilometresLabel;
}

- (UILabel *)kilometres{
    if (!_kilometres) {
        _kilometres = [[UILabel alloc]init];
        _kilometres.font = CHINESE_SYSTEM(16);
        
    }
    return _kilometres;
}

- (UILabel *)totalTimeLabel{
    if (!_totalTimeLabel) {
        _totalTimeLabel = [[UILabel alloc]init];
        [_totalTimeLabel setText:@"时长:"];
        _totalTimeLabel.font = CHINESE_SYSTEM(16);
        
    }
    return _totalTimeLabel;
}

- (UILabel *)totalTime{
    if (!_totalTime) {
        _totalTime = [[UILabel alloc]init];
        _totalTime.font = CHINESE_SYSTEM(16);
        
    }
    return _totalTime;
}

- (UILabel *)startLabel{
    if (!_startLabel) {
        _startLabel = [[UILabel alloc]init];
        [_startLabel setText:@"开始时间:"];
        _startLabel.font = CHINESE_SYSTEM(16);
    }
    return _startLabel;
}

- (UILabel *)startTime{
    if (!_startTime) {
        _startTime = [[UILabel alloc]init];
        _startTime.font = CHINESE_SYSTEM(16);
        
    }
    return _startTime;
}

@end
