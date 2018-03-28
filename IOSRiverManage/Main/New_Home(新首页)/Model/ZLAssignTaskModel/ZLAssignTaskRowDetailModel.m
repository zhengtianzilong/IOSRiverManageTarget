//
//  ZLAssignTaskRowDetailModel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/21.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLAssignTaskRowDetailModel.h"

@implementation ZLAssignTaskRowDetailModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id" : @"ID"}];
}

@end
