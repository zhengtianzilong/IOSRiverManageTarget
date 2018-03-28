//
//  ZLDeleteTasksService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

// 任务删除

@interface ZLDeleteTasksService : ZLCustomBaseRequest
- (instancetype)initWithtaskId:(NSString *)taskId;
@end
