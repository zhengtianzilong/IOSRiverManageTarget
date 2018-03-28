//
//  ZLRiverRecordAllPointModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/20.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"
#import "ZLRiverRecordAllPointDataModel.h"
@interface ZLRiverRecordAllPointModel : ZLBaseModel

@property (nonatomic, strong) ZLRiverRecordAllPointDataModel<Optional> *data;

@end
