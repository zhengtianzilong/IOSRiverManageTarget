//
//  ZLGaodeDetailView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/26.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+ZLLeftAndRight.h"
@interface ZLGaodeDetailView : UIView
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UILabel *riverLabel;

@property (nonatomic, strong) UILabel *riverPeople;

@property (nonatomic, strong) UILabel *reportObjectLabel;

@property (nonatomic, strong) UILabel *reportObject;

@property (nonatomic, strong) UILabel *reportTimeLabel;

@property (nonatomic, strong) UILabel *reportTime;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UILabel *address;

@property (nonatomic, strong) UILabel *feedBackLabel;

@property (nonatomic, strong) UILabel *feedBack;

@property (nonatomic, strong) UICollectionView *mainCollectionView;

@property (nonatomic, weak) UIView *containerView;
@end
