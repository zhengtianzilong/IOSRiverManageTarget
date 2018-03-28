//
//  ZLTaskMyLauchVC.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLZLQueryEventDownView.h"
#import "ZLMyEventCell.h"
#import "ZLMyEventDetailVC.h"
@interface ZLTaskMyDownVC : ZLBaseCustomNavViewController
@property (nonatomic, strong) ZLZLQueryEventDownView *queryView;
@property (nonatomic, strong) UITableView *mainTableView;

@end
