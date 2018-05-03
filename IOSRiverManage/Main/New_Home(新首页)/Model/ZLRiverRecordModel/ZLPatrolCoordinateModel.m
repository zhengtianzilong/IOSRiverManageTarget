//
//  ZLPatrolCoordinateModel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/20.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLPatrolCoordinateModel.h"

@implementation ZLPatrolCoordinateModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"id" : @"ID"}];
}

@end
