//
//  ZLTaskIncidentListModel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLTaskIncidentListModel.h"

@implementation ZLTaskIncidentListModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id" : @"ID",@"description":@"descri"}];
}

@end
