//
//  ZLMyAlreadyWorkVC.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//
#import "ZLBaseCustomNavViewController.h"
#import "ZLQueryEventManagerAlreadyView.h"
#import "ZLEventManageTableViewCell.h"
#import "ZLMyEventDetailVC.h"
@interface ZLEventManagerAlreadyVC : ZLBaseCustomNavViewController
@property (nonatomic, strong) ZLQueryEventManagerAlreadyView *queryView;
@property (nonatomic, strong) UITableView *mainTableView;
@end
