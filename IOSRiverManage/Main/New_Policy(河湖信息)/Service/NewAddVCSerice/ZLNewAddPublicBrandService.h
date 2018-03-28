//
//  ZLNewAddPublicBrandService.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/19.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLCustomBaseRequest.h"

@interface ZLNewAddPublicBrandService : ZLCustomBaseRequest
- (instancetype)initWithriverCode:(NSString *)riverCode
                             imgUrl:(NSString *)imgUrl
                             name:(NSString *)name
                        longitude:(NSString *)longitude
                         latitude:(NSString *)latitude
                           detail:(NSString *)detail;
@end
