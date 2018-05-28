//
//  ZLHaveNoExamineArrayModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseModel.h"
#import "ZLHaveNoExamineModel.h"
@interface ZLHaveNoExamineArrayModel : ZLBaseModel

@property (nonatomic, strong) NSArray<Optional,ZLHaveNoExamineModel > *data;

@end
