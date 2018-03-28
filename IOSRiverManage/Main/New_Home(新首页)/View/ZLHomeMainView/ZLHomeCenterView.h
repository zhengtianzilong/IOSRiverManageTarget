//
//  ZLHomeCenterView.h
//  HongZeHaiShi
//
//  Created by 蔡紫龙 on 2018/1/17.
//  Copyright © 2018年 xgzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLHomeCenterCollectionViewCell.h"

typedef void(^centerItemBlock)(ZLHomeCenterCollectionModel *model, NSIndexPath *indexpath);

@interface ZLHomeCenterView : UIView

@property (nonatomic, copy) centerItemBlock centerItemBlock;

@end
