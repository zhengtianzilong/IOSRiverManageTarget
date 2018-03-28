//
//  ZLRiverSelectView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/20.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLRiverDemandModel.h"
@interface ZLRiverSelectView : UIView

@property (nonatomic, strong) void(^selectedTitleBlock)(ZLRiverDemandModel *damandModel);

@property (nonatomic, strong) UIView *maskView;

// 判断是重点地图还是普通地图
@property (nonatomic, strong)NSString *importOrNormal;

/**
 河段资源
 */
@property (nonatomic, strong) NSMutableArray *riverSource;
- (instancetype)initWithFrame:(CGRect)frame titles:(NSMutableArray *)modelArray importOrNomal:(NSString *)importOrNomal;

@end
