//
//  ZLBadgeZeroService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/10/23.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLBadgeZeroService.h"

@interface ZLBadgeZeroService (){
    NSString *_uid;
}

@end

@implementation ZLBadgeZeroService
- (instancetype)initWithUid:(NSString *)uid{
    
    self = [super init];
    if (self) {
        _uid = uid;
    }
    return self;
    
}


- (NSString *)requestUrl {
    return TuiSongBadgeUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}


- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeHTTP;
}

- (id)requestArgument{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _uid,@"uid",
                         nil];
    return dic;

    
}

@end
