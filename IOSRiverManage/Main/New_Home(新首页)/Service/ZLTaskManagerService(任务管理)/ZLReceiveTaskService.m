//
//  ZLReceiveTaskService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLReceiveTaskService.h"
@interface ZLReceiveTaskService (){
    NSString *_taskDetailId;
}

@end
@implementation ZLReceiveTaskService

- (instancetype)initWithtaskDetailId:(NSString *)taskDetailId{
    self = [super init];
    if (self) {
        _taskDetailId = taskDetailId;
    }
    return self;
}

- (NSString *)requestUrl {
    return River_ReceiveTaskUrl;
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
                         _taskDetailId, @"taskDetailId",
                         nil];
    return dic;
    
}
@end
