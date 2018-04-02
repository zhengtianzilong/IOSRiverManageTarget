//
//  ZLTaskFeedBackDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLTaskInfoImageListModel.h"
#import "ZLTaskInfoFileListModel.h"
@interface ZLTaskFeedBackDataModel : JSONModel

@property (nonatomic , strong) NSString<Optional>              *taskDetailCode;
@property (nonatomic , strong) NSString<Optional>              *taskParentCode;
@property (nonatomic , strong) NSString<Optional>              *taskContent;
@property (nonatomic , strong) NSString<Optional>              *taskChildCode;
@property (nonatomic , strong) NSString<Optional>               *userCode;
@property (nonatomic , strong) NSString<Optional>               *implementTime;
@property (nonatomic , strong) NSString<Optional>              *userName;
@property (nonatomic , strong) NSString<Optional>               *receiverType;
@property (nonatomic , strong) NSString<Optional>               *groupCode;
@property (nonatomic , strong) NSString<Optional>               *groupName;
@property (nonatomic , strong) NSString<Optional>               *taskDetailStatus;
@property (nonatomic , strong) NSString<Optional>               *feedbackContent;
@property (nonatomic , strong) NSString<Optional>               *approvalOpinion;
@property (nonatomic , strong) NSString<Optional>               *createBy;
@property (nonatomic , strong) NSString<Optional>               *ID;
@property (nonatomic , strong) NSString<Optional>            *createTime;
@property (nonatomic , strong) NSArray<ZLTaskInfoImageListModel, Optional>    * imgList;
@property (nonatomic , strong) NSString<Optional>               * isPass;
@property (nonatomic , strong) NSString<Optional>               *isReject;
@property (nonatomic , strong) NSArray<ZLTaskInfoFileListModel, Optional>   *fileList;


@end
