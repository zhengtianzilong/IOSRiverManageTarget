//
//  ZLEndCheckRiverService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/25.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLEndCheckRiverService.h"
@interface ZLEndCheckRiverService (){
    NSString *_uid;
    NSString *_uuid;
    NSString *_riverId;
    NSString *_startTime;
    NSString *_type;
    NSString *_endTime;
    NSArray *_batchData;
}
@end

@implementation ZLEndCheckRiverService

- (instancetype)initWithuid:(NSString *)uid
                       uuid:(NSString *)uuid
                    riverId:(NSString *)riverId
                  startTime:(NSString *)startTime
                    endTime:(NSString *)endTime
                       type:(NSString *)type
                  batchData:(NSArray *)batchData{
    self = [super init];
    if (self) {
        _uid = uid;
        _uuid = uuid;
        _riverId = riverId;
        _startTime = startTime;
        _endTime = endTime;
        _type = type;
        _batchData = batchData;
    }
    return self;
    
}

- (NSString *)requestUrl {
    return River_EndRiverUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}


- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeHTTP;
}

//- (YTKResponseSerializerType)responseSerializerType{
//    return YTKResponseSerializerTypeHTTP;
//}

- (id)requestArgument{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_batchData options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _startTime,@"startTime",
                         _endTime,@"endTime",
                         _uuid,@"uuid",
                         _type,@"type",
                         _riverId,@"riverId",
                         _uid,@"uid",
                         jsonStr,@"batchData",
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
