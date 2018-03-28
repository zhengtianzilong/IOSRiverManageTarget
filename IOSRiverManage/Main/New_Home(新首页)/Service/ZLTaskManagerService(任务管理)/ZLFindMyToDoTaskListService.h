//
//  ZLFindMyToDoTaskListService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLFindMyToDoTaskListService : ZLCustomBaseRequest
- (instancetype)initWithpageSize:(NSInteger)pageSize
                createTimeFormat:(NSString *)createTimeFormat
                        taskName:(NSString *)taskName
                      createName:(NSString *)createName
                 createStartTime:(NSString *)createStartTime
                   createEndTime:(NSString *)createEndTime;
@end
