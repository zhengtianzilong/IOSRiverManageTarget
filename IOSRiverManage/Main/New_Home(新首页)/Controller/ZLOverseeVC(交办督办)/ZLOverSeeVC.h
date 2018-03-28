//
//  ZLOverSeeVC.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/6.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseCustomNavViewController.h"
#import "ZLQueryOverSeeView.h"
#import "ZLSuperviseTableViewCell.h"
#import "ZLSuperviseDetailVC.h"
@interface ZLOverSeeVC : ZLBaseCustomNavViewController
@property (nonatomic, strong) ZLQueryOverSeeView *queryView;
@property (nonatomic, strong) UITableView *mainTableView;
@end
