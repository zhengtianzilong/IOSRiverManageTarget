//
//  ZLDeleteTasksService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLDeleteTasksService.h"
@interface ZLDeleteTasksService (){
    NSString *_taskId;
}

@end
@implementation ZLDeleteTasksService

- (instancetype)initWithtaskId:(NSString *)taskId{
    self = [super init];
    if (self) {
        _taskId = taskId;
    }
    return self;
}

- (NSString *)requestUrl {
    return River_DeleteTasksUrl;
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
                         _taskId, @"taskId",
                         nil];
    return dic;
    
}
@end
