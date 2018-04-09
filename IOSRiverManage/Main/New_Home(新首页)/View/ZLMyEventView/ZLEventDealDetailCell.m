//
//  ZLEventDealDetailCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventDealDetailCell.h"

@implementation ZLEventDealDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}



- (void)setupUI{
    
    [self.contentView addSubview:self.colorIndicator];
    [self.contentView addSubview:self.peopleLabel];
    [self.contentView addSubview:self.people];
    [self.contentView addSubview:self.stateLabel];
    [self.contentView addSubview:self.state];
    //    [self.contentView addSubview:self.feedLabel];
    //    [self.contentView addSubview:self.feed];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.time];
    
    
    [self.colorIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(15);
        make.width.height.mas_equalTo(10);
    }];
    
    [self.peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.colorIndicator.mas_right).offset(5);
        make.centerY.equalTo(self.colorIndicator);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
        
    }];
    
    [self.people mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.peopleLabel.mas_right);
        make.top.equalTo(self.peopleLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(50);
        
    }];
    
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.peopleLabel);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
        
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.state.mas_left).offset(0);
        make.top.equalTo(self.peopleLabel);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.peopleLabel);
        make.top.equalTo(self.peopleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.timeLabel.mas_right);
        make.top.equalTo(self.timeLabel);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
   
    
    
    
}

- (void)setDataModel:(ZLRiverIncidentDetailListModel *)dataModel{
    
    _dataModel = dataModel;
    
    self.people.text = dataModel.userName;
    
    NSString *status = @"";
    
    if ([_dataModel.createBy isEqualToString:self.userCode]) {
        
        if ([_dataModel.incidentDetailStatus isEqualToString:@"0"]) {
            status = @"创建";
        }
        if ([_dataModel.incidentDetailStatus isEqualToString:@"1"]) {
            
            status = @"已上报";
            
        }
        if ([_dataModel.incidentDetailStatus isEqualToString:@"2"]) {
            
            status = @"已接收";
        }
        if ([_dataModel.incidentDetailStatus isEqualToString:@"3"]) {
            
            status = @"已转报";
        }
        if ([_dataModel.incidentDetailStatus isEqualToString:@"9"]) {
            
            status = @"完结";
        }
    }else{
        if ([_dataModel.incidentDetailStatus isEqualToString:@"0"]) {
            status = @"已创建";
        }
        if ([_dataModel.incidentDetailStatus isEqualToString:@"1"]) {
            
            status = @"未接收";
            
        }
        if ([_dataModel.incidentDetailStatus isEqualToString:@"2"]) {
            
            status = @"待处理";
        }
        if ([_dataModel.incidentDetailStatus isEqualToString:@"3"]) {
            
            status = @"已转报";
        }
        if ([_dataModel.incidentDetailStatus isEqualToString:@"9"]) {
            
            status = @"反馈";
        }
    }
    
    self.state.text = status;
    NSString *time = _dataModel.updateTime;
    
    NSString *timeString = [ZLUtility getDateByTimestamp:[time longLongValue] / 1000 type:4];
    self.time.text = timeString;
    
    
}


- (UIImageView *)colorIndicator{
    if (!_colorIndicator) {
        _colorIndicator = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"task_point"]];
    }
    return _colorIndicator;
}


- (UILabel *)peopleLabel{
    if (!_peopleLabel) {
        _peopleLabel = [[UILabel alloc]init];
        _peopleLabel.text = @"执行人：";
        _peopleLabel.font = CHINESE_SYSTEM(14);
    }
    return _peopleLabel;
}
- (UILabel *)people{
    if (!_people) {
        _people = [[UILabel alloc]init];
        _people.text = @"XXXXX";
        _people.font = CHINESE_SYSTEM(14);
    }
    return _people;
}

- (UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.text = @"状态：";
        _stateLabel.font = CHINESE_SYSTEM(14);
    }
    return _stateLabel;
}
- (UILabel *)state{
    if (!_state) {
        _state = [[UILabel alloc]init];
        _state.text = @"XXXXX";
        _state.font = CHINESE_SYSTEM(14);
    }
    return _state;
}

//- (UILabel *)feedLabel{
//    if (!_feedLabel) {
//        _feedLabel = [[UILabel alloc]init];
//        _feedLabel.text = @"反馈:";
//        _feedLabel.font = CHINESE_SYSTEM(14);
//    }
//    return _feedLabel;
//}
//
//- (UILabel *)feed{
//    if (!_feed) {
//        _feed = [[UILabel alloc]init];
//        _feed.text = @"系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标";
//        _feed.font = CHINESE_SYSTEM(14);
//    }
//    return _feed;
//}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"完成时间：";
        _timeLabel.font = CHINESE_SYSTEM(14);
    }
    return _timeLabel;
}

- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.text = @"123";
        _time.font = CHINESE_SYSTEM(14);
    }
    return _time;
}
@end
