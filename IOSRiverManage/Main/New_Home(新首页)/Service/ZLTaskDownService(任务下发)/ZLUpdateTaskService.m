//
//  ZLUpdateTaskService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLUpdateTaskService.h"
@interface ZLUpdateTaskService (){
    NSArray *_imgList;
    NSString *_taskName;
    NSString *_taskContent;
    NSString *_receiverDepartmentNames;
    NSString *_receiverDepartmentCodes;
    NSString *_receiverPersonIds;
    NSString *_receiverPersonNames;
    NSString *_ID;
    NSString *_taskCode;
    NSArray *_fileList;
}

@end
@implementation ZLUpdateTaskService

- (instancetype)initWithimgList:(NSArray *)imgList
                       taskName:(NSString *)taskName
                    taskContent:(NSString *)taskContent
        receiverDepartmentNames:(NSString *)receiverDepartmentNames
        receiverDepartmentCodes:(NSString *)receiverDepartmentCodes
              receiverPersonIds:(NSString *)receiverPersonIds
            receiverPersonNames:(NSString *)receiverPersonNames
                             ID:(NSString *)ID
                       taskCode:(NSString *)taskCode
                       fileList:(NSArray *)fileList{
    self = [super init];
    if (self) {
        
        _imgList = imgList;
        _taskName= taskName;
        _taskContent = taskContent;
        _receiverDepartmentNames = receiverDepartmentNames;
        _receiverDepartmentCodes = receiverDepartmentCodes;
        _receiverPersonIds = receiverPersonIds;
        _receiverPersonNames = receiverPersonNames;
        _ID = ID;
        _taskCode = taskCode;
        _fileList = fileList;
        
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_UpdateTaskUrl;
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
                         _ID , @"ID",
                         _fileList , @"fileList",
                         _taskCode , @"taskCode",
                         nil];
    return dic;
    
}
@end
