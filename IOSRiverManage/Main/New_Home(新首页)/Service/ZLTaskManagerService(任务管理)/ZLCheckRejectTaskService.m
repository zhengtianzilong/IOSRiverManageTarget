//
//  ZLCheckRejectTaskService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCheckRejectTaskService.h"
@interface ZLCheckRejectTaskService (){
    NSString *_taskDetailId;
    NSString *_approvalOpinion;
}

@end
@implementation ZLCheckRejectTaskService

- (instancetype)initWithtaskDetailId:(NSString *)taskDetailId
                     approvalOpinion:(NSString *)approvalOpinion{
    self = [super init];
    if (self) {
        _taskDetailId = taskDetailId;
        _approvalOpinion = approvalOpinion;
    }
    return self;
}

- (NSString *)requestUrl {
    return River_CheckRejectTaskUrl;
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
                         _taskDetailId, @"riverTaskDetailId",
                         _approvalOpinion, @"approvalOpinion",
                         nil];
    return dic;
    
}
@end
