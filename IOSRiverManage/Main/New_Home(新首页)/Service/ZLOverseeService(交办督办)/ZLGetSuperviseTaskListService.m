//
//  ZLGetSuperviseTaskListService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLGetSuperviseTaskListService.h"
@interface ZLGetSuperviseTaskListService (){
    NSInteger _pageSize;
    NSInteger _currentPage;
    NSString *_superviseName;
    NSString *_assignCode;
    NSString *_superviseUnit;
    NSString *_departName;
    NSString *_userName;
    NSString *_startTime;
    NSString *_superviseStartTime;
    NSString *_superviseEndTime;
    
}

@end
@implementation ZLGetSuperviseTaskListService

- (instancetype)initWithpageSize:(NSInteger)pageSize
                     currentPage:(NSInteger)currentPage
                   superviseName:(NSString *)superviseName
                      assignCode:(NSString *)assignCode
                   superviseUnit:(NSString *)superviseUnit
                      departName:(NSString *)departName
                        userName:(NSString *)userName
                       startTime:(NSString *)startTime
              superviseStartTime:(NSString *)superviseStartTime
                superviseEndTime:(NSString *)superviseEndTime{
    self = [super init];
    if (self) {
        
        _pageSize= pageSize;
        _currentPage= currentPage;
        _superviseName= superviseName;
        _assignCode= assignCode;
        _superviseUnit= superviseUnit;
        _departName= departName;
        _userName= userName;
        _startTime = startTime;
        _superviseEndTime = superviseEndTime;
        _superviseStartTime = superviseStartTime;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_GetSuperviseTaskListUrl;
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
                         _superviseName,@"superviseName",
                         _assignCode,@"assignCode",
                         _superviseUnit,@"superviseUnit",
                         _departName,@"departName",
                         _userName,@"userName",
                         _startTime,@"startTime",
                         _superviseStartTime,@"superviseStartTime",
                         _superviseEndTime,@"superviseEndTime",
                         nil];
    return dic;
    
}
@end
