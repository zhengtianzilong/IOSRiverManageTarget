//
//  ZLFeedbackIncidentForApp.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLFeedbackIncidentForApp.h"
@interface ZLFeedbackIncidentForApp (){
    NSArray *_imgList;
    NSString *_taskId;
    NSString *_feedbackContent;
    NSArray *_fileListDetail;
    NSString *_eventId;
    NSString *_eventDetailId;
}

@end
@implementation ZLFeedbackIncidentForApp

- (instancetype)initWithimgList:(NSArray *)imgList
                 fileListDetail:(NSArray *)fileListDetail
                        eventId:(NSString *)eventId
                  eventDetailId:(NSString *)eventDetailId
                feedbackContent:(NSString *)feedbackContent{
    self = [super init];
    if (self) {
        
        _imgList = imgList;
        _eventId= eventId;
        _eventDetailId= eventDetailId;
        _fileListDetail= fileListDetail;
        _feedbackContent = feedbackContent;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_FeedbackIncidentForAppUrl;
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
                         _imgList , @"imgList",
                         _eventDetailId , @"id",
                         _fileListDetail , @"fileListDetail",
                         _eventId , @"id",
                         _feedbackContent , @"feedbackContent",
                         
                         nil];
    return dic;
    
}
@end
