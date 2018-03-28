//
//  ZLAssignTaskDetailService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/21.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLAssignTaskDetailService.h"
@interface ZLAssignTaskDetailService (){
    NSString *_code;
}

@end
@implementation ZLAssignTaskDetailService

- (instancetype)initWithCode:(NSString *)Code{
    self = [super init];
    if (self) {
        
        _code = Code;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_GetAssignTaskDetailUrl;
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
                         _code,@"id",
                         nil];
    return dic;
    
}
@end
