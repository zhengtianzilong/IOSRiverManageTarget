//
//  ZLNewAddressBookGetRiversService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/15.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewAddressBookGetRiversService.h"
@interface ZLNewAddressBookGetRiversService (){
    NSString *_userCode;
}

@end
@implementation ZLNewAddressBookGetRiversService

- (instancetype)initWithUserCode:(NSString *)userCode{
    self = [super init];
    if (self) {
        
        _userCode = userCode;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_GetRiverNamesByUserUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}



- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeHTTP;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeHTTP;
}

- (id)requestArgument{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _userCode,@"userCode",
                         nil];
    return dic;
    
}



@end
