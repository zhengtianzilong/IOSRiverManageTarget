//
//  ZLPumpingPortDeleteService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLPumpingPortDeleteService.h"
@interface ZLPumpingPortDeleteService (){
    NSString *_idCode;
}

@end
@implementation ZLPumpingPortDeleteService

- (instancetype)initWithidCode:(NSString *)idCode{
    self = [super init];
    if (self) {
        
        _idCode = idCode;
        
    }
    return self;
}


- (NSString *)requestUrl {
    
    return River_PumpingPortDeleteUrl;
    
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
                         _idCode,@"id",
                         nil];
    return dic;
    
}
@end
