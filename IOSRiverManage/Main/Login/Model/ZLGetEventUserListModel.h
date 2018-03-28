//
//  ZLGetEventUserListModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"
#import "ZLGetEventUserListDataModel.h"
@interface ZLGetEventUserListModel : ZLBaseModel
@property (nonatomic, strong) NSArray<Optional,ZLGetEventUserListDataModel> *data;
@end
