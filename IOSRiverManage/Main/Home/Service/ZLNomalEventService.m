//
//  ZLNomalEventService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/22.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLNomalEventService.h"
@interface ZLNomalEventService (){
    NSString *_eventName;
    NSString *_eventContent;
    NSString *_liable_id;
    NSString *_uid;
    NSString *_dataImgBase;
}

@end
@implementation ZLNomalEventService
- (instancetype)initWitheventName:(NSString *)eventName
                     eventContent:(NSString *)eventContent
                              uid:(NSString *)uid
                              liable_id:(NSString *)liable_id
                      dataImgBase:(NSString *)dataImgBase{
    
    self = [super init];
    if (self) {
        _eventName = eventName;
        _eventContent = eventContent;
        
        _liable_id = liable_id;
        if (_liable_id == nil) {
            _liable_id = @"";
        }
        
        
        _uid = uid;
        _dataImgBase = dataImgBase;
        
    }
    return self;
    
}


- (NSString *)requestUrl {
    return River_NormalEventUrl;
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
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _eventName,@"eventName",
                         _eventContent,@"eventContent",
                         _liable_id,@"liable_id",
                         _uid,@"uid",
                         _dataImgBase,@"dataImgBase",
                         nil];
    return dic;
    
//    return @{@"eventName":_eventName,
//             @"eventContent":_eventContent,
//             @"liable_id":_liable_id,
//             @"uid":_uid,
//             @"dataImgBase":_dataImgBase
//             };
    
}
@end
