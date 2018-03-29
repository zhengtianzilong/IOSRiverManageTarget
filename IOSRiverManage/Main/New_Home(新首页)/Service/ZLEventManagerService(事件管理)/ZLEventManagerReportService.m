//
//  ZLEventManagerReportService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManagerReportService.h"
@interface ZLEventManagerReportService (){
    NSInteger _pageSize;
    NSString *_appPageCreateTime;
    NSString *_incidentName;
    NSString *_createBeginTime;
    NSString *_createEndTime;
}

@end
@implementation ZLEventManagerReportService

- (instancetype)initWithpageSize:(NSInteger)pageSize
                    incidentName:(NSString *)incidentName
                 createBeginTime:(NSString *)createBeginTime
                   createEndTime:(NSString *)createEndTime
               appPageCreateTime:(NSString *)appPageCreateTime{
    self = [super init];
    if (self) {
        _pageSize = pageSize;
        _appPageCreateTime = appPageCreateTime;
        _incidentName = incidentName;
        _createBeginTime = createBeginTime;
        _createEndTime = createEndTime;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_GetMyCreateIncidentListUrl;
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
                         _createEndTime, @"createEndTime",nil];
    return dic;
    
}
@end
