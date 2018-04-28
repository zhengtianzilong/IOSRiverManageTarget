//
//  ZLContinueReportIncidentService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLContinueReportIncidentService : ZLCustomBaseRequest
- (instancetype)initWithimgList:(NSArray *)imgList
                       fileList:(NSArray *)fileList
                     incidentid:(NSString *)incidentid
                incidentContent:(NSString *)incidentContent
                   receiverType:(NSString *)receiverType
             receiverDepartCode:(NSString *)receiverDepartCode
             receiverDepartName:(NSString *)receiverDepartName
             receiverPersonName:(NSString *)receiverPersonName
             receiverPersonCode:(NSString *)receiverPersonCode
          riverIncidentDetailId:(NSString *)riverIncidentDetailId
                       isUrgent:(NSString *)isUrgent;
@end
