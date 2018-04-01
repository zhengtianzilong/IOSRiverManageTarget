//
//  ZLEventDetailDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ZLTaskInfoImageListModel.h"
#import "ZLTaskInfoFileListModel.h"
#import "ZLTaskIncidentListModel.h"
#import "ZLRiverIncidentDetailListModel.h"
@interface ZLEventDetailDataModel : JSONModel

@property (nonatomic , copy) NSString<Optional>              *modifyTime;
@property (nonatomic , copy) NSString<Optional>              *patrolCode;
@property (nonatomic , copy) NSString<Optional>              *receiverDepartName;
@property (nonatomic , copy) NSString<Optional>              *incidentStatus;
@property (nonatomic , copy) NSString<Optional>              *completeTime;
@property (nonatomic , copy) NSString<Optional>              *incidentName;
@property (nonatomic , copy) NSString<Optional>              *receiverPersonName;
@property (nonatomic , copy) NSArray<ZLTaskIncidentListModel, Optional>              * incidentList;
@property (nonatomic , copy) NSArray<ZLRiverIncidentDetailListModel, Optional>              * riverIncidentDetailList;
@property (nonatomic , copy) NSString<Optional>              * feedbackContent;
@property (nonatomic , copy) NSString<Optional>              *latitude;
@property (nonatomic , copy) NSString<Optional>              * incidentLevel;
@property (nonatomic , copy) NSString<Optional>              * incidentContent;
@property (nonatomic , copy) NSString<Optional>              * positionDesc;
@property (nonatomic , copy) NSString<Optional>              * receiverType;
@property (nonatomic , copy) NSString<Optional>              * ID;
@property (nonatomic , copy) NSArray<ZLTaskInfoImageListModel, Optional>              *imgList;
@property (nonatomic , copy) NSString<Optional>              * createBy;
@property (nonatomic , copy) NSString<Optional>              *longitude;
@property (nonatomic , copy) NSArray<ZLTaskInfoFileListModel,  Optional>              * fileList;
@property (nonatomic , copy) NSString<Optional>              * incidentCode;
@property (nonatomic , copy) NSString<Optional>              * riverCode;
@property (nonatomic , copy) NSString<Optional>              * createName;
@property (nonatomic , copy) NSString<Optional>              *createTime;
@property (nonatomic , copy) NSString<Optional>              * areaCode;
@property (nonatomic , copy) NSString<Optional>              * receiverPersonCode;
@property (nonatomic , copy) NSString<Optional>              * receiverDepartCode;


@end

