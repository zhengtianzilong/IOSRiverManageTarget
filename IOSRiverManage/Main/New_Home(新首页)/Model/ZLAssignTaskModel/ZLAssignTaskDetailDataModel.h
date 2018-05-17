//
//  ZLAssignTaskDetailDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLAssignTaskDetailDataModel

@end
@interface ZLAssignTaskDetailDataModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *ID;
@property (nonatomic, strong) NSString<Optional> *assignCode;

@property (nonatomic, strong) NSString<Optional> *assignName;
@property (nonatomic, strong) NSString<Optional> *assignStatus;
@property (nonatomic, strong) NSString<Optional> *assignContent;
@property (nonatomic, strong) NSString<Optional> *remark;
@property (nonatomic, strong) NSString<Optional> *isExpire;
@property (nonatomic, strong) NSString<Optional> *warnTime;


@property (nonatomic, strong) NSString<Optional> *completeTime;

@property (nonatomic, strong) NSString<Optional> *respUnit;
@property (nonatomic, strong) NSString<Optional> *respPerson;
@property (nonatomic, strong) NSString<Optional> *feedbackContent;

@property (nonatomic, strong) NSString<Optional> *readUser;
@property (nonatomic, strong) NSString<Optional> *superviseCode;
@property (nonatomic, strong) NSString<Optional> *createBy;
@property (nonatomic, strong) NSString<Optional> *createTime;
@property (nonatomic, strong) NSString<Optional> *areaCode;
@property (nonatomic, strong) NSString<Optional> *modifyTime;
@property (nonatomic, strong) NSArray<Optional> *fileList;
@property (nonatomic, strong) NSString<Optional> *userName;
@property (nonatomic, strong) NSString<Optional> *departName;
@property (nonatomic, strong) NSString<Optional> *readUserNames;
@end
