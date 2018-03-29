//
//  ZLEventManagerDetailService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLEventManagerDetailService : ZLCustomBaseRequest
- (instancetype)initWitheventId:(NSString *)eventId;
@end
