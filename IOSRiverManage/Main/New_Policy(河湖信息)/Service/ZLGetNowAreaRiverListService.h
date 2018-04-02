//
//  ZLGetNowAreaRiverListService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLGetNowAreaRiverListService : ZLCustomBaseRequest
- (instancetype)initWithpageSize:(NSInteger)pageSize
               appPageCreateTime:(NSString *)appPageCreateTime;;
@end
