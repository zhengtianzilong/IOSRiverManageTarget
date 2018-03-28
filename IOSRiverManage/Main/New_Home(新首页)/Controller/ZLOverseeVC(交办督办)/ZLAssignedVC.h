//
//  ZLAssignedVC.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/6.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseCustomNavViewController.h"
#import "ZLQueryAssignedView.h"
#import "ZLOverSeeTableViewCell.h"
#import "ZLOverSeeDetailVC.h"
@interface ZLAssignedVC : ZLBaseCustomNavViewController
@property (nonatomic, strong) ZLQueryAssignedView *queryView;
@property (nonatomic, strong) UITableView *mainTableView;
@end
