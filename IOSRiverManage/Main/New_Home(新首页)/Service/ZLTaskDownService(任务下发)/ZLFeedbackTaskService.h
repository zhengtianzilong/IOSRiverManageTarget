//
//  ZLFeedbackTaskService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLFeedbackTaskService : ZLCustomBaseRequest
- (instancetype)initWithimgList:(NSArray *)imgList
                       taskId:(NSString *)taskId
                    feedbackContent:(NSString *)feedbackContent;
@end
