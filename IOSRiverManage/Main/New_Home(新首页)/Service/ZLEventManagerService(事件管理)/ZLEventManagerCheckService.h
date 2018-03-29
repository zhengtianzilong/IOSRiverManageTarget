//
//  ZLEventManagerCheckService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLEventManagerCheckService : ZLCustomBaseRequest
- (instancetype)initWithpageSize:(NSInteger)pageSize
                    incidentName:(NSString *)incidentName
                  createUserName:(NSString *)createUserName
                 createBeginTime:(NSString *)createBeginTime
                   createEndTime:(NSString *)createEndTime
               appPageCreateTime:(NSString *)appPageCreateTime
                 updateBeginTime:(NSString *)updateBeginTime
                   updateEndTime:(NSString *)updateEndTime
                        userName:(NSString *)userName
                    detailStatus:(NSString *)detailStatus;
@end
