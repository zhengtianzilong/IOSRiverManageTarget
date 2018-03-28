//
//  ZLGetUserListByIncidentService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLGetUserListByIncidentService : ZLCustomBaseRequest
- (instancetype)initWithriverCode:(NSString *)riverCode;
@end
