//
//  ZLGetRiverPatrolListByUserCodeService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/20.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLGetRiverPatrolListByUserCodeService.h"
@interface ZLGetRiverPatrolListByUserCodeService (){
    NSString *_pageSize;
    NSString *_startTime;
    NSString *_quertStartTime;
    NSString *_quertEntTime;
    NSString *_queryRiverName;
    
}

@end
@implementation ZLGetRiverPatrolListByUserCodeService

- (instancetype)initWithpageSize:(NSString *)pageSize
                       startTime:(NSString *)startTime
                  quertStartTime:(NSString *)quertStartTime
                    quertEntTime:(NSString *)quertEntTime
                  queryRiverName:(NSString *)queryRiverName{
    self = [super init];
    if (self) {
        
        _pageSize = pageSize;
        _startTime = startTime;
        _quertEntTime = quertEntTime;
        _queryRiverName = queryRiverName;
        _quertStartTime = quertStartTime;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_GetRiverPatrolListByUserCodeUrl;
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
                         _startTime,@"startTime",
                         _pageSize,@"pageSize",
                         _quertStartTime,@"quertStartTime",
                         _quertEntTime,@"quertEntTime",
                         _queryRiverName,@"queryRiverName",
                         nil];
    return dic;
    
}
@end
