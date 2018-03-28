//
//  ZLNewAddPublicBrandService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/19.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewAddPublicBrandService.h"
@interface ZLNewAddPublicBrandService (){
    NSString *_riverCode;
    NSString *_name;
    NSString *_longitude;
    NSString *_latitude;
    NSString *_address;
    NSString *_imageUrl;
}

@end
@implementation ZLNewAddPublicBrandService

- (instancetype)initWithriverCode:(NSString *)riverCode
                           imgUrl:(NSString *)imgUrl
                             name:(NSString *)name
                        longitude:(NSString *)longitude
                         latitude:(NSString *)latitude
                           detail:(NSString *)detail{
    self = [super init];
    if (self) {
        
        _riverCode = riverCode;
        _imageUrl = imgUrl;
        _name = name;
        _latitude = latitude;
        _longitude = longitude;
        _address = detail;
    }
    return self;
}


- (NSString *)requestUrl {
    return River_AddBrandUrl;
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
                         _riverCode,@"riverCode",
                         _name,@"name",
                         _longitude,@"longitude",
                         _latitude,@"latitude",
                         _imageUrl,@"imgUrl",
                         _address,@"detail",
                         nil];
    return dic;
    
}
@end
