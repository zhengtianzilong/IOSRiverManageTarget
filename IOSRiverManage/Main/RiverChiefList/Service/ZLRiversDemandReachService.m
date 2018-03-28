//
//  ZLRiversDemandReachService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/21.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLRiversDemandReachService.h"
@interface ZLRiversDemandReachService (){
    NSString *_uidCode;
}

@end
@implementation ZLRiversDemandReachService
- (instancetype)initWithUidCode:(NSString *)uidCode{
    self = [super init];
    if (self) {
        _uidCode = uidCode;
        
    }
    return self;
}
- (NSString *)requestUrl {
    return River_DemandReachUrl;
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
                         _uidCode,@"uid",
                         nil];
    return dic;
//    return @{@"uid":_uidCode
//             };
    
}

@end
