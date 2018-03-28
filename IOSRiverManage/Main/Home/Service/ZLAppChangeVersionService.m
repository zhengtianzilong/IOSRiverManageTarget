//
//  ZLAppChangeVersionService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/30.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLAppChangeVersionService.h"
@interface ZLAppChangeVersionService (){
    NSString *_version;
    NSString *_uid;

}

@end
@implementation ZLAppChangeVersionService
- (instancetype)initWithversion:(NSString *)version
                              uid:(NSString *)uid
{
    
    self = [super init];
    if (self) {
        _version = version;
        _uid = uid;
        
    }
    return self;
    
}


- (NSString *)requestUrl {
    return App_ChangeVersion;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}


- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeHTTP;
}

//- (YTKResponseSerializerType)responseSerializerType{
//    return YTKResponseSerializerTypeHTTP;
//}

- (id)requestArgument{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _version,@"version",
                         _uid,@"userId",
                         nil];
    return dic;
    

    
}
@end
