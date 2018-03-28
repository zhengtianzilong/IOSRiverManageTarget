//
//  ZLNomalTaskDownService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/26.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

/**
 普通任务下发
 */
@interface ZLNomalTaskDownService : ZLCustomBaseRequest
- (instancetype)initWithtaskName:(NSString *)taskName
                     taskContent:(NSString *)taskContent
                        liable_id:(NSString *)liable_id
                      userid:(NSString *)userid
                     dataImgBase:(NSString *)dataImgBase;
@end
