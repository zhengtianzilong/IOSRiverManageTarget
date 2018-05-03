//
//  ZLRiverDemandModel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/21.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLRiverDemandModel.h"

@implementation ZLRiverDemandModel

+ (JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"id":@"riverId"}];
    
}
@end
