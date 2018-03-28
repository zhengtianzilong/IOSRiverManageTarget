//
//  ZLEventObjectService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/22.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLEventObjectService.h"
@interface ZLEventObjectService (){
    NSString *_uid;
    NSString *_riverId;
}

@end
@implementation ZLEventObjectService
- (instancetype)initWithuid:(NSString *)uid riverId:(NSString *)riverId{
    self = [super init];
    if (self) {
        
        _uid = uid;
        _riverId = riverId;
    }
    return self;
}
- (NSString *)requestUrl {
    return River_UpTaskUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSTimeInterval)requestTimeoutInterval{
    return 10;
}

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeHTTP;
}


- (id)requestArgument{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _uid,@"id",
                         _riverId,@"riverId",
                         nil];
    return dic;   
}

@end
