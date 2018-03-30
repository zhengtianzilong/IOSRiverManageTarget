//
//  ZLGetMyToDoTaskAndIncidentListService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/30.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLGetMyToDoTaskAndIncidentListService.h"
@interface ZLGetMyToDoTaskAndIncidentListService (){
    NSInteger _pageSize;
    NSString *_appPageCreateTime;
}

@end
@implementation ZLGetMyToDoTaskAndIncidentListService

- (instancetype)initWithpageSize:(NSInteger)pageSize
               appPageCreateTime:(NSString *)appPageCreateTime{
    self = [super init];
    if (self) {
        
        _pageSize = pageSize;
        _appPageCreateTime = appPageCreateTime;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_GetMyToDoTaskAndIncidentListUrl;
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

- (id)requestArgument{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _appPageCreateTime,@"appPageCreateTime",
                         @(_pageSize),@"pageSize",
                         nil];
    return dic;
    
}
@end
