//
//  ZLNewUserRiversDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/15.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ZLFunctionListModel.h"
@protocol ZLNewUserRiversDataModel

@end
@interface ZLNewUserRiversDataModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *endDesc;

@property (nonatomic, strong) NSString<Optional> *riverLength;

@property (nonatomic, strong) NSString<Optional> *nowadaysQuality;

@property (nonatomic, strong) NSString<Optional> *isStandard;

@property (nonatomic, strong) NSString<Optional> *latitude;

@property (nonatomic, strong) NSString<Optional> *riverGrade;

@property (nonatomic, strong) NSString<Optional> *riverCode;


@property (nonatomic, strong) NSString<Optional> *startDesc;

@property (nonatomic, strong) NSString<Optional> *riverName;

@property (nonatomic, strong) NSString<Optional> *longitude;

@property (nonatomic, strong) NSString<Optional> *createTime;

@property (nonatomic, strong) NSString<Optional> *ID;

@end
