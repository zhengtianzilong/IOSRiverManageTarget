//
//  ZLHaveExamineService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLHaveExamineService.h"

@implementation ZLHaveExamineService
- (NSString *)requestUrl {
    return River_HaveExamineServiceUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeHTTP;
}
@end
