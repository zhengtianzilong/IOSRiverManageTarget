//
//  ZLGetNowAreaRiverListService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLGetNowAreaRiverListService.h"
@interface ZLGetNowAreaRiverListService (){
    NSInteger _pageSize;
    NSString *_appPageCreateTime;
}

@end
@implementation ZLGetNowAreaRiverListService

- (instancetype)initWithpageSize:(NSInteger)pageSize
               appPageCreateTime:(NSString *)appPageCreateTime{
    self = [super init];
    if (self) {
        
        _pageSize = pageSize;
        _appPageCreateTime = appPageCreateTime;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_GetNowAreaRiverListForAppUrl;
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
                         _appPageCreateTime,@"appPageCreateTime",
                         @(_pageSize),@"pageSize",
                         nil];
    return dic;
    
}
@end
