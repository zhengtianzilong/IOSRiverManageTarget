//
//  ZLNewListModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/15.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"
#import "ZLNewListDataModel.h"
@interface ZLNewListModel : ZLBaseModel
@property (nonatomic, strong) NSArray<ZLNewListDataModel, Optional> *data;
@end
