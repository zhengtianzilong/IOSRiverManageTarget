//
//  ZLBaiduTrackViewController.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/16.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLBaseCustomNavViewController.h"

@interface ZLBaiduTrackViewController : ZLBaseCustomNavViewController

@property (nonatomic, strong) NSString *uid;

/**
 巡河任务ID
 */
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *type;

@end
