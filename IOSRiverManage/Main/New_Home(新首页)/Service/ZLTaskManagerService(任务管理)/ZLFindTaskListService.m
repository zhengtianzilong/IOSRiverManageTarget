//
//  ZLFindTaskListService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLFindTaskListService.h"
@interface ZLFindTaskListService (){
    NSInteger _pageSize;
    NSString *_createTimeFormat;
    NSString *_taskName;
    NSString *_createStartTime;
    NSString *_createEndTime;
    NSString *_createName;
    NSString *_completeStartTime;
    NSString *_completeEndTime;
    NSString *_userName;
    NSString *_taskStatus;
}

@end
@implementation ZLFindTaskListService

- (instancetype)initWithpageSize:(NSInteger)pageSize
                createTimeFormat:(NSString *)createTimeFormat
                        taskName:(NSString *)taskName
                      createName:(NSString *)createName
                 createStartTime:(NSString *)createStartTime
                   createEndTime:(NSString *)createEndTime
               completeStartTime:(NSString *)completeStartTime
                 completeEndTime:(NSString *)completeEndTime
                        userName:(NSString *)userName
                      taskStatus:(NSString *)taskStatus{
    self = [super init];
    if (self) {
        _pageSize = pageSize;
        _createTimeFormat = createTimeFormat;
        _taskName = taskName;
        _createStartTime = createStartTime;
        _createEndTime = createEndTime;
        _createName = createName;
        _completeStartTime = completeStartTime;
        _completeEndTime = completeEndTime;
        
        _userName = userName;
        _taskStatus = taskStatus;
        
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_FindTaskListUrl;
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
                         @(_pageSize),@"pageSize",
                         _createTimeFormat, @"createTimeFormat",
                         _taskName , @"taskName",
                         _createStartTime, @"createStartTime",
                         _createEndTime, @"createEndTime",
                         _completeEndTime, @"completeEndTime",
                         _completeStartTime, @"completeStartTime",
                         _createName, @"createName",
                         _userName, @"userName",
                         _taskStatus, @"taskStatus",
                         nil];
    return dic;
    
}
@end
