//
//  ZLLoginModel.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/18.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLLoginModel.h"

@implementation ZLLoginModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
        _timeStamp = [aDecoder decodeObjectForKey:@"timeStamp"];
        _realName =[aDecoder decodeObjectForKey:@"realName"];
        _signature =[aDecoder decodeObjectForKey:@"signature"];
        _levelName =[aDecoder decodeObjectForKey:@"levelName"];
        _ret_code =[aDecoder decodeObjectForKey:@"ret_code"];
        _userId =[aDecoder decodeObjectForKey:@"userId"];
        _ret_data =[aDecoder decodeObjectForKey:@"ret_data"];
        _type = [aDecoder decodeObjectForKey:@"type"];
        _version = [aDecoder decodeObjectForKey:@"version"];
        
    }
    return self;
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_timeStamp forKey:@"timeStamp"];
    [aCoder encodeObject:_realName forKey:@"realName"];
    [aCoder encodeObject:_signature forKey:@"signature"];
    [aCoder encodeObject:_levelName forKey:@"levelName"];
    [aCoder encodeObject:_ret_code forKey:@"ret_code"];
    [aCoder encodeObject:_userId forKey:@"userId"];
    [aCoder encodeObject:_ret_data forKey:@"ret_data"];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_version forKey:@"version"];
}

@end
