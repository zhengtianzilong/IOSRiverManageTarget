//
//  ZLAssignTaskDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/21.
//  Copyright © 2018年 caizilong. All rights reserved.
//


#import <JSONModel/JSONModel.h>
#import "ZLAssignTaskRowDetailModel.h"
@interface ZLAssignTaskDataModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *total;

@property (nonatomic, strong) NSArray<Optional, ZLAssignTaskRowDetailModel> *rows;

@end
