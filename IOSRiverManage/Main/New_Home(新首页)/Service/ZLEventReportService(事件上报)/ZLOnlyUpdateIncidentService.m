//
//  ZLOnlyUpdateIncidentService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLOnlyUpdateIncidentService.h"
@interface ZLOnlyUpdateIncidentService (){
    NSArray *_imgList;
    NSArray *_fileList;
    NSString *_incidentName;
    NSString *_incidentContent;
    NSString *_receiverType;
    NSString *_receiverDepartCode;
    NSString *_receiverDepartName;
    NSString *_receiverPersonName;
    NSString *_receiverPersonCode;
    NSString *_riverCode;
    NSString *_patrolCode;
    NSString *_longitude;
    NSString *_latitude;
    NSString *_positionDesc;
    NSString *_incidentCode;
}

@end
@implementation ZLOnlyUpdateIncidentService

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
                   positionDesc:(NSString *)positionDesc
                   incidentCode:(NSString *)incidentCode{
    self = [super init];
    if (self) {
        
        _imgList = imgList;
        _fileList= fileList;
        _incidentName = incidentName;
        _incidentContent = incidentContent;
        _receiverType = receiverType;
        _receiverDepartCode = receiverDepartCode;
        _receiverDepartName = receiverDepartName;
        _receiverPersonName = receiverPersonName;
        _receiverPersonCode = receiverPersonCode;
        _riverCode = riverCode;
        _patrolCode = patrolCode;
        _longitude = longitude;
        _latitude = latitude;
        _positionDesc = positionDesc;
        _incidentCode = incidentCode;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_OnlyUpdateIncidentForAppUrl;
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
                         _fileList, @"fileList",
                         _incidentName , @"incidentName",
                         _incidentContent , @"incidentContent",
                        _incidentCode , @"incidentCode",
                         _receiverType , @"receiverType",
                         _receiverDepartCode , @"receiverDepartCode",
                         _receiverDepartName , @"receiverDepartName",
                         _receiverPersonName , @"receiverPersonName",
                         _receiverPersonCode , @"receiverPersonCode",
                         _riverCode , @"riverCode",
                         _patrolCode , @"patrolCode",
                         _longitude , @"longitude",
                         _latitude , @"latitude",
                         _positionDesc , @"positionDesc",
                        
                         nil];
    return dic;
    
}

@end
