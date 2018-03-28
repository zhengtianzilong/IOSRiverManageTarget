//
//  ZLNewAreaDetailModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/14.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ZLNewAreaDetailModel

@end
@interface ZLNewAreaDetailModel : JSONModel


@property (nonatomic, strong) NSString<Optional> *areaName;

@property (nonatomic, strong) NSString<Optional> *areaCode;


@end
