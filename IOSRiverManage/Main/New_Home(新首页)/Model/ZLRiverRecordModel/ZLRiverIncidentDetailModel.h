//
//  ZLRiverIncidentDetailModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/20.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLRiverIncidentDetailModel

@end
@interface ZLRiverIncidentDetailModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *ID;

@property (nonatomic, strong) NSString<Optional> *incidentCode;
@property (nonatomic, strong) NSString<Optional> *incidentName;
@property (nonatomic, strong) NSString<Optional> *incidentStatus;

@property (nonatomic, strong) NSString<Optional> *incidentContent;

@property (nonatomic, strong) NSString<Optional> *incidentLevel;

@property (nonatomic, strong) NSString<Optional> *riverCode;

@property (nonatomic, strong) NSString<Optional> *patrolCode;
@property (nonatomic, strong) NSString<Optional> *longitude;


@property (nonatomic, strong) NSString<Optional> *latitude;
@property (nonatomic, strong) NSString<Optional> *positionDesc;
@property (nonatomic, strong) NSString<Optional> *completeTime;

@property (nonatomic, strong) NSString<Optional> *createBy;

@property (nonatomic, strong) NSString<Optional> *createName;
@property (nonatomic, strong) NSString<Optional> *areaCode;
@property (nonatomic, strong) NSString<Optional> *createTime;
@property (nonatomic, strong) NSString<Optional> *modifyTime;
@property (nonatomic, strong) NSString<Optional> *feedbackContent;
@property (nonatomic, strong) NSString<Optional> *receiverPersonName;
@property (nonatomic, strong) NSString<Optional> *receiverPersonCode;
@property (nonatomic, strong) NSString<Optional> *receiverType;
@property (nonatomic, strong) NSString<Optional> *groupCode;
@property (nonatomic, strong) NSString<Optional> *groupName;
@property (nonatomic, strong) NSArray<Optional> *imgFileList;
@property (nonatomic, strong) NSArray<Optional> *fileFileList;
@property (nonatomic, strong) NSArray<Optional> *riverIncidentDetailList;
@end
