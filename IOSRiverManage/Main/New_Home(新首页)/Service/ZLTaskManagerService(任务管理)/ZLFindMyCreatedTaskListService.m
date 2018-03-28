//
//  ZLFindMyCreatedTaskListService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLFindMyCreatedTaskListService.h"
@interface ZLFindMyCreatedTaskListService (){
    NSInteger _pageSize;
    NSString *_createTimeFormat;
    NSString *_taskName;
    NSString *_createStartTime;
    NSString *_createEndTime;
}

@end
@implementation ZLFindMyCreatedTaskListService

- (instancetype)initWithpageSize:(NSInteger)pageSize
                createTimeFormat:(NSString *)createTimeFormat
                        taskName:(NSString *)taskName
                 createStartTime:(NSString *)createStartTime
                   createEndTime:(NSString *)createEndTime{
    self = [super init];
    if (self) {
        _pageSize = pageSize;
        _createTimeFormat = createTimeFormat;
        _taskName = taskName;
        _createStartTime = createStartTime;
        _createEndTime = createEndTime;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_FindMyCreatedTaskListUrl;
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
                         _createEndTime, @"createEndTime",nil];
    return dic;
    
}
@end
