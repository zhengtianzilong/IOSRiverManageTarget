//
//  ZLOverSeeDetailTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/6.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLOverSeeDetailTableViewCell.h"

@implementation ZLOverSeeDetailTableViewCell

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
    [self.contentView addSubview:self.departmentLabel];
    [self.contentView addSubview:self.department];
    [self.contentView addSubview:self.people];
    [self.contentView addSubview:self.peopleLabel];
    [self.contentView addSubview:self.describeLabel];
    [self.contentView addSubview:self.describe];
    [self.contentView addSubview:self.assignedTimeLabel];
    [self.contentView addSubview:self.assignedTime];
    [self.contentView addSubview:self.completeTimeLabel];
    [self.contentView addSubview:self.completeTime];
    [self.contentView addSubview:self.noteLabel];
    [self.contentView addSubview:self.note];
    
    
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
    
    
    [self.departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.countLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    [self.department mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.departmentLabel.mas_right);
        make.top.equalTo(self.departmentLabel);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.departmentLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        
    }];
    
    [self.people mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.peopleLabel.mas_right);
        make.top.equalTo(self.peopleLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(80);
        
    }];
    
    
    [self.assignedTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.peopleLabel.mas_bottom).offset(5);
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
        
        make.left.equalTo(self.titleLabel);
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
    
    
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.completeTimeLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        
    }];
    
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.describeLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.describeLabel).offset(0);
        //        make.height.mas_equalTo(80);
        //        make.width.mas_equalTo(80);
        
    }];
    
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.describe.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        
    }];
    
    [self.note mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.noteLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.noteLabel).offset(0);
        //        make.height.mas_equalTo(80);
        //        make.width.mas_equalTo(80);
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

- (void)setDetailModel:(ZLAssignTaskDetailDataModel *)detailModel{
    
    _detailModel = detailModel;
    
    self.titleLabel.text = detailModel.assignName;
    NSString *status = @"";

    if ([detailModel.assignStatus isEqualToString:@"2"]) {

        status = @"已反馈";

    }
    if ([detailModel.assignStatus isEqualToString:@"9"]) {

        status = @"已完成";

    }
    if ([detailModel.assignStatus isEqualToString:@"3"]) {

        status = @"督办中";

    }
    if ([detailModel.assignStatus isEqualToString:@"0"]) {

        status = @"未交办";

    }
    if ([detailModel.assignStatus isEqualToString:@"1"]) {

        if ([detailModel.isExpire isEqualToString:@"1"]) {
            status = @"超时";
        } else {
            status = @"交办中";
        }
        

    }


    self.state.text = status;
    
    self.assignedTime.text = [ZLUtility getDateByTimestamp:[detailModel.createTime longLongValue]/1000 type:4];
    
    self.completeTime.text = [ZLUtility getDateByTimestamp:[detailModel.completeTime longLongValue]/1000 type:4];
    
    self.count.text = detailModel.assignCode;
    self.department.text = detailModel.departName;
    self.people.text = detailModel.userName;
    self.describe.text = detailModel.assignContent;
    self.note.text = detailModel.remark;
    
    
    
    
    
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



- (UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc]init];
        _describeLabel.text = @"描述：";
        _describeLabel.font = Font(12);
    }
    return _describeLabel;
}

- (UILabel *)describe{
    if (!_describe) {
        _describe = [[UILabel alloc]init];
        _describe.text = @"系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记";
        _describe.font = CHINESE_SYSTEM(12);
        _describe.numberOfLines = 0;
    }
    return _describe;
}


- (UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.text = @"备注：";
        _noteLabel.font = Font(12);
        
    }
    return _noteLabel;
}

- (UILabel *)note{
    if (!_note) {
        _note = [[UILabel alloc]init];
        _note.text = @"系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记";
        _note.font = CHINESE_SYSTEM(12);
        _note.numberOfLines = 0;
    }
    return _note;
}


@end
