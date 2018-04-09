//
//  ZLSuperviseTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLSuperviseTableViewCell.h"

@implementation ZLSuperviseTableViewCell
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

- (void)setDetailModel:(ZLSuperviseRowDetailModel *)detailModel{
    
    _detailModel = detailModel;
    
    NSString *status = @"";
//    {{# if(d.superviseStatus == '0'){  }}
//        <span>已创建</span>
//        {{# } else if(d.superviseStatus == '1'){  }}
//        <span>督办中</span>
//        {{# } else if(d.superviseStatus == '9' ){  }}
//        <span >完结</span>
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
    
    self.title.text = detailModel.superviseCode;
    
    self.name.text = detailModel.superviseName;
    self.supDepartment.text = detailModel.superviseUnit;
    self.code.text = detailModel.assignCode;
    self.department.text = detailModel.respUnit;
    self.people.text = detailModel.respPerson;
    self.superviseTime.text = detailModel.superviseTime;
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
    
    _supDepartmentLabel = [[UILabel alloc]init];
    _supDepartmentLabel.text = @"督办单位：";
    _supDepartmentLabel.font = CHINESE_SYSTEM(14);
    [self.contentView addSubview:_supDepartmentLabel];
    
    _supDepartment = [[UILabel alloc]init];
    _supDepartment.text = @"江苏啊啊啊：";
    _supDepartment.font = CHINESE_SYSTEM(14);
    [self.contentView addSubview:_supDepartment];
    
    _codeLabel = [[UILabel alloc]init];
    _codeLabel.text = @"交办单编号：";
    _codeLabel.font = CHINESE_SYSTEM(14);
    [self.contentView addSubview:_codeLabel];
    
    
    _code = [[UILabel alloc]init];
    _code.text = @"陈庆,李丽";
    _code.font = CHINESE_SYSTEM(14);
    [self.contentView addSubview:_code];
    
    
    
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
    
    
    _superviseTimeLabel = [[UILabel alloc]init];
    _superviseTimeLabel.text = @"督办时间：";
    _superviseTimeLabel.font = CHINESE_SYSTEM(14);
    [self.contentView addSubview:_superviseTimeLabel];
    
    
    _superviseTime = [[UILabel alloc]init];
    _superviseTime.text = @"河道有许多垃圾袋";
    _superviseTime.font = CHINESE_SYSTEM(14);
    _superviseTime.numberOfLines = 0;
    [self.contentView addSubview:_superviseTime];
    
 
    
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
        make.width.mas_equalTo(65);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(0);
        make.top.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_equalTo(20);
    }];
    
    [self.supDepartmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(65);
    }];
    [self.supDepartment mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.supDepartmentLabel.mas_right).offset(0);
        make.top.equalTo(self.supDepartmentLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.supDepartmentLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(75);
    }];
    [self.code mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.codeLabel.mas_right).offset(0);
        make.top.equalTo(self.codeLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_equalTo(20);
        
    }];
    
    
    [self.departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.codeLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(65);
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
        make.width.mas_equalTo(65);
    }];
    [self.people mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.peopleLabel.mas_right).offset(0);
        make.top.equalTo(self.peopleLabel);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        
    }];
    
    [self.superviseTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.peopleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(65);
    }];
    [self.superviseTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.superviseTimeLabel.mas_right).offset(0);
        make.top.equalTo(self.superviseTimeLabel);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
}

@end
