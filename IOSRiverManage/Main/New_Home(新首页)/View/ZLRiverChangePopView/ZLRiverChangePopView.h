//
//  ZLRiverChangePopView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/7.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLRiverChangeCollectionView.h"

@interface ZLRiverChangePopView : UIView

@property (nonatomic, strong) ZLRiverChangeCollectionView *collectionView;


- (void)dismissView;
@end
