//
//  ZLFeedbackTaskService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLFeedbackTaskService.h"
@interface ZLFeedbackTaskService (){
    NSArray *_imgList;
    NSString *_taskId;
    NSString *_feedbackContent;
    
}

@end
@implementation ZLFeedbackTaskService

- (instancetype)initWithimgList:(NSArray *)imgList
                         taskId:(NSString *)taskId
                feedbackContent:(NSString *)feedbackContent{
    self = [super init];
    if (self) {
        
        _imgList = imgList;
        _taskId= taskId;
        _feedbackContent = feedbackContent;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_FeedbackTaskUrl;
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
                         _imgList , @"imgList",
                         _taskId , @"taskId",
                         _feedbackContent , @"feedbackContent",
                  
                         nil];
    return dic;
    
}
@end
