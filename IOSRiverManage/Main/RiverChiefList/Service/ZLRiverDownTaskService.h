//
//  ZLRiverDownTaskService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/26.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"
// 巡河时的任务下发
@interface ZLRiverDownTaskService : ZLCustomBaseRequest
- (instancetype)initWithtaskName:(NSString *)taskName
                     taskContent:(NSString *)taskContent
                     positionDesc:(NSString *)positionDesc
                             uuid:(NSString *)uuid
                             type:(NSString *)type
                              lgt:(NSString *)lgt
                              lat:(NSString *)lat
                        liable_id:(NSString *)liable_id
                              uid:(NSString *)uid
                      dataImgBase:(NSString *)dataImgBase;
@end
