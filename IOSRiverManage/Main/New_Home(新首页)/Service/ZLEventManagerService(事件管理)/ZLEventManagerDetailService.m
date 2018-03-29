//
//  ZLEventManagerDetailService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManagerDetailService.h"
@interface ZLEventManagerDetailService (){
    NSString *_eventId;
}

@end
@implementation ZLEventManagerDetailService

- (instancetype)initWitheventId:(NSString *)eventId{
    self = [super init];
    if (self) {
        _eventId = eventId;
    }
    return self;
}

- (NSString *)requestUrl {
    return River_GetIncidentAllUrl;
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
                         _eventId, @"id",
                         nil];
    return dic;
    
}
@end
