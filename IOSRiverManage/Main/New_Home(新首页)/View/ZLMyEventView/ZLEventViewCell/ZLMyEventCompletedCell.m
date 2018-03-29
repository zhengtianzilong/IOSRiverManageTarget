//
//  ZLMyEventCompletedCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/23.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyEventCompletedCell.h"

@implementation ZLMyEventCompletedCell

- (void)setDataModel:(ZLEventManagerReportDataModel *)dataModel{
    
    _dataModel = dataModel;
    self.initiatorName.text = _dataModel.createName;
    self.receivedName.text = _dataModel.userName;
    self.content.text = _dataModel.incidentContent;
    self.timeLabel.text = _dataModel.createTime;
    self.title.text = _dataModel.incidentName;
    
    NSString *status = @"";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImage_URL,_dataModel.imgUrl]];
    
    [self.imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"event_placeImage"]];
    
    if ([_dataModel.createBy isEqualToString:self.userCode]) {
        
        if ([_dataModel.incidentStatus isEqualToString:@"0"]) {
            status = @"创建";
        }
        if ([_dataModel.incidentStatus isEqualToString:@"1"]) {
            
            status = @"已上报";
            
        }
        if ([_dataModel.incidentStatus isEqualToString:@"2"]) {
            
            status = @"已接收";
        }
        if ([_dataModel.incidentStatus isEqualToString:@"3"]) {
            
            status = @"已转报";
        }
        if ([_dataModel.incidentStatus isEqualToString:@"9"]) {
            
            status = @"完结";
        }
    }else{
        if ([_dataModel.incidentStatus isEqualToString:@"0"]) {
            status = @"已创建";
        }
        if ([_dataModel.incidentStatus isEqualToString:@"1"]) {
            
            status = @"未接收";
    
            
        }
        if ([_dataModel.incidentStatus isEqualToString:@"2"]) {
            
            status = @"待处理";
        }
        if ([_dataModel.incidentStatus isEqualToString:@"3"]) {
            
            status = @"已转报";
        }
        if ([_dataModel.incidentStatus isEqualToString:@"9"]) {
            
            status = @"反馈";
            
        }
    }
    
    self.state.text = status;
}


@end
