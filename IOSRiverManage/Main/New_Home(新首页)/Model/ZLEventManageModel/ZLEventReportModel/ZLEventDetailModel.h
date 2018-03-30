//
//  ZLEventDetailModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/30.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"
#import "ZLEventDetailDataModel.h"
@interface ZLEventDetailModel : ZLBaseModel
@property (nonatomic, strong) ZLEventDetailDataModel<Optional> *data;
@end
