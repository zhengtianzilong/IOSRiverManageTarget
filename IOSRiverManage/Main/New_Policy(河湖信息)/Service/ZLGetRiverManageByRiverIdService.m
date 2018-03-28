//
//  ZLGetRiverManageByRiverIdService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLGetRiverManageByRiverIdService.h"
@interface ZLGetRiverManageByRiverIdService (){
    NSString *_riverId;
}

@end
@implementation ZLGetRiverManageByRiverIdService

- (instancetype)initWithriverId:(NSString *)riverId{
    self = [super init];
    if (self) {
        
        _riverId = riverId;
        
    }
    return self;
}

- (NSString *)requestUrl {
    return River_GetRiverManageByRiverIdUrl;
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
                         _riverId,@"riverId",
                         nil];
    return dic;
}
@end
