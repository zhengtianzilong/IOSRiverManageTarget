//
//  ZLNewAddressBookDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/15.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ZLNewAddressBookDataModel

@end


@interface ZLNewAddressBookDataModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *realName;

@property (nonatomic, strong) NSString<Optional> *phone;
@property (nonatomic, strong) NSString<Optional> *telephone;
@property (nonatomic, strong) NSString<Optional> *userName;

@property (nonatomic, strong) NSString<Optional> *job;

@property (nonatomic, strong) NSString<Optional> *userCode;

@property (nonatomic, strong) NSString<Optional> *dutyName;

@property (nonatomic, strong) NSString<Optional> *rivers;


@end
