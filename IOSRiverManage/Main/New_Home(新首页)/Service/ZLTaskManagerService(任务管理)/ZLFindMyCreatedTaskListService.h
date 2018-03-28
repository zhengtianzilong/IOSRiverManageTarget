//
//  ZLFindMyCreatedTaskListService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLFindMyCreatedTaskListService : ZLCustomBaseRequest
- (instancetype)initWithpageSize:(NSInteger)pageSize
                createTimeFormat:(NSString *)createTimeFormat
                        taskName:(NSString *)taskName
                 createStartTime:(NSString *)createStartTime
                   createEndTime:(NSString *)createEndTime;
@end
