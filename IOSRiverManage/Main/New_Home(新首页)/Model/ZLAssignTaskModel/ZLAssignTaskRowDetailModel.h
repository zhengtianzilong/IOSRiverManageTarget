//
//  ZLAssignTaskRowDetailModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/21.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLAssignTaskRowDetailModel

@end
@interface ZLAssignTaskRowDetailModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *assignContent;

@property (nonatomic, strong) NSString<Optional> *createBy;

@property (nonatomic, strong) NSString<Optional> *assignCode;

@property (nonatomic, strong) NSString<Optional> *assignStatus;

@property (nonatomic, strong) NSString<Optional> *createTime;

@property (nonatomic, strong) NSString<Optional> *assignName;

@property (nonatomic, strong) NSString<Optional> *respPerson;

@property (nonatomic, strong) NSString<Optional> *completeTime;

@property (nonatomic, strong) NSString<Optional> *ID;

@property (nonatomic, strong) NSString<Optional> *isExpire;

@property (nonatomic, strong) NSString<Optional> *respUnit;


@end
