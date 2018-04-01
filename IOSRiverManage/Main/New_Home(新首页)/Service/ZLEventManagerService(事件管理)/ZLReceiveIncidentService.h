//
//  ZLReceiveIncidentService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLReceiveIncidentService : ZLCustomBaseRequest
- (instancetype)initWithriverIncidentDetailId:(NSString *)riverIncidentDetailId
                     eventId:(NSString *)eventId;
@end
