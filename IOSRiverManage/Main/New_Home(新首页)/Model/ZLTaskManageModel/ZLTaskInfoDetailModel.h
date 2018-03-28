//
//  ZLTaskInfoDetailModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"
#import "ZLTaskInfoDetailDataModel.h"
@interface ZLTaskInfoDetailModel : ZLBaseModel

@property (nonatomic, strong) ZLTaskInfoDetailDataModel<Optional> *data;

@end
