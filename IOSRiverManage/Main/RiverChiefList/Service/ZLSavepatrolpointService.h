//
//  ZLSavepatrolpointService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/20.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLSavepatrolpointService : ZLCustomBaseRequest
- (instancetype)initWithpatrolCode:(NSString *)patrolCode
                          userCode:(NSString *)userCode
                         riverCode:(NSString *)riverCode
                         startTime:(NSString *)startTime
                           endTime:(NSString *)endTime
                    startLongitude:(NSString *)startLongitude
                     startLatitude:(NSString *)startLatitude
                      endLongitude:(NSString *)endLongitude
                       endLatitude:(NSString *)endLatitude
                              list:(NSArray *)list;
@end
