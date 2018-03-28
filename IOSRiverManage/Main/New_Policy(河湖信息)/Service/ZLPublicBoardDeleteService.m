//
//  ZLPublicBoardDeleteService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/19.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLPublicBoardDeleteService.h"
@interface ZLPublicBoardDeleteService (){
    NSString *_idCode;
}

@end
@implementation ZLPublicBoardDeleteService

- (instancetype)initWithidCode:(NSString *)idCode{
    self = [super init];
    if (self) {
        
        _idCode = idCode;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return River_PublicBoardDeleteUrl;
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
                         _idCode,@"brandCode",
                         
                         nil];
    return dic;
    
}
@end
