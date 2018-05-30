//
//  ZLCommitMyScoreService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/30.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLCommitMyScoreService : ZLCustomBaseRequest

- (instancetype)initWithArray:(NSArray *)array
            managerDetailCode:(NSString *)managerDetailCode
                   modelCode :(NSString *)modelCode
                       flag  :(NSString *)flag;

@end
