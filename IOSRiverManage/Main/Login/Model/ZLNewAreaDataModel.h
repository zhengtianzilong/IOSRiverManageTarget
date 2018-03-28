//
//  ZLNewAreaDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/14.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ZLNewAreaDetailModel.h"

@protocol ZLNewAreaDataModel

@end

@interface ZLNewAreaDataModel : JSONModel

@property (nonatomic, strong) NSArray<Optional, ZLNewAreaDetailModel> *area;

@property (nonatomic, strong) NSString *areaCode;

@property (nonatomic, strong) NSString *areaName;

@end
