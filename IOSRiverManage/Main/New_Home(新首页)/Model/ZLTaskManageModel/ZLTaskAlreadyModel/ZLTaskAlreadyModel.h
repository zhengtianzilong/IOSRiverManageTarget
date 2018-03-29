//
//  ZLTaskAlreadyModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"
#import "ZLTaskAlreadyDataModel.h"
@interface ZLTaskAlreadyModel : ZLBaseModel

@property (nonatomic, strong) NSArray<Optional, ZLTaskAlreadyDataModel> *data;

@end
