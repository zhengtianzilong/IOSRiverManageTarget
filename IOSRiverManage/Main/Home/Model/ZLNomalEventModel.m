//
//  ZLNomalEventModel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/22.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLNomalEventModel.h"

@implementation ZLNomalEventModel
+ (JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"riverId",
                                                      @"operator":@"operatorID"}];
    
}
@end
