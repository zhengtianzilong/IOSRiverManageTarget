//
//  ZLRiverChangeCollectionView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/7.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLRiverChangeCollectionViewCell.h"
typedef void(^centerItemBlock)(ZLHomeCenterCollectionModel *model, NSIndexPath *indexpath);

@interface ZLRiverChangeCollectionView : UIView

@property (nonatomic, copy) centerItemBlock centerItemBlock;
@end
