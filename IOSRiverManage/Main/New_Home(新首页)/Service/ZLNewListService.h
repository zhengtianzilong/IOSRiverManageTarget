//
//  ZLNewListService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/15.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLNewListService : ZLCustomBaseRequest
- (instancetype)initWithpageSize:(NSString *)pageSize
                      createTime:(NSString *)createTime
                            type:(NSString *)type
                        areaCode:(NSString *)areaCode;
@end
