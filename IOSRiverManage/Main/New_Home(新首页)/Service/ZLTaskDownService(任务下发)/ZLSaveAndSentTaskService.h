//
//  ZLSaveAndSentTaskService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLSaveAndSentTaskService : ZLCustomBaseRequest
- (instancetype)initWithimgList:(NSArray *)imgList
                       taskName:(NSString *)taskName
                    taskContent:(NSString *)taskContent
        receiverDepartmentNames:(NSString *)receiverDepartmentNames
        receiverDepartmentCodes:(NSString *)receiverDepartmentCodes
              receiverPersonIds:(NSString *)receiverPersonIds
            receiverPersonNames:(NSString *)receiverPersonNames;
@end
