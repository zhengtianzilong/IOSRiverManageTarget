//
//  ZLTaskManageDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLTaskManageDataModel

@end
@interface ZLTaskManageDataModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *fileAddr;

@property (nonatomic, strong) NSString<Optional> *taskHaveRiver;

@property (nonatomic, strong) NSString<Optional> *taskCode;

@property (nonatomic, strong) NSString<Optional> *taskContent;

@property (nonatomic, strong) NSString<Optional> *createTime;

@property (nonatomic, strong) NSString<Optional> *taskName;

@property (nonatomic, strong) NSString<Optional> *userName;

@property (nonatomic, strong) NSString<Optional> *taskId;

@property (nonatomic, strong) NSString<Optional> *taskStatus;

@property (nonatomic, strong) NSString<Optional> *createName;
@end
