//
//  ZLRiverPatrolInfoModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ZLRiverPatrolInfoModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *ID;
@property (nonatomic, strong) NSString<Optional> *patrolCode;
@property (nonatomic, strong) NSString<Optional> *userCode;
@property (nonatomic, strong) NSString<Optional> *riverCode;

@property (nonatomic, strong) NSString<Optional> *startTime;

@property (nonatomic, strong) NSString<Optional> *endTime;

@property (nonatomic, strong) NSString<Optional> *startLongitude;

@property (nonatomic, strong) NSString<Optional> *startLatitude;
@property (nonatomic, strong) NSString<Optional> *startDesc;
@property (nonatomic, strong) NSString<Optional> *endLongitude;
@property (nonatomic, strong) NSString<Optional> *endLatitude;
@property (nonatomic, strong) NSString<Optional> *endDesc;
@property (nonatomic, strong) NSString<Optional> *isDelete;
@property (nonatomic, strong) NSString<Optional> *isStatistics;

@property (nonatomic, strong) NSString<Optional> *riverName;
@property (nonatomic, strong) NSString<Optional> *areaCode;
@property (nonatomic, strong) NSString<Optional> *areaName;
@property (nonatomic, strong) NSString<Optional> *realName;
@end
