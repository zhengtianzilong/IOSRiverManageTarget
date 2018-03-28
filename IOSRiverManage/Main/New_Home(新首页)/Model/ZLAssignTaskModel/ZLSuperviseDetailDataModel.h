//
//  ZLSuperviseDetailDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZLSuperviseDetailDataModel

@end
@interface ZLSuperviseDetailDataModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *ID;
@property (nonatomic, strong) NSString<Optional> *superviseCode;

@property (nonatomic, strong) NSString<Optional> *superviseName;
@property (nonatomic, strong) NSString<Optional> *superviseStatus;
@property (nonatomic, strong) NSString<Optional> *superviseContent;
@property (nonatomic, strong) NSString<Optional> *superviseTime;

@property (nonatomic, strong) NSString<Optional> *superviseUnit;


@property (nonatomic, strong) NSString<Optional> *remark;

@property (nonatomic, strong) NSString<Optional> *areaCode;
@property (nonatomic, strong) NSString<Optional> *createBy;
@property (nonatomic, strong) NSString<Optional> *createTime;

@property (nonatomic, strong) NSString<Optional> *modifyTime;

@end
