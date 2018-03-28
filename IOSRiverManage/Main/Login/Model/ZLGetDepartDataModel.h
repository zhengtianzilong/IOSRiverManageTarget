//
//  ZLGetDepartModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
//{"code":0,"detail":"成功","data":[{"departCode":"321302HZB","areaCode":"321302","areaName":"宿城区","departName":"宿城河长办"}]}
@protocol ZLGetDepartDataModel

@end
@interface ZLGetDepartDataModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *departCode;

@property (nonatomic, strong) NSString<Optional> *areaCode;

@property (nonatomic, strong) NSString<Optional> *areaName;

@property (nonatomic, strong) NSString<Optional> *departName;
@end
