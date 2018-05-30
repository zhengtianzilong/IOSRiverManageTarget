//
//  ZLScoreDetailVC.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBaseCustomNoNetworkVC.h"
#import "ZLHaveNoExamineModel.h"
@interface ZLScoreDetailVC : ZLBaseCustomNoNetworkVC

@property (nonatomic, strong) ZLHaveNoExamineModel *noModel;

@property (nonatomic, assign) Boolean isShowBottomView;


@end
