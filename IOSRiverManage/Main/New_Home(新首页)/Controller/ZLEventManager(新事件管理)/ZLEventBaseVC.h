//
//  ZLEventBaseVC.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/5.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseCustomNavViewController.h"
#import "ZLQueryEventManageView.h"
#import "ZLMyEventCell.h"
#import "ZLMyEventDetailVC.h"
@interface ZLEventBaseVC : ZLBaseCustomNavViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ZLQueryEventManageView *queryView;
@property (nonatomic, strong) UITableView *mainTableView;

- (void)setCell;

- (NSInteger)setSectionsCount;

@end
