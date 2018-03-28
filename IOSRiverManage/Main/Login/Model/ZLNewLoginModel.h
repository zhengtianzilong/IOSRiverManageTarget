//
//  ZLNewLoginModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/14.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"
#import "ZLLoginDataModel.h"
@interface ZLNewLoginModel : ZLBaseModel
@property (nonatomic, strong) ZLLoginDataModel<Optional> *data;
@end
