//
//  ZLOnlyAddIncidentService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLOnlyAddIncidentService : ZLCustomBaseRequest
- (instancetype)initWithimgList:(NSArray *)imgList
                       fileList:(NSArray *)fileList
                   incidentName:(NSString *)incidentName
                incidentContent:(NSString *)incidentContent
                   receiverType:(NSString *)receiverType
             receiverDepartCode:(NSString *)receiverDepartCode
             receiverDepartName:(NSString *)receiverDepartName
             receiverPersonName:(NSString *)receiverPersonName
             receiverPersonCode:(NSString *)receiverPersonCode
                      riverCode:(NSString *)riverCode
                     patrolCode:(NSString *)patrolCode
                      longitude:(NSString *)longitude
                       latitude:(NSString *)latitude
                   positionDesc:(NSString *)positionDesc;
@end
