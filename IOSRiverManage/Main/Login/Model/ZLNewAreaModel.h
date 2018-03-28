//
//  ZLNewAreaModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/14.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"
#import "ZLNewAreaDataModel.h"
@interface ZLNewAreaModel : ZLBaseModel

@property (nonatomic, strong) NSArray<ZLNewAreaDataModel,Optional> *data;

@end
