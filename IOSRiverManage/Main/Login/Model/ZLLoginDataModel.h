//
//  ZLLoginDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/14.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ZLFunctionListModel.h"
@interface ZLLoginDataModel : JSONModel
@property (nonatomic ,strong) NSString<Optional> *areaCode;

@property (nonatomic ,strong) NSString<Optional> *duty;

@property (nonatomic ,strong) NSString<Optional> *isclerk;

@property (nonatomic ,strong) NSString<Optional> *userName;

@property (nonatomic ,strong) NSString<Optional> *userId;

@property (nonatomic ,strong) NSString<Optional> *token;

@property (nonatomic ,strong) NSString<Optional> *fileServerAddr;

@property (nonatomic ,strong) NSArray<Optional, ZLFunctionListModel> *functionList;

@end
