//
//  ZLGetAssignTaskListService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/21.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"


@interface ZLGetAssignTaskListService : ZLCustomBaseRequest

- (instancetype)initWithpageSize:(NSInteger)pageSize
                     currentPage:(NSInteger)currentPage
                      assignName:(NSString *)assignName
                 assignStartTime:(NSString *)assignStartTime
                   assignEndTime:(NSString *)assignEndTime
               completeStartTime:(NSString *)completeStartTime
                 completeEndTime:(NSString *)completeEndTime
                      departName:(NSString *)departName
                        userName:(NSString *)userName
                       startTime:(NSString *)startTime;
@end
