//
//  ZLSuperviseDetailService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLSuperviseDetailService.h"
@interface ZLSuperviseDetailService (){
    NSString *_code;
}

@end
@implementation ZLSuperviseDetailService

- (instancetype)initWithCode:(NSString *)Code{
    self = [super init];
    if (self) {
        
        _code = Code;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_SuperviseDetailUrl;
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
