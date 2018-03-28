//
//  ZLRiverChiefAddEventService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/21.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

// 河长联系单巡河上报事件
@interface ZLRiverChiefAddEventService : ZLCustomBaseRequest
- (instancetype)initWitheventName:(NSString *)eventName
                     eventContent:(NSString *)eventContent
                     positionDesc:(NSString *)positionDesc
                             uuid:(NSString *)uuid
                             type:(NSString *)type
                              lgt:(NSString *)lgt
                              lat:(NSString *)lat
                          riverid:(NSString *)riverid
                        liable_id:(NSString *)liable_id
                              uid:(NSString *)uid
                      dataImgBase:(NSString *)dataImgBase;
@end
