//
//  ZLHomeWaitEventAndTaskModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/30.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"
#import "ZLHomeWaitEventAndTaskDataModel.h"
@interface ZLHomeWaitEventAndTaskModel : ZLBaseModel

@property (nonatomic, strong) NSArray<Optional, ZLHomeWaitEventAndTaskDataModel> *data;

@end
