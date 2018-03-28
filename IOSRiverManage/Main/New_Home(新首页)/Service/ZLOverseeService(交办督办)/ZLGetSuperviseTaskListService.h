//
//  ZLGetSuperviseTaskListService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLGetSuperviseTaskListService : ZLCustomBaseRequest
- (instancetype)initWithpageSize:(NSInteger)pageSize
                     currentPage:(NSInteger)currentPage
                   superviseName:(NSString *)superviseName
                      assignCode:(NSString *)assignCode
                   superviseUnit:(NSString *)superviseUnit
                      departName:(NSString *)departName
                        userName:(NSString *)userName
                       startTime:(NSString *)startTime
              superviseStartTime:(NSString *)superviseStartTime
                superviseEndTime:(NSString *)superviseEndTime;
@end
