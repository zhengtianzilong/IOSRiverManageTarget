//
//  ZLContinueEventSendDownService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/10/13.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLContinueEventSendDownService : ZLCustomBaseRequest
- (instancetype)initWitheventContent:(NSString *)eventContent
                                 uid:(NSString *)uid
                                 tid:(NSString *)tid
                           userIds:(NSString *)userIds
                         dataImgBase:(NSString *)dataImgBase;
@end
