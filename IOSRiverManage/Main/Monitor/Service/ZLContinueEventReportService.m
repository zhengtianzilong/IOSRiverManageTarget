//
//  ZLContinueEventReportService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/10/12.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLContinueEventReportService.h"
@interface ZLContinueEventReportService (){
    NSString *_eventContent;
    NSString *_leaderIds;
    NSString *_uid;
    NSString *_eid;
    NSString *_dataImgBase;
}

@end
@implementation ZLContinueEventReportService
- (instancetype)initWitheventContent:(NSString *)eventContent
                                 uid:(NSString *)uid
                                 eid:(NSString *)eid
                           leaderIds:(NSString *)leaderIds
                         dataImgBase:(NSString *)dataImgBase{
    
    self = [super init];
    if (self) {
        _eventContent = eventContent;
        
        _leaderIds = leaderIds;
        if (_leaderIds == nil) {
            _leaderIds = @"";
        }
        _uid = uid;
        _eid = eid;
        _dataImgBase = dataImgBase;
        
    }
    return self;
    
}


- (NSString *)requestUrl {
    return River_ContinueEventUrl;
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
                         _leaderIds,@"leaderIds",
                         _uid,@"uid",
                         _eid,@"eid",
                         _dataImgBase,@"dataImgBase",
                         nil];
    return dic;
    
}

@end
