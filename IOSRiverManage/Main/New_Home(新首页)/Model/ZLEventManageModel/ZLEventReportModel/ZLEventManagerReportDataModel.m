//
//  ZLEventManagerReportDataModel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManagerReportDataModel.h"

@implementation ZLEventManagerReportDataModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id" : @"ID"}];
}
@end
