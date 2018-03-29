//
//  ZLEventManagerReportService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLEventManagerReportService : ZLCustomBaseRequest
- (instancetype)initWithpageSize:(NSInteger)pageSize
                    incidentName:(NSString *)incidentName
                 createBeginTime:(NSString *)createBeginTime
                   createEndTime:(NSString *)createEndTime
               appPageCreateTime:(NSString *)appPageCreateTime;
@end
