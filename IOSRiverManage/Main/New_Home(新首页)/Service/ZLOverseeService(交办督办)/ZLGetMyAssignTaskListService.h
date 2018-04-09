//
//  ZLGetMyAssignTaskListService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/8.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLGetMyAssignTaskListService : ZLCustomBaseRequest
- (instancetype)initWithpageSize:(NSInteger)pageSize
                     currentPage:(NSInteger)currentPage
                      assignName:(NSString *)assignName
                 assignStartTime:(NSString *)assignStartTime
                   assignEndTime:(NSString *)assignEndTime
               completeStartTime:(NSString *)completeStartTime
                 completeEndTime:(NSString *)completeEndTime
                       startTime:(NSString *)startTime;
@end
