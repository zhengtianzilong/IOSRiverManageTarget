//
//  ZLGetAssignTaskListService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/21.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLGetAssignTaskListService.h"
@interface ZLGetAssignTaskListService (){
    NSInteger _pageSize;
    NSInteger _currentPage;
    NSString *_assignName;
    NSString *_assignStartTime;
    NSString *_assignEndTime;
    NSString *_completeStartTime;
    NSString *_completeEndTime;
    NSString *_departName;
    NSString *_userName;
    NSString *_startTime;
}

@end
@implementation ZLGetAssignTaskListService

- (instancetype)initWithpageSize:(NSInteger)pageSize
                     currentPage:(NSInteger)currentPage
                      assignName:(NSString *)assignName
                 assignStartTime:(NSString *)assignStartTime
                   assignEndTime:(NSString *)assignEndTime
               completeStartTime:(NSString *)completeStartTime
                 completeEndTime:(NSString *)completeEndTime
                      departName:(NSString *)departName
                        userName:(NSString *)userName
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
        _departName= departName;
        _userName= userName;
        _startTime = startTime;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_GetAssignTaskListUrl;
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
                         _departName,@"departName",
                         _userName,@"userName",
                         _startTime,@"startTime",
                         nil];
    return dic;
    
}
@end
