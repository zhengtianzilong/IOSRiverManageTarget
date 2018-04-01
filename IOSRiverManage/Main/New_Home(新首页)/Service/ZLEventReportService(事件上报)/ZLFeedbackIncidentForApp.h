//
//  ZLFeedbackIncidentForApp.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLFeedbackIncidentForApp : ZLCustomBaseRequest
- (instancetype)initWithimgList:(NSArray *)imgList
                 fileListDetail:(NSArray *)fileListDetail
                        eventId:(NSString *)eventId
                  eventDetailId:(NSString *)eventDetailId
                feedbackContent:(NSString *)feedbackContent;
@end
