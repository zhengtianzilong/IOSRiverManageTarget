//
//  ZLTaskWaitModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"
#import "ZLTaskWaitDataModel.h"
@interface ZLTaskWaitModel : ZLBaseModel

@property (nonatomic, strong) NSArray<Optional, ZLTaskWaitDataModel> *data;

@end
