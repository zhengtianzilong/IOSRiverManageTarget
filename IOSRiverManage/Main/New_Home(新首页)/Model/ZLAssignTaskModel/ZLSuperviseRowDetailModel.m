//
//  ZLSuperviseDetailDataNodel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLSuperviseRowDetailModel.h"

@implementation ZLSuperviseRowDetailModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"ID" : @"id"}];
}
@end
