//
//  ZLSuperviseDataModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ZLSuperviseRowDetailModel.h"
@interface ZLSuperviseDataModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *total;

@property (nonatomic, strong) NSArray<Optional, ZLSuperviseRowDetailModel> *rows;

@end
