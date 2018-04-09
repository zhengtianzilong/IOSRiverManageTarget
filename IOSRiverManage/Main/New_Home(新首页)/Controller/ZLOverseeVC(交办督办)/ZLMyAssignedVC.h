//
//  ZLMyAssignedVC.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/8.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseCustomNavViewController.h"
#import "ZLQueryMyAssignedView.h"
#import "ZLOverSeeTableViewCell.h"
#import "ZLOverSeeDetailVC.h"

@interface ZLMyAssignedVC : ZLBaseCustomNavViewController
@property (nonatomic, strong) ZLQueryMyAssignedView *queryView;
@property (nonatomic, strong) UITableView *mainTableView;
@end
