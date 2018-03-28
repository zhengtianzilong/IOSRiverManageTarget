//
//  ZLTaskWaitVC.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//


#import "ZLQueryEventManageView.h"
#import "ZLMyEventCell.h"
#import "ZLTaskDetailVC.h"
@interface ZLTaskWaitVC : ZLBaseCustomNavViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) ZLQueryEventManageView *queryView;
@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSString *taskName;

@property (nonatomic, strong) NSString *createStartTime;
@property (nonatomic, strong) NSString *createEndTime;

@end
