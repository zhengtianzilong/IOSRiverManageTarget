//
//  ZLRiverPeopleLowerModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLRiverPeopleLowerModel

@end
@interface ZLRiverPeopleLowerModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *dutyName;
@property (nonatomic, strong) NSString<Optional> *phone;
@property (nonatomic, strong) NSString<Optional> *realName;
@property (nonatomic, strong) NSString<Optional> *duty;
@property (nonatomic, strong) NSString<Optional> *userCode;
@end
