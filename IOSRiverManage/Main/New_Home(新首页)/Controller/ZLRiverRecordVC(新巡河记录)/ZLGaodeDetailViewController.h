//
//  ZLGaodeDetailViewController.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/20.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLBaseCustomNavViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "ZLRiverRecordDataModel.h"



@interface ZLGaodeDetailViewController : ZLBaseCustomNavViewController

@property (nonatomic, strong) ZLRiverRecordDataModel *recordModel;

@end
