//
//  ZLTaskMyAlreadyWorkVC.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLQueryEventManagerAlreadyView.h"
#import "ZLBaseCustomNavViewController.h"

@interface ZLTaskMyAlreadyWorkVC : ZLBaseCustomNavViewController
@property (nonatomic, strong) ZLQueryEventManagerAlreadyView *queryView;
@property (nonatomic, strong) UITableView *mainTableView;
@end
