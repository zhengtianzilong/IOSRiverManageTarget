//
//  ZLFindByTaskCode.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLFindByTaskCode.h"
@interface ZLFindByTaskCode (){
    NSString *_taskChildCode;
}

@end
@implementation ZLFindByTaskCode

- (instancetype)initWithtaskChildCode:(NSString *)taskChildCode{
    self = [super init];
    if (self) {
        _taskChildCode = taskChildCode;
    }
    return self;
}

- (NSString *)requestUrl {
    return River_FindByTaskCodeUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeHTTP;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeHTTP;
}

- (id)requestArgument{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _taskChildCode, @"taskCode",
                         nil];
    return dic;
    
}
@end
