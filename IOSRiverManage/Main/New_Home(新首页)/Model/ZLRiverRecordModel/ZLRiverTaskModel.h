//
//  ZLRiverTaskModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/20.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLRiverTaskModel

@end
@interface ZLRiverTaskModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *ID;

@property (nonatomic, strong) NSString<Optional> *taskCode;
@property (nonatomic, strong) NSString<Optional> *taskName;
@property (nonatomic, strong) NSString<Optional> *taskStatus;

@property (nonatomic, strong) NSString<Optional> *taskContent;

@property (nonatomic, strong) NSString<Optional> *taskLevel;

@property (nonatomic, strong) NSString<Optional> *riverCode;

@property (nonatomic, strong) NSString<Optional> *patrolCode;
@property (nonatomic, strong) NSString<Optional> *longitude;


@property (nonatomic, strong) NSString<Optional> *latitude;
@property (nonatomic, strong) NSString<Optional> *positionDesc;
@property (nonatomic, strong) NSString<Optional> *updateTime;
@property (nonatomic, strong) NSString<Optional> *completeTime;
@property (nonatomic, strong) NSString<Optional> *createBy;

@property (nonatomic, strong) NSString<Optional> *createName;
@property (nonatomic, strong) NSString<Optional> *areaCode;
@property (nonatomic, strong) NSString<Optional> *createTime;
@property (nonatomic, strong) NSString<Optional> *receiverPersonIds;
@property (nonatomic, strong) NSString<Optional> *receiverPersonNames;
@property (nonatomic, strong) NSString<Optional> *receiverDepartmentCodes;
@property (nonatomic, strong) NSString<Optional> *receiverDepartmentNames;
@end
