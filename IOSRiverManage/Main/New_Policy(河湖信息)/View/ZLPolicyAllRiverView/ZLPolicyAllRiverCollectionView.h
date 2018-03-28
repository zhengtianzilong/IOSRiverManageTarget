//
//  ZLPolicyAllRiverCollectionView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^centerItemBlock)(NSString *title, NSIndexPath *indexpath);
@interface ZLPolicyAllRiverCollectionView : UIView
@property (nonatomic, copy) centerItemBlock centerItemBlock;
@end
