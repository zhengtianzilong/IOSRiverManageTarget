//
//  ZLRiverBaseInfoService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverBaseInfoService.h"

@interface ZLRiverBaseInfoService (){
    NSString *_riverCode;
}

@end
@implementation ZLRiverBaseInfoService

- (instancetype)initWithriverCode:(NSString *)riverCode{
    self = [super init];
    if (self) {
        
        _riverCode = riverCode;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_GetRiverInfoByRiverCodeUrl;
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
