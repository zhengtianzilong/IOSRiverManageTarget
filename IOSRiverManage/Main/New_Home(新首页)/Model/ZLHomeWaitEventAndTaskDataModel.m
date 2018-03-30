//
//  ZLHomeWaitEventAndTaskModel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/30.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLHomeWaitEventAndTaskDataModel.h"

@implementation ZLHomeWaitEventAndTaskDataModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id" : @"ID"}];
}

@end
