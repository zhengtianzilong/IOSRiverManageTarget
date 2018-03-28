//
//  ZLEventObjectService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/22.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLEventObjectService : ZLCustomBaseRequest
- (instancetype)initWithuid:(NSString *)uid riverId:(NSString *)riverId;
@end
