//
//  ZLMyTaskChangAndDeleteCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManageTableViewCell.h"
#import "ZLTaskManageDataModel.h"

typedef void(^deleteBtnClickCallBack)(ZLTaskManageDataModel *model);

typedef void(^changeBtnClickCallBack)(ZLTaskManageDataModel *model);

@interface ZLMyTaskChangAndDeleteCell : ZLEventManageTableViewCell

@property (nonatomic, strong) ZLTaskManageDataModel *dataModel;

@property (nonatomic, strong) deleteBtnClickCallBack deleteClick;

@property (nonatomic, strong) changeBtnClickCallBack changeClick;

/**
 修改按钮
 */
@property (nonatomic, strong) UIButton *changeBtn;

/**
 删除按钮
 */
@property (nonatomic, strong) UIButton *deleteBtn;

@end
