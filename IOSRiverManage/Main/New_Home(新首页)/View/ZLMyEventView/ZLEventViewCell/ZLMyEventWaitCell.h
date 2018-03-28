//
//  ZLMyEventWaitCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/23.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManageTableViewCell.h"
typedef void(^dealBtnClick)(void);
@interface ZLMyEventWaitCell : ZLEventManageTableViewCell
/**
 处理按钮
 */
@property (nonatomic, strong) UIButton *dealBtn;

@property (nonatomic, strong) dealBtnClick dealClick;
@end
