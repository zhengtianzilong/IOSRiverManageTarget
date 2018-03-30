//
//  ZLGetRiverPatrolListByUserCodeService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/20.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLGetRiverPatrolListByUserCodeService : ZLCustomBaseRequest

- (instancetype)initWithpageSize:(NSString *)pageSize
                       startTime:(NSString *)startTime
                  quertStartTime:(NSString *)quertStartTime
                    quertEntTime:(NSString *)quertEntTime
                  queryRiverName:(NSString *)queryRiverName;
@end
