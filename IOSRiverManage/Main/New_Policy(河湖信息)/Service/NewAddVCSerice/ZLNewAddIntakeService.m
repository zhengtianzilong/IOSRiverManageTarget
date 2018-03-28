//
//  ZLNewAddIntakeService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/19.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewAddIntakeService.h"
@interface ZLNewAddIntakeService (){
    NSString *_riverCode;
    NSString *_code;
    NSString *_name;
    NSString *_longitude;
    NSString *_latitude;
    NSString *_contant;
    NSString *_contactperson;
    NSString *_phone;
    NSString *_address;
}

@end
@implementation ZLNewAddIntakeService

- (instancetype)initWithriverCode:(NSString *)riverCode
                             code:(NSString *)code
                             name:(NSString *)name
                        longitude:(NSString *)longitude
                         latitude:(NSString *)latitude
                          contant:(NSString *)contant
                    contactperson:(NSString *)contactperson
                            phone:(NSString *)phone
                          address:(NSString *)address{
    self = [super init];
    if (self) {
        
        _riverCode = riverCode;
        
        _code = code;
        _name = name;
        _latitude = latitude;
        _longitude = longitude;
        _contant = contant;
        _contactperson = contactperson;
        _phone = phone;
        _address = address;   
    }
    return self;
}


- (NSString *)requestUrl {
    return River_AddIntakeUrl;
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
                         _code,@"code",
                         _name,@"name",
                         @"",@"departmentCode",
                         @"",@"organization",
                         _longitude,@"longitude",
                         _latitude,@"latitude",
                         @"",@"lastWaterQuality",
                         @"",@"currentWaterQuality",
                         @"",@"isStandard",
                         @"",@"status",
                         _contant,@"contant",
                         _contactperson,@"contactperson",
                         _phone,@"phone",
                         @"",@"legalperson",
                         @"",@"lesence",
                         @"",@"avgWater",
                         _address,@"address",
                         nil];
    return dic;
    
}
@end
