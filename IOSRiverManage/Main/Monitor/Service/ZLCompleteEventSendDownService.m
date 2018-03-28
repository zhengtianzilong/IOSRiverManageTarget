//
//  ZLCompleteEventSendDownService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/10/13.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLCompleteEventSendDownService.h"
@interface ZLCompleteEventSendDownService (){
    NSString *_eventContent;
    NSString *_uid;
    NSString *_tid;
    NSString *_dataImgBase;
}

@end
@implementation ZLCompleteEventSendDownService
- (instancetype)initWitheventContent:(NSString *)eventContent
                                 uid:(NSString *)uid
                                 tid:(NSString *)tid
                         dataImgBase:(NSString *)dataImgBase{
    
    self = [super init];
    if (self) {
        _eventContent = eventContent;
        _uid = uid;
        _tid = tid;
        _dataImgBase = dataImgBase;
        
    }
    return self;
    
}


- (NSString *)requestUrl {
    return River_CompleteTaskDownUrl;
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
                         _tid,@"tid",
                         _dataImgBase,@"dataImgBase",
                         nil];
    return dic;
    
}

@end
