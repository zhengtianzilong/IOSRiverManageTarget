//
//  ZLGetEventUserListDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLGetEventUserListDataModel

@end
@interface ZLGetEventUserListDataModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *realName;

@property (nonatomic, strong) NSString<Optional> *areaCode;

@property (nonatomic, strong) NSString<Optional> *riverNames;

@property (nonatomic, strong) NSString<Optional> *areaName;

@property (nonatomic, strong) NSString<Optional> *userCode;

@end
