//
//  ZLTaskRiverTaskDetailListModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ZLTaskInfoFileListModel.h"
#import "ZLTaskInfoImageListModel.h"
@protocol ZLTaskRiverTaskDetailListModel

@end
@interface ZLTaskRiverTaskDetailListModel : JSONModel
@property (nonatomic , copy) NSString<Optional>              * ID;
@property (nonatomic , copy) NSString<Optional>              * taskDetailCode;
@property (nonatomic , copy) NSString<Optional>              * taskParentCode;
@property (nonatomic , copy) NSString<Optional>              * taskChildCode;
@property (nonatomic , copy) NSString<Optional>              * userCode;

@property (nonatomic , copy) NSString<Optional>              * implementTime;

@property (nonatomic , copy) NSString<Optional>              * userName;

@property (nonatomic , copy) NSString<Optional>              * receiverType;

@property (nonatomic , copy) NSString<Optional>              * groupCode;
@property (nonatomic , copy) NSString<Optional>              * groupName;
@property (nonatomic , copy) NSString<Optional>              * taskDetailStatus;
@property (nonatomic , copy) NSString<Optional>              * feedbackContent;
@property (nonatomic , copy) NSString<Optional>              * approvalOpinion;
@property (nonatomic , copy) NSString<Optional>              * createBy;
@property (nonatomic , copy) NSString<Optional>              * createTime;
@property (nonatomic , copy) NSString<Optional>              * isPass;
@property (nonatomic , copy) NSString<Optional>              * isReject;
@property (nonatomic , copy) NSArray<Optional, ZLTaskInfoImageListModel>              * imgList;
@property (nonatomic , copy) NSArray<Optional, ZLTaskInfoFileListModel>              * fileList;
@end
