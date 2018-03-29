//
//  ZLEventManagerAlreadyService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManagerAlreadyService.h"
@interface ZLEventManagerAlreadyService (){
    NSInteger _pageSize;
    NSString *_appPageCreateTime;
    NSString *_incidentName;
    NSString *_createBeginTime;
    NSString *_createEndTime;
    NSString *_createUserName;
    NSString *_updateBeginTime;
    NSString *_updateEndTime;
}

@end
@implementation ZLEventManagerAlreadyService

- (instancetype)initWithpageSize:(NSInteger)pageSize
                    incidentName:(NSString *)incidentName
                  createUserName:(NSString *)createUserName
                 createBeginTime:(NSString *)createBeginTime
                   createEndTime:(NSString *)createEndTime
               appPageCreateTime:(NSString *)appPageCreateTime
                 updateBeginTime:(NSString *)updateBeginTime
                   updateEndTime:(NSString *)updateEndTime{
    self = [super init];
    if (self) {
        _pageSize = pageSize;
        _appPageCreateTime = appPageCreateTime;
        _incidentName = incidentName;
        _createBeginTime = createBeginTime;
        _createEndTime = createEndTime;
        _createUserName = createUserName;
        _updateBeginTime = updateBeginTime;
        _updateEndTime = updateEndTime;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_GetMyHaveDoIncidentListUrl;
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
                         _appPageCreateTime, @"appPageCreateTime",
                         _incidentName , @"incidentName",
                         _createBeginTime, @"createBeginTime",
                         _createUserName, @"createUserName",
                         _updateBeginTime, @"updateBeginTime",
                         _updateEndTime, @"updateEndTime",
                         _createEndTime, @"createEndTime",nil];
    return dic;
    
}
@end
