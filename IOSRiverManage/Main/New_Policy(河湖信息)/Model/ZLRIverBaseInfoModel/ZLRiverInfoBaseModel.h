//
//  ZLRiverInfoBaseModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLRiverInfoBaseModel

@end
@interface ZLRiverInfoBaseModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *TARGET;
@property (nonatomic, strong) NSString<Optional> *RIVER_DESC;
@property (nonatomic, strong) NSString<Optional> *RIVER_NUMBER;
@property (nonatomic, strong) NSString<Optional> *LINEAREA;
@property (nonatomic, strong) NSString<Optional> *LONGITUDE;
@property (nonatomic, strong) NSString<Optional> *AREA_CODE;
@property (nonatomic, strong) NSString<Optional> *LATITUDE_START;
@property (nonatomic, strong) NSString<Optional> *SHORT_NAME;
@property (nonatomic, strong) NSString<Optional> *START_DESC;
@property (nonatomic, strong) NSString<Optional> *LONGITUDE_START;
@property (nonatomic, strong) NSString<Optional> *RIVER_RANGE;
@property (nonatomic, strong) NSString<Optional> *LONGITUDE_END;
@property (nonatomic, strong) NSString<Optional> *RIVER_LEVEL;
@property (nonatomic, strong) NSString<Optional> *LGLTS;
@property (nonatomic, strong) NSString<Optional> *RIVER_PROFILE;
@property (nonatomic, strong) NSString<Optional> *RIVER_CODE;
@property (nonatomic, strong) NSString<Optional> *AREA_NAME;
@property (nonatomic, strong) NSString<Optional> *R_PARENT_NAME;
@property (nonatomic, strong) NSString<Optional> *LATITUDE_END;
@property (nonatomic, strong) NSString<Optional> *RIVER_POLICY;
@property (nonatomic, strong) NSString<Optional> *END_DESC;
@property (nonatomic, strong) NSString<Optional> *RIVER_GRADE;
@property (nonatomic, strong) NSString<Optional> *PARENT_CODE;
@property (nonatomic, strong) NSString<Optional> *RIVER_LENGTH;
@property (nonatomic, strong) NSString<Optional> *DUTY;
@property (nonatomic, strong) NSString<Optional> *RIVER_NAME;
@property (nonatomic, strong) NSString<Optional> *IS_STANDARD;
@property (nonatomic, strong) NSString<Optional> *LATITUDE;
@end
