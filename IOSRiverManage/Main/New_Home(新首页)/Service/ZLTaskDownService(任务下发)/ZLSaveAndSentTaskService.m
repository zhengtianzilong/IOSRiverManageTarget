//
//  ZLSaveAndSentTaskService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLSaveAndSentTaskService.h"
@interface ZLSaveAndSentTaskService (){
    NSArray *_imgList;
    NSString *_taskName;
    NSString *_taskContent;
    NSString *_receiverDepartmentNames;
    NSString *_receiverDepartmentCodes;
    NSString *_receiverPersonIds;
    NSString *_receiverPersonNames;
}

@end
@implementation ZLSaveAndSentTaskService

- (instancetype)initWithimgList:(NSArray *)imgList
                       taskName:(NSString *)taskName
                    taskContent:(NSString *)taskContent
        receiverDepartmentNames:(NSString *)receiverDepartmentNames
        receiverDepartmentCodes:(NSString *)receiverDepartmentCodes
              receiverPersonIds:(NSString *)receiverPersonIds
            receiverPersonNames:(NSString *)receiverPersonNames{
    self = [super init];
    if (self) {
        
        _imgList = imgList;
        _taskName= taskName;
        _taskContent = taskContent;
        _receiverDepartmentNames = receiverDepartmentNames;
        _receiverDepartmentCodes = receiverDepartmentCodes;
        _receiverPersonIds = receiverPersonIds;
        _receiverPersonNames = receiverPersonNames;
        
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
                         _taskContent , @"taskContent",
                         _receiverDepartmentNames , @"receiverDepartmentNames",
                         _receiverDepartmentCodes , @"receiverDepartmentCodes",
                         _receiverPersonIds , @"receiverPersonIds",
                         _receiverPersonNames , @"receiverPersonNames",
                         nil];
    return dic;
    
}
@end
