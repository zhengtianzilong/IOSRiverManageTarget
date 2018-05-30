//
//  ZLGetScoreDetailService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLGetScoreDetailService.h"
@interface ZLGetScoreDetailService (){
    NSString *_managerDetailCode;
    NSString *_modelCode;
}

@end
@implementation ZLGetScoreDetailService

- (instancetype)initWithmanagerDetailCode :(NSString *)managerDetailCode
                    modelCode:(NSString *)modelCode{
    self = [super init];
    if (self) {
        _managerDetailCode = managerDetailCode;
        _modelCode = modelCode;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_GetScoreExamineServiceUrl;
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
                         _managerDetailCode,@"managerDetailCode",
                         _modelCode, @"modelCode",nil];
    return dic;
    
}
@end
