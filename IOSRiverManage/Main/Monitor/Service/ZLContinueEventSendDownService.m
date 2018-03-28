//
//  ZLContinueEventSendDownService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/10/13.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLContinueEventSendDownService.h"
@interface ZLContinueEventSendDownService (){
    NSString *_eventContent;
    NSString *_userIds;
    NSString *_uid;
    NSString *_tid;
    NSString *_dataImgBase;
}

@end
@implementation ZLContinueEventSendDownService
- (instancetype)initWitheventContent:(NSString *)eventContent
                                 uid:(NSString *)uid
                                 tid:(NSString *)tid
                             userIds:(NSString *)userIds
                         dataImgBase:(NSString *)dataImgBase{
    
    self = [super init];
    if (self) {
        _eventContent = eventContent;
        
        _userIds = userIds;
        if (_userIds == nil) {
            _userIds = @"";
        }
        _uid = uid;
        _tid = tid;
        _dataImgBase = dataImgBase;
        
    }
    return self;
    
}


- (NSString *)requestUrl {
    return River_ContinueTaskDownUrl;
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
                         _userIds,@"userIds",
                         _uid,@"uid",
                         _tid,@"tid",
                         _dataImgBase,@"dataImgBase",
                         nil];
    return dic;
    
}
@end
