//
//  ZLEventManagerReportDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLEventManagerReportDataModel

@end
@interface ZLEventManagerReportDataModel : JSONModel

@property (nonatomic , copy) NSString<Optional>              *patrolCode;
@property (nonatomic , copy) NSString<Optional>              *incidentStatus;
@property (nonatomic , copy) NSString<Optional>              *incidentName;
@property (nonatomic , copy) NSString<Optional>              *latitude;
@property (nonatomic , copy) NSString<Optional>              *incidentContent;
@property (nonatomic , copy) NSString<Optional>              *receiverType;
@property (nonatomic , copy) NSString<Optional>              *positionDesc;
@property (nonatomic , copy) NSString<Optional>              *detailId;
@property (nonatomic , copy) NSString<Optional>              *ID;
@property (nonatomic , copy) NSString<Optional>              *createBy;
@property (nonatomic , copy) NSString<Optional>              *incidentDetailStatus;
@property (nonatomic , copy) NSString<Optional>              *longitude;
@property (nonatomic , copy) NSString<Optional>              * userCode;
@property (nonatomic , copy) NSString<Optional>              * groupCode;
@property (nonatomic , copy) NSString<Optional>              * incidentCode;
@property (nonatomic , copy) NSString<Optional>              * riverCode;
@property (nonatomic , copy) NSString<Optional>              * groupName;
@property (nonatomic , copy) NSString<Optional>              * userName;
@property (nonatomic , copy) NSString<Optional>              * createTime;
@property (nonatomic , copy) NSString<Optional>              * createName;
@property (nonatomic , copy) NSString<Optional>              * incidentDetailCode;
@property (nonatomic , copy) NSString<Optional>              * imgUrl;
@end
