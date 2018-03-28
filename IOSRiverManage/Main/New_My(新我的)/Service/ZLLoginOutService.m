//
//  ZLLoginOutService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/23.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLLoginOutService.h"
@implementation ZLLoginOutService
- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}


- (NSString *)requestUrl {
    return River_LoginOutUrl;
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

@end
