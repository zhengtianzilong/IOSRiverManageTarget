//
//  ZLBillboardInfoView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPublicityBrandModel.h"

typedef void(^deletePub)(ZLPublicityBrandModel *model);

@interface ZLBillboardInfoView : UITableViewCell

@property (nonatomic, strong) UILabel *title;

// 公示牌名
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *name;

// 位置
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *address;

// 公示牌照片
@property (nonatomic, strong) UILabel *pictureLabel;
@property (nonatomic, strong) UICollectionView *picture;

@property (nonatomic, weak) UIView *containerView;

// 所属区县
@property (nonatomic, strong) UILabel *countyLabel;
@property (nonatomic, strong) UILabel *county;

// 删除按钮
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *checkAddressBtn;

@property (nonatomic, strong) ZLPublicityBrandModel *publicBrandModel;

@property (nonatomic, strong) deletePub deletePublic;

@end
