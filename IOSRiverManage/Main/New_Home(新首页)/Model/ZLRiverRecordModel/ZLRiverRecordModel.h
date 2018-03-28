//
//  ZLRiverRecordModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/20.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"
#import "ZLRiverRecordDataModel.h"
@interface ZLRiverRecordModel : ZLBaseModel

@property (nonatomic, strong) NSArray<Optional, ZLRiverRecordDataModel> *data;

@end
