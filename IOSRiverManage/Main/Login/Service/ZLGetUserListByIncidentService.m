//
//  ZLGetUserListByIncidentService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLGetUserListByIncidentService.h"
@interface ZLGetUserListByIncidentService (){
    NSString *_riverCode;
}

@end
@implementation ZLGetUserListByIncidentService

- (instancetype)initWithriverCode:(NSString *)riverCode{
    self = [super init];
    if (self) {
        
        _riverCode = riverCode;
    }
    return self;
}
- (NSString *)requestUrl {
    return River_GetUserListByIncidentUrl;
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
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _riverCode,@"riverCode",
                         nil];
    return dic;
}

@end
