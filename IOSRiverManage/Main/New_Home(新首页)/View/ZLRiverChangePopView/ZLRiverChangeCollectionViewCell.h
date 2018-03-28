//
//  ZLRiverChangeCollectionViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/8.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+JKImagePosition.h"
#import "ZLHomeCenterCollectionModel.h"
@interface ZLRiverChangeCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIButton *customBtn;

//@property (nonatomic, strong) UIButton *tipBtn;


@property (nonatomic, strong) ZLHomeCenterCollectionModel *model;
@end
