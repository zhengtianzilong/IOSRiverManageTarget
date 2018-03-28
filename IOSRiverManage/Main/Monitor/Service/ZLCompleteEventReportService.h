//
//  ZLCompleteEventReportService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/10/12.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

/**
 办结事件服务
 */
@interface ZLCompleteEventReportService : ZLCustomBaseRequest
- (instancetype)initWitheventContent:(NSString *)eventContent
                                 uid:(NSString *)uid
                                 eid:(NSString *)eid
                         dataImgBase:(NSString *)dataImgBase;
@end
