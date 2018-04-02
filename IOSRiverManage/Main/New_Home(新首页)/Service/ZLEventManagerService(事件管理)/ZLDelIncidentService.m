//
//  ZLDelIncidentService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLDelIncidentService.h"

@interface ZLDelIncidentService (){
    NSString *_eventId;
}

@end

@implementation ZLDelIncidentService

- (instancetype)initWitheventId:(NSString *)eventId{
    self = [super init];
    if (self) {
        _eventId = eventId;
    }
    return self;
}

- (NSString *)requestUrl {
    return River_DelIncidentForAppUrl;
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
                         _eventId, @"riverIncidentId",
                         nil];
    return dic;
    
}
@end
