//
//  ZLMyTaskAlreadyCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyTaskAlreadyCell.h"

@implementation ZLMyTaskAlreadyCell

- (void)setUpUI{
    [super setUpUI];
    
    self.colorIndicator.image = [UIImage imageNamed:@"task_point"];
    
    self.initiatorLabel.text = @"创建人：";
    self.receivedLabel.text = @"执行人：";
    self.state.textColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
}

- (void)setDataModel:(ZLTaskAlreadyDataModel *)dataModel{
    
    _dataModel = dataModel;
    self.initiatorName.text = _dataModel.createName;
    self.receivedName.text = _dataModel.userName;
    
    if (_dataModel.taskContent) {
         self.content.text = _dataModel.taskContent;
    }else{
         self.content.text = @" ";
    }
    
   
    
    self.title.text = _dataModel.taskName;
    
    NSString *status = @"";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImage_URL,_dataModel.fileAddr]];
    
    [self.imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"event_placeImage"]];
    
    
    if ([_dataModel.status isEqualToString:@"0"]) {
        status = @"已创建";
    }
    if ([_dataModel.status isEqualToString:@"1"]) {
        status = @"已下发";
    }
    if ([_dataModel.status isEqualToString:@"2"]) {
        status = @"已接收";
    }
    if ([_dataModel.status isEqualToString:@"3"]) {
        status = @"已转发";
       
    }
    if ([_dataModel.status isEqualToString:@"6"]) {
        status = @"已反馈";
    }
    if ([_dataModel.status isEqualToString:@"7"]) {
        status = @"已驳回";
    }
    if ([_dataModel.status isEqualToString:@"8"]) {
        status = @"已完成";
    }
    
    if ([_dataModel.status isEqualToString:@"9"]) {
        status = @"完结";
    }
    
    NSString *time = _dataModel.createTime;
    
    //    NSString *timeString = [ZLUtility getDateByTimestamp:[time longLongValue] / 1000 type:4];
    self.timeLabel.text = time;
    self.state.text = status;
    
    
}


- (void)setCheckDataModel:(ZLTaskCheckDataModel *)checkDataModel{
    
    _checkDataModel = checkDataModel;
    self.initiatorName.text = _checkDataModel.createName;
    self.receivedName.text = _checkDataModel.userName;
    
    if (_checkDataModel.taskContent) {
        self.content.text = _checkDataModel.taskContent;
    }else{
        self.content.text = @" ";
    }
    
    
    
    self.title.text = _checkDataModel.taskName;
    
    NSString *status = @"";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImage_URL,_checkDataModel.fileAddr]];
    
    [self.imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"event_placeImage"]];
    
    
    if ([_checkDataModel.taskStatus isEqualToString:@"0"]) {
        status = @"已创建";
    }
    if ([_checkDataModel.taskStatus isEqualToString:@"1"]) {
        status = @"已下发";
    }
    if ([_checkDataModel.taskStatus isEqualToString:@"2"]) {
        status = @"已接收";
    }
    if ([_checkDataModel.taskStatus isEqualToString:@"3"]) {
        status = @"已转发";
        
    }
    if ([_checkDataModel.taskStatus isEqualToString:@"6"]) {
        status = @"已反馈";
    }
    if ([_checkDataModel.taskStatus isEqualToString:@"7"]) {
        status = @"已驳回";
    }
    if ([_checkDataModel.taskStatus isEqualToString:@"8"]) {
        status = @"已完成";
    }
    
    if ([_checkDataModel.taskStatus isEqualToString:@"9"]) {
        status = @"完结";
    }
    
    NSString *time = _checkDataModel.createTime;
    
    //    NSString *timeString = [ZLUtility getDateByTimestamp:[time longLongValue] / 1000 type:4];
    self.timeLabel.text = time;
    self.state.text = status;
    
    
}




@end
