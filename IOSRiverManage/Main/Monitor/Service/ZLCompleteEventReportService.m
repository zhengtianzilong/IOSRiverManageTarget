//
//  ZLCompleteEventReportService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/10/12.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLCompleteEventReportService.h"
@interface ZLCompleteEventReportService (){
    NSString *_eventContent;
    NSString *_leaderIds;
    NSString *_uid;
    NSString *_eid;
    NSString *_dataImgBase;
}

@end
@implementation ZLCompleteEventReportService
- (instancetype)initWitheventContent:(NSString *)eventContent
                                 uid:(NSString *)uid
                                 eid:(NSString *)eid
                         dataImgBase:(NSString *)dataImgBase{
    
    self = [super init];
    if (self) {
        _eventContent = eventContent;
        _uid = uid;
        _eid = eid;
        _dataImgBase = dataImgBase;
        
    }
    return self;
    
}


- (NSString *)requestUrl {
    return River_CompleteEventUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}


- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeHTTP;
}

- (id)requestArgument{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _eventContent,@"content",
                         _uid,@"uid",
                         _eid,@"eid",
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
