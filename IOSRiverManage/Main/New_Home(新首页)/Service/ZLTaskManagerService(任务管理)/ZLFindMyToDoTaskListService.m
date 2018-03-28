//
//  ZLFindMyToDoTaskListService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLFindMyToDoTaskListService.h"
@interface ZLFindMyToDoTaskListService (){
    NSInteger _pageSize;
    NSString *_createTimeFormat;
    NSString *_taskName;
    NSString *_createStartTime;
    NSString *_createEndTime;
    NSString *_createName;
}

@end
@implementation ZLFindMyToDoTaskListService

- (instancetype)initWithpageSize:(NSInteger)pageSize
                createTimeFormat:(NSString *)createTimeFormat
                        taskName:(NSString *)taskName
                      createName:(NSString *)createName
                 createStartTime:(NSString *)createStartTime
                   createEndTime:(NSString *)createEndTime{
    self = [super init];
    if (self) {
        _pageSize = pageSize;
        _createTimeFormat = createTimeFormat;
        _taskName = taskName;
        _createStartTime = createStartTime;
        _createEndTime = createEndTime;
        _createName = createName;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_FindMyToDoTaskListUrl;
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
                         _createName, @"createName",
                         nil];
    return dic;
    
}
@end
