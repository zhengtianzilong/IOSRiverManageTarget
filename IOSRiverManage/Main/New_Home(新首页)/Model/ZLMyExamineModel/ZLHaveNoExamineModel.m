//
//  ZLHaveNoExamineModel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLHaveNoExamineModel.h"

@implementation ZLHaveNoExamineModel
+ (JSONKeyMapper *)keyMapper
{
    
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"ID" : @"id"}];
}
@end
