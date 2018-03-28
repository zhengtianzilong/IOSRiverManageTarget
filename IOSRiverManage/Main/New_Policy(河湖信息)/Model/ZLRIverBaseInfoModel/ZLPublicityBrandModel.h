//
//  ZLPublicityBrandModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLPublicityBrandModel

@end
@interface ZLPublicityBrandModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *PUBLICITY_BRAND_URL;
@property (nonatomic, strong) NSString<Optional> *AREA_NAME;
@property (nonatomic, strong) NSString<Optional> *PUBLICITY_BRAND_LATITUDE;
@property (nonatomic, strong) NSString<Optional> *PUBLICITY_BRAND_LONGITUDE;
@property (nonatomic, strong) NSString<Optional> *DETAIL;

@property (nonatomic, strong) NSString<Optional> *PUBLICITY_BRAND_CODE;

@property (nonatomic, strong) NSString<Optional> *PUBLICITY_BRAND_NAME;

@end
