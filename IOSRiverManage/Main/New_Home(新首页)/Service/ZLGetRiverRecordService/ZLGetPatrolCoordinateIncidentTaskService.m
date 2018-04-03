//
//  ZLGetPatrolCoordinateIncidentTaskService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/20.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLGetPatrolCoordinateIncidentTaskService.h"
@interface ZLGetPatrolCoordinateIncidentTaskService (){
    NSString *_partolCode;
}

@end
@implementation ZLGetPatrolCoordinateIncidentTaskService

- (instancetype)initWithpartolCode:(NSString *)partolCode{
    self = [super init];
    if (self) {
        
        _partolCode = partolCode;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_GetPatrolCoordinateIncidentTaskUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (YTKRequestSerializerType)requestSerializerType{
    
    return YTKRequestSerializerTypeHTTP;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeHTTP;
}

- (id)requestArgument{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _partolCode,@"patrolCode",
                         nil];
    return dic;
    
}
@end
