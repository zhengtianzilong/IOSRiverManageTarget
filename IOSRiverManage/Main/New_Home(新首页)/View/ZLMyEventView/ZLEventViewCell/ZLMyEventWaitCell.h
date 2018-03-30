//
//  ZLMyEventWaitCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/23.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManageTableViewCell.h"
#import "ZLEventManagerReportDataModel.h"
#import "ZLHomeWaitEventAndTaskDataModel.h"
typedef void(^dealBtnClick)(NSString *eventId, UIButton *dealBtn);
@interface ZLMyEventWaitCell : ZLEventManageTableViewCell
/**
 处理按钮
 */
@property (nonatomic, strong) UIButton *dealBtn;

@property (nonatomic, strong) dealBtnClick dealClick;

@property (nonatomic, strong) ZLEventManagerReportDataModel *dataModel;

@property (nonatomic, strong) ZLHomeWaitEventAndTaskDataModel *homeDataModel;

@property (nonatomic, strong) NSString *eventId;

@end
