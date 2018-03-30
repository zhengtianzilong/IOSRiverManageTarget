//
//  ZLRiverIncidentDetailListModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/30.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ZLTaskInfoFileListModel.h"
#import "ZLTaskInfoImageListModel.h"
@protocol ZLRiverIncidentDetailListModel

@end
@interface ZLRiverIncidentDetailListModel : JSONModel
@property (nonatomic , copy) NSArray<ZLTaskInfoImageListModel, Optional>              * imgListDetail;
@property (nonatomic , copy) NSString<Optional>              * receiverDepartName;
@property (nonatomic , copy) NSString<Optional>              * receiverPersonName;
@property (nonatomic , copy) NSString<Optional>              *updateTime;
@property (nonatomic , copy) NSString<Optional>              * feedbackContent;
@property (nonatomic , copy) NSArray<ZLTaskInfoFileListModel, Optional>              * fileListDetail;
@property (nonatomic , copy) NSString<Optional>              * incidentNextCode;
@property (nonatomic , copy) NSString<Optional>              *receiverType;
@property (nonatomic , copy) NSString<Optional>              * ID;
@property (nonatomic , copy) NSString<Optional>              * createBy;
@property (nonatomic , copy) NSString<Optional>              *incidentDetailStatus;
@property (nonatomic , copy) NSString<Optional>              * userCode;
@property (nonatomic , copy) NSString<Optional>              * groupCode;
@property (nonatomic , copy) NSString<Optional>              * incidentCode;
@property (nonatomic , copy) NSString<Optional>              * riverIncidentDetailId;
@property (nonatomic , copy) NSString<Optional>              * groupName;
@property (nonatomic , copy) NSString<Optional>              * userName;
@property (nonatomic , copy) NSString<Optional>              *createTime;
@property (nonatomic , copy) NSString<Optional>              * createName;
@property (nonatomic , copy) NSString<Optional>              * receiverPersonCode;
@property (nonatomic , copy) NSString<Optional>              * receiverDepartCode;
@property (nonatomic , copy) NSString<Optional>              * incidentDetailCode;
@end
