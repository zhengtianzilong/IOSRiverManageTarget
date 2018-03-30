//
//  ZLMyTaskWaitCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManageTableViewCell.h"
#import "ZLTaskWaitDataModel.h"
#import "ZLHomeWaitEventAndTaskDataModel.h"


typedef void(^dealBtnClickCallBlock)(NSString *taskId, UIButton *dealBtn);
@interface ZLMyTaskWaitCell : ZLEventManageTableViewCell
@property (nonatomic, strong) ZLTaskWaitDataModel *dataModel;

@property (nonatomic, strong) ZLHomeWaitEventAndTaskDataModel *homeDataModel;

@property (nonatomic, strong) dealBtnClickCallBlock dealClick;

@property (nonatomic, strong) NSString *taskId;

/**
 处理按钮
 */
@property (nonatomic, strong) UIButton *dealBtn;

@end
