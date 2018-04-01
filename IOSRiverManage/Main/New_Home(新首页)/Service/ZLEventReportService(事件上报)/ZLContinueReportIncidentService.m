//
//  ZLContinueReportIncidentService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLContinueReportIncidentService.h"
@interface ZLContinueReportIncidentService (){
    NSArray *_imgList;
    NSArray *_fileList;
    NSString *_incidentid;
    NSString *_incidentContent;
    NSString *_receiverType;
    NSString *_receiverDepartCode;
    NSString *_receiverDepartName;
    NSString *_receiverPersonName;
    NSString *_receiverPersonCode;
}

@end
@implementation ZLContinueReportIncidentService

- (instancetype)initWithimgList:(NSArray *)imgList
                       fileList:(NSArray *)fileList
                     incidentid:(NSString *)incidentid
                incidentContent:(NSString *)incidentContent
                   receiverType:(NSString *)receiverType
             receiverDepartCode:(NSString *)receiverDepartCode
             receiverDepartName:(NSString *)receiverDepartName
             receiverPersonName:(NSString *)receiverPersonName
             receiverPersonCode:(NSString *)receiverPersonCode{
    self = [super init];
    if (self) {
        
        _imgList = imgList;
        _fileList= fileList;
        _incidentid = incidentid;
        _incidentContent = incidentContent;
        _receiverType = receiverType;
        _receiverDepartCode = receiverDepartCode;
        _receiverDepartName = receiverDepartName;
        _receiverPersonName = receiverPersonName;
        _receiverPersonCode = receiverPersonCode;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_ContinueReportIncidentForAppUrl;
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
                         _imgList , @"imgListDetail",
                         _fileList, @"fileListDetail",
                         _incidentid , @"incidentid",
                         _incidentContent , @"incidentContent",
                         _receiverType , @"receiverType",
                         _receiverDepartCode , @"receiverDepartCode",
                         _receiverDepartName , @"receiverDepartName",
                         _receiverPersonName , @"receiverPersonName",
                         _receiverPersonCode , @"receiverPersonCode",

                         nil];
    return dic;
    
}
@end
