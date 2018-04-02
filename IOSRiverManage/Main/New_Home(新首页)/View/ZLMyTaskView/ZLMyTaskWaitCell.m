//
//  ZLMyTaskWaitCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyTaskWaitCell.h"
#import "UIView+RoundedCorner.h"
@implementation ZLMyTaskWaitCell

- (void)setUpUI{
    [super setUpUI];
    
    [self.contentView addSubview:self.dealBtn];
    
    
    [self.dealBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.lineViewBottom.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(55);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    self.colorIndicator.image = [UIImage imageNamed:@"task_point"];
    
    self.initiatorLabel.text = @"创建人:";
    self.receivedLabel.text = @"接收人:";
    self.state.textColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.dealBtn jm_setCornerRadius:0.7 withBackgroundColor:[UIColor whiteColor]];
    //    [self.changeBtn jm_setCornerRadius:0.7 withBackgroundColor:[UIColor whiteColor]];
    
}

- (void)deleteBtnClick{
    
    if (_dealClick) {
        self.dealClick(self.dataModel,self.homeDataModel, self.dealBtn);
    }
    
}

- (UIButton *)dealBtn{
    if (!_dealBtn) {
        _dealBtn = [[UIButton alloc]init];
        [_dealBtn setTitle:@"处理" forState:(UIControlStateNormal)];
        [_dealBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _dealBtn.titleLabel.font = CHINESE_SYSTEM(16);
        _dealBtn.layer.borderWidth = 1;
        _dealBtn.layer.cornerRadius = 5;
        _dealBtn.layer.borderColor = HEXCOLOR(CVIEW_GRAY_COLOR).CGColor;
        _dealBtn.layer.masksToBounds = YES;
        [_dealBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _dealBtn;
}


- (void)setDataModel:(ZLTaskWaitDataModel *)dataModel{
    
    _dataModel = dataModel;
    self.initiatorName.text = _dataModel.createName;
    self.receivedName.text = _dataModel.userName;
    self.content.text = _dataModel.taskContent;
    
    self.title.text = _dataModel.taskName;
    
    NSString *status = @"";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImage_URL,_dataModel.fileAddr]];
    
    [self.imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"event_placeImage"]];
    
    self.dealBtn.hidden = NO;
    
    if ([_dataModel.taskDetailStatus isEqualToString:@"0"]) {
        status = @"已创建";
        self.dealBtn.hidden = YES;
    }
    if ([_dataModel.taskDetailStatus isEqualToString:@"1"]) {
        status = @"已下发";
        
        [self.dealBtn setTitle:@"接收" forState:(UIControlStateNormal)];
        
    }
    if ([_dataModel.taskDetailStatus isEqualToString:@"2"]) {
        
        status = @"已接收";
        
        [self.dealBtn setTitle:@"处理" forState:(UIControlStateNormal)];
        
    }
    if ([_dataModel.taskDetailStatus isEqualToString:@"3"]) {
        status = @"已转发";
        self.dealBtn.hidden = YES;
    }
    if ([_dataModel.taskDetailStatus isEqualToString:@"6"]) {
        self.dealBtn.hidden = YES;
        status = @"已反馈";
    }
    if ([_dataModel.taskDetailStatus isEqualToString:@"7"]) {
        status = @"已驳回";
        [self.dealBtn setTitle:@"处理" forState:(UIControlStateNormal)];
    }
    if ([_dataModel.taskDetailStatus isEqualToString:@"8"]) {
        status = @"已完成";
        self.dealBtn.hidden = YES;
    }
    
    if ([_dataModel.taskDetailStatus isEqualToString:@"9"]) {
        status = @"完结";
        self.dealBtn.hidden = YES;
    }
    
    NSString *time = _dataModel.createTime;
    
//    NSString *timeString = [ZLUtility getDateByTimestamp:[time longLongValue] / 1000 type:4];
    self.timeLabel.text = time;
    self.state.text = status;
    
    self.taskId = _dataModel.taskId;
}


- (void)setHomeDataModel:(ZLHomeWaitEventAndTaskDataModel *)homeDataModel{
    
    _homeDataModel = homeDataModel;
    self.initiatorName.text = _homeDataModel.createName;
    self.receivedName.text = _homeDataModel.userName;
    self.content.text = _homeDataModel.taskContent;
    
    self.title.text = _homeDataModel.taskName;
    
    NSString *status = @"";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImage_URL,_homeDataModel.fileAddr]];
    
    [self.imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"event_placeImage"]];
    
    self.dealBtn.hidden = NO;
    
    if ([_homeDataModel.taskDetailStatus isEqualToString:@"0"]) {
        status = @"已创建";
        self.dealBtn.hidden = YES;
    }
    if ([_homeDataModel.taskDetailStatus isEqualToString:@"1"]) {
        status = @"已下发";
        
        [self.dealBtn setTitle:@"接收" forState:(UIControlStateNormal)];
        
    }
    if ([_homeDataModel.taskDetailStatus isEqualToString:@"2"]) {
        
        status = @"已接收";
        
        [self.dealBtn setTitle:@"处理" forState:(UIControlStateNormal)];
        
    }
    if ([_homeDataModel.taskDetailStatus isEqualToString:@"3"]) {
        status = @"已转发";
        self.dealBtn.hidden = YES;
    }
    if ([_homeDataModel.taskDetailStatus isEqualToString:@"6"]) {
        self.dealBtn.hidden = YES;
        status = @"已反馈";
    }
    if ([_homeDataModel.taskDetailStatus isEqualToString:@"7"]) {
        status = @"已驳回";
        [self.dealBtn setTitle:@"处理" forState:(UIControlStateNormal)];
    }
    if ([_homeDataModel.taskDetailStatus isEqualToString:@"8"]) {
        status = @"已完成";
        self.dealBtn.hidden = YES;
    }
    
    if ([_homeDataModel.taskDetailStatus isEqualToString:@"9"]) {
        status = @"完结";
        self.dealBtn.hidden = YES;
    }
    
    NSString *time = _homeDataModel.createTime;
    
    //    NSString *timeString = [ZLUtility getDateByTimestamp:[time longLongValue] / 1000 type:4];
    self.timeLabel.text = time;
    self.state.text = status;
    self.taskId = _homeDataModel.taskId;
    
}





@end
