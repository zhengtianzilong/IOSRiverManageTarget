//
//  ZLRiverRecordDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/20.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLRiverRecordDataModel

@end
@interface ZLRiverRecordDataModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *START_TIME;

@property (nonatomic, strong) NSString<Optional> *RIVER_CODE;
@property (nonatomic, strong) NSString<Optional> *PATROL_CODE;
@property (nonatomic, strong) NSString<Optional> *END_DESC;

@property (nonatomic, strong) NSString<Optional> *riverName;

@property (nonatomic, strong) NSString<Optional> *START_DESC;

@property (nonatomic, strong) NSString<Optional> *USER_CODE;

@property (nonatomic, strong) NSString<Optional> *START_LONGITUDE;
@property (nonatomic, strong) NSString<Optional> *END_LONGITUDE;


@property (nonatomic, strong) NSString<Optional> *START_LATITUDE;
@property (nonatomic, strong) NSString<Optional> *END_LATITUDE;
@property (nonatomic, strong) NSString<Optional> *END_TIME;

@property (nonatomic, strong) NSString<Optional> *ID;



@end
