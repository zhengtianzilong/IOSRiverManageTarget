//
//  ZLMyTaskChangAndDeleteCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyTaskChangAndDeleteCell.h"

@implementation ZLMyTaskChangAndDeleteCell

- (void)setUpUI{
    
    [super setUpUI];
    
    self.colorIndicator.image = [UIImage imageNamed:@"task_point"];
    
    self.initiatorLabel.text = @"创建人:";
    self.receivedLabel.text = @"执行人:";
    self.state.textColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    
}

- (void)setDataModel:(ZLTaskManageDataModel *)dataModel{
    
    _dataModel = dataModel;
    self.initiatorName.text = _dataModel.createName;
    self.receivedName.text = _dataModel.userName;
    self.content.text = _dataModel.taskContent;
    self.timeLabel.text = _dataModel.createTime;
    self.title.text = _dataModel.taskName;
    
    NSString *status = @"";
    
    if ([_dataModel.taskStatus isEqualToString:@"0"]) {
        
        status = @"已创建";
        
        
    }
    
    if ([_dataModel.taskStatus isEqualToString:@"1"]) {
        
        status = @"已下发";
        
        self.deleteBtn.hidden = YES;
        self.changeBtn.hidden = YES;
        
    }
    if ([_dataModel.taskStatus isEqualToString:@"2"]) {
        
        status = @"已接收";
        self.deleteBtn.hidden = YES;
        self.changeBtn.hidden = YES;
    }
    if ([_dataModel.taskStatus isEqualToString:@"3"]) {
        
        status = @"已转发";
        self.deleteBtn.hidden = YES;
        self.changeBtn.hidden = YES;
    }
    if ([_dataModel.taskStatus isEqualToString:@"6"]) {
        
        status = @"已反馈";
        self.deleteBtn.hidden = YES;
        self.changeBtn.hidden = YES;
    }
    if ([_dataModel.taskStatus isEqualToString:@"7"]) {
        
        status = @"已驳回";
        self.deleteBtn.hidden = YES;
        self.changeBtn.hidden = YES;
    }
    if ([_dataModel.taskStatus isEqualToString:@"8"]) {
        
        status = @"已完成";
        self.deleteBtn.hidden = YES;
        self.changeBtn.hidden = YES;
    }
    
    if ([_dataModel.taskStatus isEqualToString:@"9"]) {
        
        status = @"完结";
        self.deleteBtn.hidden = YES;
        self.changeBtn.hidden = YES;
    }
    
    self.state.text = status;
    
    
}

@end
