//
//  ZLGetUserListByTaskNormalService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLGetUserListByTaskNormalService.h"

@implementation ZLGetUserListByTaskNormalService
- (NSString *)requestUrl {
    return River_GetUserListByTaskNormalUrl;
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
