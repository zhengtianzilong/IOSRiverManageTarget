//
//  ZLMyWaitWorkVC.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//


#import "ZLBaseCustomNavViewController.h"
#import "ZLZLQueryEventDownView.h"
@interface ZLEventManagerReportVC : ZLBaseCustomNavViewController
@property (nonatomic, strong) ZLZLQueryEventDownView *queryView;
@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSString *userCode;

@end
