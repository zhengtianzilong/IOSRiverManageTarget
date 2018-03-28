//
//  ZLAssignTaskDetailModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"

#import "ZLAssignTaskDetailDataModel.h"

@interface ZLAssignTaskDetailModel : ZLBaseModel

@property (nonatomic, strong) ZLAssignTaskDetailDataModel<Optional> *data;

@end
