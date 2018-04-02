//
//  ZLFindTaskFeedbackByIdService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLFindTaskFeedbackByIdService.h"
@interface ZLFindTaskFeedbackByIdService (){
    NSString *_taskDetailId;
}

@end
@implementation ZLFindTaskFeedbackByIdService

- (instancetype)initWithtaskDetailId:(NSString *)taskDetailId{
    self = [super init];
    if (self) {
        _taskDetailId = taskDetailId;
    }
    return self;
}

- (NSString *)requestUrl {
    return River_FindTaskFeedbackByIdUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeHTTP;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeHTTP;
}

- (id)requestArgument{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _taskDetailId, @"id",
                         nil];
    return dic;
    
}
@end
