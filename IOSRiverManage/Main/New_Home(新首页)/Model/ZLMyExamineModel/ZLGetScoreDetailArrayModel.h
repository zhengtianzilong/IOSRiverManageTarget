//
//  ZLGetScoreDetailArrayModel.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "ZLGetScoreDetailModel.h"

@protocol ZLGetScoreDetailArrayModel

@end

@interface ZLGetScoreDetailArrayModel : JSONModel
@property (nonatomic , copy) NSString<Optional>              *title;
@property (nonatomic, strong) NSArray<Optional, ZLGetScoreDetailModel> *list;

@end
