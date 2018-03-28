//
//  ZLRiverIncidentDetailModel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/20.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverIncidentDetailModel.h"

@implementation ZLRiverIncidentDetailModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id" : @"ID"}];
}

@end
