//
//  ZLGetScoreModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//


#import <JSONModel/JSONModel.h>

#import "ZLGetScoreDetailArrayModel.h"

@interface ZLGetScoreRowModel : JSONModel

@property (nonatomic , copy) NSString<Optional>   *total;
@property (nonatomic, strong) NSArray<Optional, ZLGetScoreDetailArrayModel> *rows;


@end
