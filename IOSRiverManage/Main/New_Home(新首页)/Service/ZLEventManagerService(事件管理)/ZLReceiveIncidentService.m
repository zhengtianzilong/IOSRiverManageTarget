//
//  ZLReceiveIncidentService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLReceiveIncidentService.h"
@interface ZLReceiveIncidentService (){
    NSString *_eventId;
    NSString *_riverIncidentDetailId;
}

@end
@implementation ZLReceiveIncidentService

- (instancetype)initWithriverIncidentDetailId:(NSString *)riverIncidentDetailId
                                      eventId:(NSString *)eventId{
    self = [super init];
    if (self) {
        _eventId = eventId;
        _riverIncidentDetailId = riverIncidentDetailId;
    }
    return self;
}

- (NSString *)requestUrl {
    return River_ReceiveIncidentForAppUrl;
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
                         _riverIncidentDetailId, @"riverIncidentDetailId",
                         _eventId, @"id",
                         nil];
    return dic;
    
}
@end
