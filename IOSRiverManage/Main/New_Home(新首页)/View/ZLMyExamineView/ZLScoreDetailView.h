//
//  ZLScoreDetailView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZLHaveNoExamineModel.h"

@interface ZLScoreDetailView : UIView

@property (nonatomic, strong) ZLHaveNoExamineModel *noModel;

@property (nonatomic, strong) NSMutableArray *sourceArray;
- (instancetype)initWithModel:(ZLHaveNoExamineModel *)noModel;
@end
