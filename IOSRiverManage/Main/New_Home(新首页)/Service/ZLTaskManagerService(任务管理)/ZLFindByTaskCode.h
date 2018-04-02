//
//  ZLFindByTaskCode.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLFindByTaskCode : ZLCustomBaseRequest
- (instancetype)initWithtaskChildCode:(NSString *)taskChildCode;
@end
