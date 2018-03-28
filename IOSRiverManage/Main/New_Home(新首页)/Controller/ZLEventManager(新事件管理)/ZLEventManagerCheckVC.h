//
//  ZLEventManagerCheckVC.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/17.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseCustomNavViewController.h"
#import "ZLQueryEventManagerCheckView.h"
#import "ZLMyEventCell.h"
#import "ZLMyEventDetailVC.h"
@interface ZLEventManagerCheckVC : ZLBaseCustomNavViewController
@property (nonatomic, strong) ZLQueryEventManagerCheckView *queryView;
@property (nonatomic, strong) UITableView *mainTableView;
@end
