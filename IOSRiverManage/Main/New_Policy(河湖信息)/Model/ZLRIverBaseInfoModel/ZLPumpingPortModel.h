//
//  ZLPumpingPortModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ZLTaskInfoImageListModel.h"
@protocol ZLPumpingPortModel
@end
@interface ZLPumpingPortModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *ID;
@property (nonatomic, strong) NSString<Optional> *CONTACTPERSON;
@property (nonatomic, strong) NSString<Optional> *RIVER_CODE;
@property (nonatomic, strong) NSString<Optional> *LONGITUDE;
@property (nonatomic, strong) NSString<Optional> *PHONE;
@property (nonatomic, strong) NSString<Optional> *LEGALPERSON;
@property (nonatomic, strong) NSString<Optional> *DEPARTMENT_CODE;
@property (nonatomic, strong) NSString<Optional> *AVG_WATER;
@property (nonatomic, strong) NSString<Optional> *NAME;
@property (nonatomic, strong) NSString<Optional> *LESENCE;
@property (nonatomic, strong) NSString<Optional> *ORGANIZATION;
@property (nonatomic, strong) NSString<Optional> *STATUS;
@property (nonatomic, strong) NSString<Optional> *CODE;
@property (nonatomic, strong) NSString<Optional> *CONTANT;
@property (nonatomic, strong) NSString<Optional> *ADDRESS;
@property (nonatomic, strong) NSString<Optional> *CURRENT_WATER_QUALITY;
@property (nonatomic, strong) NSString<Optional> *LAST_WATER_QUALITY;
@property (nonatomic, strong) NSString<Optional> *IS_STANDARD;
@property (nonatomic, strong) NSString<Optional> *LATITUDE;
@property (nonatomic, strong) NSString<Optional> *AREA_NAME;

@property (nonatomic, strong) NSArray<ZLTaskInfoImageListModel, Optional> *imgList;

@end
