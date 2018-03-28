//
//  ZLNewAddressBookService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/15.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewAddressBookService.h"

@implementation ZLNewAddressBookService

- (NSString *)requestUrl {
    return River_UserContactsUrl;
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

@end
