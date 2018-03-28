//
//  ZLAppChangeVersionService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/30.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLAppChangeVersionService : ZLCustomBaseRequest
- (instancetype)initWithversion:(NSString *)version
                            uid:(NSString *)uid;
@end
