//
//  ZLSavepatrolpointService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/20.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLSavepatrolpointService.h"
@interface ZLSavepatrolpointService (){
    NSString *_patrolCode;
    NSString *_userCode;
    NSString *_riverCode;
    NSString *_startTime;
    NSString *_startLongitude;
    NSString *_startLatitude;
    NSString *_endLongitude;
    NSString *_endLatitude;
    NSString *_endTime;
    NSArray *_list;
}
@end

@implementation ZLSavepatrolpointService

- (instancetype)initWithpatrolCode:(NSString *)patrolCode
                          userCode:(NSString *)userCode
                         riverCode:(NSString *)riverCode
                         startTime:(NSString *)startTime
                           endTime:(NSString *)endTime
                    startLongitude:(NSString *)startLongitude
                     startLatitude:(NSString *)startLatitude
                      endLongitude:(NSString *)endLongitude
                       endLatitude:(NSString *)endLatitude
                              list:(NSArray *)list{
    self = [super init];
    if (self) {
        _patrolCode = patrolCode;
        _userCode = userCode;
        _riverCode = riverCode;
        _startTime = startTime;
        _endTime = endTime;
        _startLongitude = startLongitude;
        _startLatitude = startLatitude;
        
        _endLongitude = endLongitude;
        _endLatitude = endLatitude;
        _list = list;
    }
    return self;
    
}

- (NSString *)requestUrl {
    return River_SavepatrolpointUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}


- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

//- (YTKResponseSerializerType)responseSerializerType{
//    return YTKResponseSerializerTypeHTTP;
//}

- (id)requestArgument{
    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_batchData options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *jsonStr=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _startTime,@"startTime",
                         _endTime,@"endTime",
                         _patrolCode,@"patrolCode",
                         _userCode,@"userCode",
                         _riverCode,@"riverCode",
                         _startLongitude,@"startLongitude",
                         _startLatitude,@"startLatitude",
                         _endLongitude,@"endLongitude",
                         _endLatitude,@"endLatitude",
                         _list,@"list",
                         nil];
    return dic;
    //    return @{
    //             @"startTime":_startTime,
    //             @"endTime":_endTime,
    //             @"uuid":_uuid,
    //             @"type":_type,
    //             @"riverId":_riverId,
    //             @"uid":_uid,
    //             @"batchData":jsonStr
    //             };
    
}
@end
