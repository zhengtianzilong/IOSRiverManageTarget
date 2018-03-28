//
//  ZLNewAddOutletService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/19.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"
@interface ZLNewAddOutletService : ZLCustomBaseRequest
- (instancetype)initWithriverCode:(NSString *)riverCode
                             code:(NSString *)code
                             name:(NSString *)name
                        longitude:(NSString *)longitude
                         latitude:(NSString *)latitude
                          contant:(NSString *)contant
                    contactPerson:(NSString *)contactPerson
                            phone:(NSString *)phone
                          address:(NSString *)address;
@end
