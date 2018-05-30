//
//  ZLGetScoreDetailService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLGetScoreDetailService : ZLCustomBaseRequest
- (instancetype)initWithmanagerDetailCode :(NSString *)managerDetailCode
                                 modelCode:(NSString *)modelCode;
@end
