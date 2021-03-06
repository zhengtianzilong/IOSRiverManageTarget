//
//  ZLRiverSaveAndSentTaskService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverSaveAndSentTaskService.h"
@interface ZLRiverSaveAndSentTaskService (){
    NSArray *_imgList;
    NSString *_taskName;
    NSString *_taskContent;
    NSString *_receiverDepartmentNames;
    NSString *_receiverDepartmentCodes;
    NSString *_receiverPersonIds;
    NSString *_receiverPersonNames;
    
    NSString *_riverCode;
    NSString *_longitude;
    NSString *_latitude;
    NSString *_positionDesc;
    NSString *_patrolCode;
    NSString *_isUrgent;
}

@end
@implementation ZLRiverSaveAndSentTaskService

- (instancetype)initWithimgList:(NSArray *)imgList
                       taskName:(NSString *)taskName
                    taskContent:(NSString *)taskContent
        receiverDepartmentNames:(NSString *)receiverDepartmentNames
        receiverDepartmentCodes:(NSString *)receiverDepartmentCodes
              receiverPersonIds:(NSString *)receiverPersonIds
            receiverPersonNames:(NSString *)receiverPersonNames
                      riverCode:(NSString *)riverCode
                      longitude:(NSString *)longitude
                       latitude:(NSString *)latitude
                   positionDesc:(NSString *)positionDesc
                     patrolCode:(NSString *)patrolCode
                       isUrgent:(NSString *)isUrgent{
    self = [super init];
    if (self) {
        
        _imgList = imgList;
        _taskName= taskName;
        _taskContent = taskContent;
        _receiverDepartmentNames = receiverDepartmentNames;
        _receiverDepartmentCodes = receiverDepartmentCodes;
        _receiverPersonIds = receiverPersonIds;
        _receiverPersonNames = receiverPersonNames;
        
        _riverCode = riverCode;
        _longitude = longitude;
        _latitude = latitude;
        _positionDesc = positionDesc;
        _patrolCode = patrolCode;
        _isUrgent = isUrgent;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_SaveAndSentTaskUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeHTTP;
}

- (id)requestArgument{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _imgList , @"imgList",
                         _taskName , @"taskName",
                         _isUrgent , @"isUrgent",
                         _taskContent , @"taskContent",
                         _receiverDepartmentNames , @"receiverDepartmentNames",
                         _receiverDepartmentCodes , @"receiverDepartmentCodes",
                         _receiverPersonIds , @"receiverPersonIds",
                         _receiverPersonNames , @"receiverPersonNames",
                         _riverCode , @"riverCode",
                         _longitude , @"longitude",
                         _latitude , @"latitude",
                         _positionDesc , @"positionDesc",
                         _patrolCode, @"patrolCode",
                         nil];
    return dic;
    
}
@end
