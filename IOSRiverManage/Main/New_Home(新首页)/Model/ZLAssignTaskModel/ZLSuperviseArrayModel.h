//
//  ZLSuperviseArrayModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ZLSuperviseDetailDataModel.h"
#import "ZLAssignTaskDetailDataModel.h"
@interface ZLSuperviseArrayModel : JSONModel

@property (nonatomic, strong) NSArray<Optional,ZLAssignTaskDetailDataModel > *assignTaskList;

@property (nonatomic, strong) ZLSuperviseDetailDataModel *superviseTask;


@end
