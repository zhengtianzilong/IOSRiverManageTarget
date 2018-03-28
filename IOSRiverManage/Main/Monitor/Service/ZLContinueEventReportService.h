//
//  ZLContinueEventReportService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/10/12.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

/**
 继续事件上报
 */
@interface ZLContinueEventReportService : ZLCustomBaseRequest
- (instancetype)initWitheventContent:(NSString *)eventContent
                                 uid:(NSString *)uid
                                 eid:(NSString *)eid
                           leaderIds:(NSString *)leaderIds
                         dataImgBase:(NSString *)dataImgBase;
@end
