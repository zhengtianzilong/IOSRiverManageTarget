//
//  ZLHaveExamineArrayModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"
#import "ZLHaveExamineModel.h"
@interface ZLHaveExamineArrayModel : ZLBaseModel
@property (nonatomic, strong) NSArray<Optional,ZLHaveExamineModel > *data;
@end
