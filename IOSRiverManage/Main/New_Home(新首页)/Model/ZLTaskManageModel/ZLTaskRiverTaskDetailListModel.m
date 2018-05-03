//
//  ZLTaskRiverTaskDetailListModel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLTaskRiverTaskDetailListModel.h"

@implementation ZLTaskRiverTaskDetailListModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"id" : @"ID"}];
}
@end
