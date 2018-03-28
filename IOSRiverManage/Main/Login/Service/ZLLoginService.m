//
//  ZLLoginService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/15.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLLoginService.h"
//#import "NetUrl.h"
@interface ZLLoginService (){
    NSString *_userName;
    NSString *_passworld;
}

@end
@implementation ZLLoginService

- (instancetype)initWithuserName:(NSString *)userName
                       passworld:(NSString *)passworld{
    self = [super init];
    if (self) {

        [self getTime];
        
        _userName = userName;
        _passworld = passworld;
        
    }
    return self;
}
- (NSString *)requestUrl {
    return River_LoginUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}



- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeHTTP;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeHTTP;
}

- (id)requestArgument{
    
    // 20180311+singon
    NSString *time = [NSString stringWithFormat:@"%@%@",self.baseTime, @"singon"];
    
    NSString *md5Sign = [self md5StringFromString:time];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _userName,@"name",
                          [self md5StringFromString:_passworld],@"password",
                          md5Sign,@"sign",
                         nil];
    return dic;
    
}





@end

