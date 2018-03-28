//
//  ZLLoginService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/15.
//  Copyright © 2017年 caizilong. All rights reserved.
//


#import "ZLCustomBaseRequest.h"
@interface ZLLoginService : ZLCustomBaseRequest


- (instancetype)initWithuserName:(NSString *)userName
                        passworld:(NSString *)passworld;

@end
