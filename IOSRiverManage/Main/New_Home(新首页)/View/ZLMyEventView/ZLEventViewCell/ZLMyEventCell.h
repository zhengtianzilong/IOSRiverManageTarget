//
//  ZLMyEventCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/1/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManageTableViewCell.h"

typedef void(^deleteBtnClick)(void);
typedef void(^changeBtnClick)(void);

@interface ZLMyEventCell : ZLEventManageTableViewCell
/**
 修改按钮
 */
@property (nonatomic, strong) UIButton *changeBtn;

/**
 删除按钮
 */
@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) deleteBtnClick deleteClick;

@property (nonatomic, strong) changeBtnClick changeClick;

@end
