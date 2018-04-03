//
//  ZLRiverRecordPointDetailCollectionViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/20.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLGaodeEventAndTaskModel.h"
@interface ZLRiverRecordPointDetailCollectionViewCell : UICollectionViewCell
/**
 发起人
 */
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UILabel *contentLabel;
/**
 内容
 */
@property (nonatomic, strong) UILabel *content;

/**
 巡河人
 */
@property (nonatomic, strong) UILabel *riverPeopleLabel;
@property (nonatomic, strong) UILabel *riverPeople;


/**
 时间
 */
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *time;


@property (nonatomic, strong) ZLGaodeEventAndTaskModel *dataModel;

@end
