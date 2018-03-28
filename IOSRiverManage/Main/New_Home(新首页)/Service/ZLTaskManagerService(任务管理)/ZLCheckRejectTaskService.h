//
//  ZLCheckRejectTaskService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLCheckRejectTaskService : ZLCustomBaseRequest
- (instancetype)initWithtaskDetailId:(NSString *)taskDetailId
                     approvalOpinion:(NSString *)approvalOpinion;
@end
