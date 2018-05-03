//
//  ZLRiverPatrolInfoModel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverPatrolInfoModel.h"

@implementation ZLRiverPatrolInfoModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"id" : @"ID"}];
}

@end
