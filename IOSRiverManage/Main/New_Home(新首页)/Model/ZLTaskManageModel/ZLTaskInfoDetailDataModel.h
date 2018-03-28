//
//  ZLTaskInfoDetailDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ZLTaskInfoImageListModel.h"
#import "ZLTaskInfoFileListModel.h"

#import "ZLTaskIncidentListModel.h"
#import "ZLTaskRiverTaskDetailListModel.h"

@interface ZLTaskInfoDetailDataModel : JSONModel
@property (nonatomic , strong) NSString<Optional>              * receiverDepartmentNames;
@property (nonatomic , strong) NSString<Optional>              * taskName;
@property (nonatomic , strong) NSString<Optional>              * taskContent;
@property (nonatomic , strong) NSString<Optional>              * patrolCode;
@property (nonatomic , strong) NSString<Optional>          *pageSize;
@property (nonatomic , strong) NSString<Optional>               * completeTime;
@property (nonatomic , strong) NSString<Optional>              * completeEndTime;
@property (nonatomic , strong) NSString<Optional>               * updateTime;
@property (nonatomic , strong) NSString<Optional>               * createStartTime;
@property (nonatomic , strong) NSString<Optional>               *currentPage;
@property (nonatomic , strong) NSString<Optional>               *latitude;
@property (nonatomic , strong) NSString<Optional>               * positionDesc;
@property (nonatomic , strong) NSString<Optional>               * completeStartTime;
@property (nonatomic , strong) NSString<Optional>               * createEndTime;
@property (nonatomic , strong) NSString<Optional>               * ID;
@property (nonatomic , strong) NSString<Optional>            *taskLevel;
@property (nonatomic , strong) NSArray<ZLTaskInfoImageListModel, Optional>    * imgList;
@property (nonatomic , strong) NSString<Optional>               * createBy;
@property (nonatomic , strong) NSString<Optional>               *longitude;
@property (nonatomic , strong) NSString<Optional>               * receiverPersonNames;
@property (nonatomic , strong) NSString<Optional>               * taskCode;
@property (nonatomic , strong) NSString<Optional>               * createTimeFormat;
@property (nonatomic , strong) NSString<Optional>               * receiverDepartmentCodes;
@property (nonatomic , strong) NSString<Optional>               * riverCode;
@property (nonatomic , strong) NSString<Optional>             *taskStatus;
@property (nonatomic , strong) NSArray<ZLTaskInfoFileListModel, Optional>   *fileList;
@property (nonatomic , strong) NSString<Optional>               * createName;
@property (nonatomic , strong) NSString<Optional>               *createTime;
@property (nonatomic , strong) NSString<Optional>               *taskHaveRiver;
@property (nonatomic , strong) NSString<Optional>               * userName;
@property (nonatomic , strong) NSString<Optional>               * areaCode;
@property (nonatomic , strong) NSString<Optional>               * receiverPersonIds;

@property (nonatomic , strong) NSArray<ZLTaskIncidentListModel, Optional>   *incidentList;
@property (nonatomic , strong) NSArray<ZLTaskRiverTaskDetailListModel, Optional> *riverTaskDetailList;

@end
