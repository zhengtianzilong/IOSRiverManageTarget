//
//  ZLSuperviseHeadView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLSuperviseHeadView.h"

@implementation ZLSuperviseHeadView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}



- (void)setupUI{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.stateLable];
    [self.contentView addSubview:self.state];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.count];
    [self.contentView addSubview:self.supDepartmentLabel];
    [self.contentView addSubview:self.supDepartment];
    [self.contentView addSubview:self.supTime];
    [self.contentView addSubview:self.supTimeLabel];
    [self.contentView addSubview:self.assignedLabel];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(5);
        make.height.mas_equalTo(20);
        make.width.equalTo(self.contentView);
        //        make.width.mas_equalTo(100);
        
    }];
    
    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        
    }];
    
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.stateLable.mas_right);
        make.top.equalTo(self.stateLable);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(80);
        
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.stateLable.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        
    }];
    
    [self.count mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.countLabel.mas_right);
        make.top.equalTo(self.countLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(80);
        
    }];
    
    
    [self.supDepartmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.countLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    [self.supDepartment mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.supDepartmentLabel.mas_right);
        make.top.equalTo(self.supDepartmentLabel);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.supTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.supDepartmentLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        
    }];
    
    [self.supTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.supTimeLabel.mas_right);
        make.top.equalTo(self.supTimeLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(80);
        
    }];
    
    
    [self.assignedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.supTimeLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    
    //    [self.stateLable changeAlignmentRightandLeft];
    //    [self.originatorLabel changeAlignmentRightandLeft];
    //    [self.receiveLabel changeAlignmentRightandLeft];
    //    [self.timeLabel changeAlignmentRightandLeft];
    //    [self.describeLabel changeAlignmentRightandLeft];
}

- (void)setDetailModel:(ZLSuperviseDetailDataModel *)detailModel{
    
    _detailModel = detailModel;
    NSString *status = @"";
    self.titleLabel.text = detailModel.superviseName;
    if ([detailModel.superviseStatus isEqualToString:@"0"]) {
        
        status = @"已创建";
        
    }
    if ([detailModel.superviseStatus isEqualToString:@"1"]) {
        
        status = @"督办中";
        
    }
    if ([detailModel.superviseStatus isEqualToString:@"9"]) {
        
        status = @"完结";
        
    }
    
    self.state.text = status;
    self.count.text = detailModel.superviseCode;
    self.supTime.text = [ZLUtility getDateByTimestamp:[detailModel.superviseTime longLongValue] / 1000 type:4];
    self.supDepartment.text = detailModel.superviseUnit;
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        //        _titleLabel.textColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
        _titleLabel.text = @"水污染比较严重";
        _titleLabel.font = CHINESE_SYSTEMBold(16);
    }
    return _titleLabel;
}


- (UILabel *)stateLable{
    if (!_stateLable) {
        _stateLable = [[UILabel alloc]init];
        _stateLable.text = @"状态：";
        _stateLable.font = Font(12);
    }
    return _stateLable;
}
- (UILabel *)state{
    if (!_state) {
        _state = [[UILabel alloc]init];
        _state.text = @"XXXXX";
        _state.font = CHINESE_SYSTEM(12);
    }
    return _state;
}

- (UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.text = @"编号：";
        _countLabel.font = Font(12);
    }
    return _countLabel;
}

- (UILabel *)count{
    if (!_count) {
        _count = [[UILabel alloc]init];
        _count.text = @"80";
        _count.font = CHINESE_SYSTEM(12);
    }
    return _count;
}

- (UILabel *)supDepartmentLabel{
    if (!_supDepartmentLabel) {
        _supDepartmentLabel = [[UILabel alloc]init];
        _supDepartmentLabel.text = @"督办单位：";
        _supDepartmentLabel.font = Font(12);
    }
    return _supDepartmentLabel;
}

- (UILabel *)supDepartment{
    if (!_supDepartment) {
        _supDepartment = [[UILabel alloc]init];
        _supDepartment.text = @"123";
        _supDepartment.font = CHINESE_SYSTEM(12);
    }
    return _supDepartment;
}


- (UILabel *)supTimeLabel{
    if (!_supTimeLabel) {
        _supTimeLabel = [[UILabel alloc]init];
        _supTimeLabel.text = @"督办时间：";
        _supTimeLabel.font = Font(12);
    }
    return _supTimeLabel;
}

- (UILabel *)supTime{
    if (!_supTime) {
        _supTime = [[UILabel alloc]init];
        _supTime.text = @"系统管理员标记";
        _supTime.font = CHINESE_SYSTEM(12);
    }
    return _supTime;
}

- (UILabel *)assignedLabel{
    if (!_assignedLabel) {
        _assignedLabel = [[UILabel alloc]init];
        _assignedLabel.text = @"交办单：";
        _assignedLabel.font = Font(12);
    }
    return _assignedLabel;
}

@end
