//
//  ZLTaskDetailVC.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseCustomNavViewController.h"

@interface ZLTaskDetailVC : ZLBaseCustomNavViewController

@property (nonatomic, strong) NSString *code;
- (void)getData;
// 从什么控制器传入
//@property (nonatomic, strong) NSString *passCode;

@end
