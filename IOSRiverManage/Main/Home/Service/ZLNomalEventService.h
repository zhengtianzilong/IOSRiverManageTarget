//
//  ZLNomalEventService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/22.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLNomalEventService : ZLCustomBaseRequest
- (instancetype)initWitheventName:(NSString *)eventName
                     eventContent:(NSString *)eventContent
                              uid:(NSString *)uid
                        liable_id:(NSString *)liable_id
                      dataImgBase:(NSString *)dataImgBase;
@end
