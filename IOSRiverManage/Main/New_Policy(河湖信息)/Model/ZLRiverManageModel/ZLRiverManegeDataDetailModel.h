//
//  ZLRiverManegeDataDetailModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ZLRIverPeopleDataModel.h"
#import "ZLRiverPeopleLowerModel.h"
@interface ZLRiverManegeDataDetailModel : JSONModel

@property (nonatomic, strong) NSArray<ZLRiverPeopleLowerModel, Optional> *lowerRiverManage;

@property (nonatomic, strong) NSArray<ZLRIverPeopleDataModel, Optional> *riverManage;

@end
