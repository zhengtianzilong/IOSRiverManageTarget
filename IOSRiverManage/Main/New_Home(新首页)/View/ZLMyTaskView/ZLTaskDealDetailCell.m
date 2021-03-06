//
//  ZLTaskDealDetailCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLTaskDealDetailCell.h"

@implementation ZLTaskDealDetailCell

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
    [self.contentView addSubview:self.backBtn];
    [self.contentView addSubview:self.detailBtn];
    [self.contentView addSubview:self.completeBtn];
    
    
    [self.colorIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(15);
        make.width.height.mas_equalTo(10);
    }];
    
    [self.peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.colorIndicator.mas_right).offset(5);
        make.centerY.equalTo(self.colorIndicator);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        
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
    
//    [self.feedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.peopleLabel);
//        make.top.equalTo(self.peopleLabel.mas_bottom).offset(5);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(60);
//
//    }];
//
//    [self.feed mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.feedLabel.mas_right);
//        make.right.equalTo(self.contentView.mas_right).offset(-10);
//        make.top.equalTo(self.feedLabel).offset(0);
//
//
//    }];
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.peopleLabel);
        make.top.equalTo(self.peopleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(75);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.timeLabel.mas_right);
        make.top.equalTo(self.timeLabel);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.time.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(55);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [self.completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.detailBtn.mas_left).offset(-5);
        make.top.equalTo(self.detailBtn);
        make.height.equalTo(self.detailBtn);
        make.width.equalTo(self.detailBtn);
        
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.completeBtn.mas_left).offset(-5);
        make.top.equalTo(self.completeBtn);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(55);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
   
   

}

- (void)setDataModel:(ZLTaskRiverTaskDetailListModel *)dataModel{
    
    _dataModel = dataModel;
    
    self.people.text = dataModel.userName;
    
    NSString *status = @"";
    
    if ([_dataModel.taskDetailStatus isEqualToString:@"0"]) {
        status = @"已创建";
    }
    if ([_dataModel.taskDetailStatus isEqualToString:@"1"]) {
        status = @"已下发";
    }
    if ([_dataModel.taskDetailStatus isEqualToString:@"2"]) {
        
        status = @"已接收";
        
    }
    if ([_dataModel.taskDetailStatus isEqualToString:@"3"]) {
        
        status = @"已转发";
    }
    if ([_dataModel.taskDetailStatus isEqualToString:@"6"]) {
        
        status = @"待核查";
    }
    if ([_dataModel.taskDetailStatus isEqualToString:@"7"]) {
        
        status = @"已驳回";
    }
    if ([_dataModel.taskDetailStatus isEqualToString:@"8"]) {
        
        status = @"已完成";
    }
    
    if ([_dataModel.taskDetailStatus isEqualToString:@"9"]) {
        
        status = @"完结";
    }
    
    self.state.text = status;
    NSString *time = _dataModel.implementTime;
    
    NSString *timeString = [ZLUtility getDateByTimestamp:[time longLongValue] / 1000 type:4];
    self.time.text = timeString;
    
    // 必须先是 6 才判断 有没有两个按钮
//    if ([self.passCode isEqualToString:@"下发任务"] || [self.passCode isEqualToString:@"待办任务"] || [self.passCode isEqualToString:@"任务查询"]) {
//
//        self.completeBtn.hidden = YES;
//        self.backBtn.hidden = YES;
//
//    }else{
//
//        if ([dataModel.isPass isEqualToString:@"0"]) {
//
//            self.completeBtn.hidden = YES;
//
//        }
//
//        if ([dataModel.isReject isEqualToString:@"0"]) {
//
//            self.backBtn.hidden = YES;
//
//        }
//    }
    
    if (![_dataModel.taskDetailStatus isEqualToString:@"6"]) {
        
        self.completeBtn.hidden = YES;
        self.backBtn.hidden = YES;
        
    }else{
        
        if ([dataModel.isPass isEqualToString:@"0"]) {
            
            self.completeBtn.hidden = YES;
            
        }
        
        if ([dataModel.isReject isEqualToString:@"0"]) {
            
            self.backBtn.hidden = YES;
            
        }
    }
    
    
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
        _peopleLabel.font = Font(12);
    }
    return _peopleLabel;
}
- (UILabel *)people{
    if (!_people) {
        _people = [[UILabel alloc]init];
        _people.text = @"XXXXX";
        _people.font = CHINESE_SYSTEM(12);
    }
    return _people;
}

- (UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.text = @"状态：";
        _stateLabel.font = Font(12);
    }
    return _stateLabel;
}
- (UILabel *)state{
    if (!_state) {
        _state = [[UILabel alloc]init];
        _state.text = @"XXXXX";
        _state.font = CHINESE_SYSTEM(12);
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
        _timeLabel.font = Font(12);
    }
    return _timeLabel;
}

- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.text = @"123";
        _time.font = CHINESE_SYSTEM(12);
    }
    return _time;
}


- (void)detailBtnClick{

    if (_detailClick) {
        self.detailClick(_dataModel);
    }
    
    
}

- (void)backBtnClick{
    if (_backClick) {
        self.backClick(_dataModel);
    }
}

-(void)completeBtnClick{
    if (_completeClick) {
        self.completeClick(_dataModel);
    }
}

- (UIButton *)detailBtn{
    if (!_detailBtn) {
        _detailBtn = [[UIButton alloc]init];
        [_detailBtn setTitle:@"详情" forState:(UIControlStateNormal)];
        [_detailBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        _detailBtn.layer.borderWidth = 1;
        _detailBtn.layer.cornerRadius = 5;
        _detailBtn.layer.borderColor = HEXCOLOR(CVIEW_GRAY_COLOR).CGColor;
        _detailBtn.titleLabel.font = CHINESE_SYSTEM(13);
        _detailBtn.layer.masksToBounds = YES;
        [_detailBtn addTarget:self action:@selector(detailBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _detailBtn;
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]init];
        [_backBtn setTitle:@"驳回" forState:(UIControlStateNormal)];
        [_backBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        _backBtn.titleLabel.font = CHINESE_SYSTEM(13);
        _backBtn.layer.borderWidth = 1;
        _backBtn.layer.masksToBounds = NO;
        _backBtn.layer.cornerRadius = 5;
        _backBtn.layer.borderColor = HEXCOLOR(CVIEW_GRAY_COLOR).CGColor;
        _backBtn.clipsToBounds = YES;
        
    }
    return _backBtn;
}

- (UIButton *)completeBtn{
    if (!_completeBtn) {
        _completeBtn = [[UIButton alloc]init];
        [_completeBtn setTitle:@"完成" forState:(UIControlStateNormal)];
        [_completeBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        _completeBtn.titleLabel.font = CHINESE_SYSTEM(13);
        _completeBtn.layer.borderWidth = 1;
        _completeBtn.layer.masksToBounds = NO;
        _completeBtn.layer.cornerRadius = 5;
        _completeBtn.layer.borderColor = HEXCOLOR(CVIEW_GRAY_COLOR).CGColor;
        _completeBtn.clipsToBounds = YES;
        
    }
    return _completeBtn;
}
@end
