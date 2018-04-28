//
//  ZLNewAddOutletService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/19.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewAddOutletService.h"
@interface ZLNewAddOutletService (){
    NSString *_riverCode;
    NSString *_code;
    NSString *_name;
    NSString *_longitude;
    NSString *_latitude;
    NSString *_contant;
    NSString *_contactperson;
    NSString *_phone;
    NSString *_address;
    NSArray *_imgList;
}

@end
@implementation ZLNewAddOutletService

- (instancetype)initWithriverCode:(NSString *)riverCode
                             code:(NSString *)code
                             name:(NSString *)name
                        longitude:(NSString *)longitude
                         latitude:(NSString *)latitude
                          contant:(NSString *)contant
                    contactPerson:(NSString *)contactPerson
                            phone:(NSString *)phone
                          address:(NSString *)address
                          imgList:(NSArray *)imgList{
    self = [super init];
    if (self) {
        
        _riverCode = riverCode;
        
        _code = code;
        _name = name;
        _latitude = latitude;
        _longitude = longitude;
        _contant = contant;
        _contactperson = contactPerson;
        _phone = phone;
        _address = address;
        _imgList = imgList;
    }
    return self;
}


- (NSString *)requestUrl {
    return River_AddSewageUrl;
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
                         _imgList , @"imgList",
                         _riverCode,@"riverCode",
                         _code,@"code",
                         _name,@"name",
                         @"",@"departid",
                         _longitude,@"longitude",
                         _latitude,@"latitude",
                         @"",@"isStandard",
                         @"",@"status",
                         _contant,@"contant",
                         _contactperson,@"contactPerson",
                         _phone,@"phone",
                         _address,@"address",
                         nil];
    return dic;
    
}
@end
