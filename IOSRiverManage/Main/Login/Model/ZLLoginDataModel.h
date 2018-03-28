//
//  ZLLoginDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/14.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ZLLoginDataModel : JSONModel
@property (nonatomic ,strong) NSString<Optional> *areaCode;

@property (nonatomic ,strong) NSString<Optional> *duty;

@property (nonatomic ,strong) NSString<Optional> *isclerk;

@property (nonatomic ,strong) NSString<Optional> *userName;

@property (nonatomic ,strong) NSString<Optional> *userId;

@property (nonatomic ,strong) NSString<Optional> *token;
@end
