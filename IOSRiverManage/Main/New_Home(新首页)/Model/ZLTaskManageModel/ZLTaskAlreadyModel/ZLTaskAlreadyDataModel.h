//
//  ZLTaskAlreadyDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ZLTaskAlreadyDataModel

@end

@interface ZLTaskAlreadyDataModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *fileAddr;

@property (nonatomic, strong) NSString<Optional> *taskHaveRiver;

@property (nonatomic, strong) NSString<Optional> *completeTime;

@property (nonatomic, strong) NSString<Optional> *taskContent;

@property (nonatomic, strong) NSString<Optional> *createTime;

@property (nonatomic, strong) NSString<Optional> *taskName;

@property (nonatomic, strong) NSString<Optional> *userName;

@property (nonatomic, strong) NSString<Optional> *taskId;

@property (nonatomic, strong) NSString<Optional> *status;

@property (nonatomic, strong) NSString<Optional> *createName;
@end
