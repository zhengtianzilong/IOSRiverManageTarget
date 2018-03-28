//
//  ZLMyTaskWaitCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManageTableViewCell.h"
#import "ZLTaskWaitDataModel.h"

typedef void(^dealBtnClickCallBlock)(ZLTaskWaitDataModel *model, UIButton *dealBtn);

@interface ZLMyTaskWaitCell : ZLEventManageTableViewCell
@property (nonatomic, strong) ZLTaskWaitDataModel *dataModel;

@property (nonatomic, strong) dealBtnClickCallBlock dealClick;

/**
 处理按钮
 */
@property (nonatomic, strong) UIButton *dealBtn;

@end
