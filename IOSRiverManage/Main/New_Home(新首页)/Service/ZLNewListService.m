//
//  ZLNewListService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/15.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewListService.h"

@interface ZLNewListService (){
    NSString *_pageSize;
     NSString *_createTime;
     NSString *_type;
     NSString *_areaCode;
}

@end
@implementation ZLNewListService

- (instancetype)initWithpageSize:(NSString *)pageSize
                      createTime:(NSString *)createTime
                            type:(NSString *)type
                        areaCode:(NSString *)areaCode{
    self = [super init];
    if (self) {
        
        _pageSize = pageSize;
        _createTime = createTime;
        _type = type;
        _areaCode = areaCode;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_NewsListUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeHTTP;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeHTTP;
}

- (id)requestArgument{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _createTime,@"createTime",
                         _pageSize,@"pageSize",
                         _type,@"type",
                         _areaCode,@"areaCode",
                         nil];
    return dic;
    
}

@end
