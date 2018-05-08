//
//  ZLTaskFeedBackDataModel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLTaskFeedBackDataModel.h"

@implementation ZLTaskFeedBackDataModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"ID" : @"id"}];
}
@end
