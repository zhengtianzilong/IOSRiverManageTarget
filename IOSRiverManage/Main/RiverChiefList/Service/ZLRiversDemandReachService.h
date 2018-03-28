//
//  ZLRiversDemandReachService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/21.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"
/**
 查找河长所管辖的河段
 */
@interface ZLRiversDemandReachService : ZLCustomBaseRequest

- (instancetype)initWithUidCode:(NSString *)uidCode;

@end
