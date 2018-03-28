//
//  ZLEventObjectModel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/22.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLEventObjectModel.h"

@implementation ZLEventObjectModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_idObject forKey:@"idObject"];
    [aCoder encodeObject:_realname  forKey:@"realName"];
    [aCoder encodeObject:_departname  forKey:@"departname"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
        _idObject = [aDecoder decodeObjectForKey:@"idObject"];
        _realname = [aDecoder decodeObjectForKey:@"realName"];
        _departname = [aDecoder decodeObjectForKey:@"departname"];
        
    }
    return self;
    
}
+ (JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"idObject"}];
    
}

@end
