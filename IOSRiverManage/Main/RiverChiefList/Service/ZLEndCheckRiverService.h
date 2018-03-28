//
//  ZLEndCheckRiverService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/25.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLEndCheckRiverService : ZLCustomBaseRequest

- (instancetype)initWithuid:(NSString *)uid
                       uuid:(NSString *)uuid
                    riverId:(NSString *)riverId
                  startTime:(NSString *)startTime
                    endTime:(NSString *)endTime
                       type:(NSString *)type
                  batchData:(NSArray *)batchData;

@end
