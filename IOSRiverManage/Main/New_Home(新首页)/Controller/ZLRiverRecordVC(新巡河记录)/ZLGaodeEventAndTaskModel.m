//
//  ZLGaodeEventAndTaskModel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLGaodeEventAndTaskModel.h"

@implementation ZLGaodeEventAndTaskModel

- (instancetype)initWithtitle:(NSString *)title content:(NSString *)content riverPeople:(NSString *)riverPeople time:(NSString *)time type:(NSString *)type ID:(NSString *)ID{
    
    if (self = [super init]) {
        _title = title;
        _content = content;
        _riverPeople = riverPeople;
        _time = time;
        _type = type;
        _ID = ID;
        
    }
    return self;
    
}


@end
