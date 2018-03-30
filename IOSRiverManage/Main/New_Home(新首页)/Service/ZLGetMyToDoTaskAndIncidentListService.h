//
//  ZLGetMyToDoTaskAndIncidentListService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/30.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLGetMyToDoTaskAndIncidentListService : ZLCustomBaseRequest
- (instancetype)initWithpageSize:(NSInteger)pageSize
               appPageCreateTime:(NSString *)appPageCreateTime;
@end
