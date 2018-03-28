//
//  ZLTaskManagerModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"
#import "ZLTaskManageDataModel.h"
@interface ZLTaskManagerModel : ZLBaseModel

@property (nonatomic, strong) NSArray<Optional, ZLTaskManageDataModel> *data;

@end
