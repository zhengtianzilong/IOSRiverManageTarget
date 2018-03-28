//
//  ZLMyTaskWaitCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyTaskWaitCell.h"

@implementation ZLMyTaskWaitCell

- (void)setUpUI{
    
    [super setUpUI];
    
    self.colorIndicator.image = [UIImage imageNamed:@"task_point"];
    
    self.initiatorLabel.text = @"创建人:";
    self.receivedLabel.text = @"执行人";
    self.state.textColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    
}

@end
