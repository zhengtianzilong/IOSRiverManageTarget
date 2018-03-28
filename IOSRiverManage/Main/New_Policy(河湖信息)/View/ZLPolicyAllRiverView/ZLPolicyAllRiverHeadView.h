//
//  ZLPolicyAllRiverHeadView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/5.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSearchBar.h"
#import "ZLPolicyAllRiverCollectionView.h"

@interface ZLPolicyAllRiverHeadView : UIView

@property (nonatomic, strong) ZLSearchBar *searchBar;

@property (nonatomic, strong) ZLPolicyAllRiverCollectionView *mainCollectionView;


@end
