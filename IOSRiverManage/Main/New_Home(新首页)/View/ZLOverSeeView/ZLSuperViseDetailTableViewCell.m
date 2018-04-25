//
//  ZLSuperViseDetailTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLSuperViseDetailTableViewCell.h"

@implementation ZLSuperViseDetailTableViewCell

- (void)setFrame:(CGRect)frame{
    
    frame.size.width = Main_Screen_Width - 20;
    frame.origin.x = 10;
    [super setFrame:frame];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = HEXCOLOR(CNAVGATIONBAR_COLOR).CGColor;

        self.layer.masksToBounds = YES;
    }
    return self;
    
}



- (void)setupUI{
    
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.count];
    [self.contentView addSubview:self.departmentLabel];
    [self.contentView addSubview:self.department];
    [self.contentView addSubview:self.people];
    [self.contentView addSubview:self.peopleLabel];
   
    [self.contentView addSubview:self.assignedTimeLabel];
    [self.contentView addSubview:self.assignedTime];
    [self.contentView addSubview:self.completeTimeLabel];
    [self.contentView addSubview:self.completeTime];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(5);
        make.top.equalTo(self.self.contentView).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        
    }];
    
    [self.count mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.countLabel.mas_right);
        make.top.equalTo(self.countLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(80);
        
    }];
    
    
    [self.assignedTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.countLabel);
        make.top.equalTo(self.countLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        
    }];
    
    [self.assignedTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.assignedTimeLabel.mas_right);
        make.top.equalTo(self.assignedTimeLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(80);
        
    }];
    
    [self.completeTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.countLabel);
        make.top.equalTo(self.assignedTimeLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        
    }];
    
    [self.completeTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.completeTimeLabel.mas_right);
        make.top.equalTo(self.completeTimeLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(80);
        
    }];
    [self.departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.countLabel);
        make.top.equalTo(self.completeTimeLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    [self.department mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.departmentLabel.mas_right);
        make.top.equalTo(self.departmentLabel);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.countLabel);
        make.top.equalTo(self.departmentLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        
    }];
    
    [self.people mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.peopleLabel.mas_right);
        make.top.equalTo(self.peopleLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(80);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
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

- (void)setDetailModel:(ZLAssignTaskDetailDataModel *)detailModel{

    _detailModel = detailModel;
    self.assignedTime.text = [ZLUtility getDateByTimestamp:[detailModel.createTime longLongValue]/1000 type:4];

    self.completeTime.text = [ZLUtility getDateByTimestamp:[detailModel.completeTime longLongValue]/1000 type:4];

    self.count.text = detailModel.assignCode;
    self.department.text = detailModel.respUnit;
    self.people.text = detailModel.respPerson;
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

- (UILabel *)departmentLabel{
    if (!_departmentLabel) {
        _departmentLabel = [[UILabel alloc]init];
        _departmentLabel.text = @"责任单位：";
        _departmentLabel.font = Font(12);
    }
    return _departmentLabel;
}

- (UILabel *)department{
    if (!_department) {
        _department = [[UILabel alloc]init];
        _department.text = @"123";
        _department.font = CHINESE_SYSTEM(12);
    }
    return _department;
}

- (UILabel *)peopleLabel{
    if (!_peopleLabel) {
        _peopleLabel = [[UILabel alloc]init];
        _peopleLabel.text = @"责任人：";
        _peopleLabel.font = Font(12);
    }
    return _peopleLabel;
}

- (UILabel *)people{
    if (!_people) {
        _people = [[UILabel alloc]init];
        _people.text = @"系统管理员标记";
        _people.font = CHINESE_SYSTEM(12);
    }
    return _people;
}

- (UILabel *)assignedTimeLabel{
    if (!_assignedTimeLabel) {
        _assignedTimeLabel = [[UILabel alloc]init];
        _assignedTimeLabel.text = @"交办时间：";
        _assignedTimeLabel.font = Font(12);
    }
    return _assignedTimeLabel;
}

- (UILabel *)assignedTime{
    if (!_assignedTime) {
        _assignedTime = [[UILabel alloc]init];
        _assignedTime.text = @"系统管理员标记";
        _assignedTime.font = CHINESE_SYSTEM(12);
    }
    return _assignedTime;
}

- (UILabel *)completeTimeLabel{
    if (!_completeTimeLabel) {
        _completeTimeLabel = [[UILabel alloc]init];
        _completeTimeLabel.text = @"完成时限：";
        _completeTimeLabel.font = Font(12);
    }
    return _completeTimeLabel;
}

- (UILabel *)completeTime{
    if (!_completeTime) {
        _completeTime = [[UILabel alloc]init];
        _completeTime.text = @"系统管理员标记";
        _completeTime.font = CHINESE_SYSTEM(12);
    }
    return _completeTime;
}

@end
