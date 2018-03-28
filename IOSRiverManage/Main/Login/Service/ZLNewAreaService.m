//
//  ZLNewAreaService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/14.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewAreaService.h"

@implementation ZLNewAreaService

- (NSString *)requestUrl {
    return River_AreaListUrl;
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
