//
//  ZLRiverIncidentDetailListModel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/30.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverIncidentDetailListModel.h"

@implementation ZLRiverIncidentDetailListModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id" : @"ID"}];
}
@end
