//
//  ZLPolicyALlRiverCollectionViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPolicyAllRiverAreaModel.h"
@interface ZLPolicyALlRiverCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIButton *titleButton;

/*  *< 是否被选中 >*  */
//@property (assign,nonatomic,getter=isBeSelected) BOOL beSelected;

@property (nonatomic, strong) ZLPolicyAllRiverAreaModel *areaModel;


@end
