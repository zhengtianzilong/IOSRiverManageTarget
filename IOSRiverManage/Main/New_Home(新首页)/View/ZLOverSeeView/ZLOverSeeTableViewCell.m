//
//  ZLOverSeeTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/6.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLOverSeeTableViewCell.h"

@implementation ZLOverSeeTableViewCell

- (void)setFrame:(CGRect)frame{
    
    frame.size.width = Main_Screen_Width - 20;
    frame.origin.x = 10;
    [super setFrame:frame];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
        
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        
    }
    return self;
    
}

- (void)setAssignModel:(ZLAssignTaskRowDetailModel *)assignModel{
    
    _assignModel = assignModel;
    
    NSString *status = @"";
    
    if ([assignModel.assignStatus isEqualToString:@"2"]) {
        
        status = @"已反馈";
        
    }
    if ([assignModel.assignStatus isEqualToString:@"9"]) {
        
        status = @"完成";
        
    }
    if ([assignModel.assignStatus isEqualToString:@"3"]) {
        
        status = @"督办中";
        
    }
    if ([assignModel.assignStatus isEqualToString:@"0"]) {
        
        status = @"未交办";
        
    }
    if ([assignModel.assignStatus isEqualToString:@"1"]) {
        
        status = @"交办中";
        
    }
    
    if ([self.assignType isEqualToString:@"交办事项"]) {
        
        if ([assignModel.isExpire isEqualToString:@"1"] && [assignModel.assignStatus isEqualToString:@"1"]) {
            
            status = @"超时";
            
        }
        
    }else{
        if ([assignModel.isExpire isEqualToString:@"1"]) {
            
            status = @"超时";
            
        }else if ([assignModel.assignStatus isEqualToString:@"1"]) {
            
            status = @"交办中";
            
        }
    }
    self.state.text = status;
    
    self.title.text = assignModel.assignCode;
    
    self.name.text = assignModel.assignName;
    self.department.text = assignModel.respUnit;
    self.people.text = assignModel.respPerson;
    self.assignedTime.text = assignModel.createTime;
    self.completeTime.text = assignModel.completeTime;
}


- (void)setUpUI{
    
    
    _state = [[UILabel alloc]init];
    _state.text = @"已发起";
    _state.font = CHINESE_SYSTEM(16);
    [self.contentView addSubview:_state];
    
    _colorIndicator = [[UIImageView alloc]init];
    _colorIndicator.image = [UIImage imageNamed:@"assign_point"];
    [self.contentView addSubview:_colorIndicator];
    
    _title = [[UILabel alloc]init];
    _title.font = CHINESE_SYSTEM(16);
    _title.text = @"河面脏乱差";
    [self.contentView addSubview:_title];
    
    
    _lineViewTop = [[UIView alloc]init];
    _lineViewTop.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    [self.contentView addSubview:_lineViewTop];
    
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = CHINESE_SYSTEM(14);
    _nameLabel.text = @"事项名称：";
    [self.contentView addSubview:_nameLabel];
    
    _name = [[UILabel alloc]init];
    _name.text = @"李乐";
    _name.font = CHINESE_SYSTEM(14);
    [self.contentView addSubview:_name];
    
    
    
    _departmentLabel = [[UILabel alloc]init];
    _departmentLabel.text = @"责任单位：";
    _departmentLabel.font = CHINESE_SYSTEM(14);
    [self.contentView addSubview:_departmentLabel];
    
    
    _department = [[UILabel alloc]init];
    _department.text = @"陈庆,李丽";
    _department.font = CHINESE_SYSTEM(14);
    [self.contentView addSubview:_department];
    
    
    _peopleLabel = [[UILabel alloc]init];
    _peopleLabel.text = @"责任人：";
    _peopleLabel.font = CHINESE_SYSTEM(14);
    [self.contentView addSubview:_peopleLabel];
    
    
    _people = [[UILabel alloc]init];
    _people.text = @"河道有许多垃圾袋";
    _people.font = CHINESE_SYSTEM(14);
    _people.numberOfLines = 0;
    [self.contentView addSubview:_people];
    
    
    _assignedTimeLabel = [[UILabel alloc]init];
    _assignedTimeLabel.text = @"交办时间：";
    _assignedTimeLabel.font = CHINESE_SYSTEM(14);
    [self.contentView addSubview:_assignedTimeLabel];
    
    
    _assignedTime = [[UILabel alloc]init];
    _assignedTime.text = @"河道有许多垃圾袋";
    _assignedTime.font = CHINESE_SYSTEM(14);
    _assignedTime.numberOfLines = 0;
    [self.contentView addSubview:_assignedTime];
    
    _completeTimeLabel = [[UILabel alloc]init];
    _completeTimeLabel.text = @"完成时限：";
    _completeTimeLabel.font = CHINESE_SYSTEM(14);
    [self.contentView addSubview:_completeTimeLabel];
    
    
    _completeTime = [[UILabel alloc]init];
    _completeTime.text = @"河道有许多垃圾袋";
    _completeTime.font = CHINESE_SYSTEM(14);
    _completeTime.numberOfLines = 0;
    [self.contentView addSubview:_completeTime];

    [_state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(self.contentView).offset(5);
    }];
    
    [_colorIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.width.height.mas_equalTo(10);
        make.centerY.equalTo(_state);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_colorIndicator.mas_right).offset(5);
        make.top.equalTo(self.contentView).offset(5);
    }];
    
    [_lineViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(_state.mas_bottom).offset(5);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(5);
        make.top.equalTo(self.lineViewTop.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(75);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(0);
        make.top.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_equalTo(20);
    }];
    
    [self.departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(75);
    }];
    [self.department mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.departmentLabel.mas_right).offset(0);
        make.top.equalTo(self.departmentLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.departmentLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(75);
    }];
    [self.people mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.peopleLabel.mas_right).offset(0);
        make.top.equalTo(self.peopleLabel);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        
    }];
    
    [self.assignedTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.peopleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(75);
    }];
    [self.assignedTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.assignedTimeLabel.mas_right).offset(0);
        make.top.equalTo(self.assignedTimeLabel);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        
    }];
    
    
    [self.completeTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.assignedTimeLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(75);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [self.completeTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.completeTimeLabel.mas_right).offset(0);
        make.top.equalTo(self.completeTimeLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];

    
}

@end
