//
//  ZLGetMyAssignTaskListService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/8.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLGetMyAssignTaskListService.h"
@interface ZLGetMyAssignTaskListService (){
    NSInteger _pageSize;
    NSInteger _currentPage;
    NSString *_assignName;
    NSString *_assignStartTime;
    NSString *_assignEndTime;
    NSString *_completeStartTime;
    NSString *_completeEndTime;
    NSString *_startTime;
}

@end
@implementation ZLGetMyAssignTaskListService

- (instancetype)initWithpageSize:(NSInteger)pageSize
                     currentPage:(NSInteger)currentPage
                      assignName:(NSString *)assignName
                 assignStartTime:(NSString *)assignStartTime
                   assignEndTime:(NSString *)assignEndTime
               completeStartTime:(NSString *)completeStartTime
                 completeEndTime:(NSString *)completeEndTime
                       startTime:(NSString *)startTime{
    self = [super init];
    if (self) {
        
        _pageSize= pageSize;
        _currentPage= currentPage;
        _assignName= assignName;
        _assignStartTime= assignStartTime;
        _assignEndTime= assignEndTime;
        _completeStartTime= completeStartTime;
        _completeEndTime= completeEndTime;
        _startTime = startTime;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_GetMyAssignTaskListUrl;
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
                         @(_currentPage),@"currentPage",
                         @(_pageSize),@"pageSize",
                         _assignName,@"assignName",
                         _assignStartTime,@"assignStartTime",
                         _assignEndTime,@"assignEndTime",
                         _completeStartTime,@"completeStartTime",
                         _completeEndTime,@"completeEndTime",
                         _startTime,@"startTime",
                         nil];
    return dic;
    
}
@end
