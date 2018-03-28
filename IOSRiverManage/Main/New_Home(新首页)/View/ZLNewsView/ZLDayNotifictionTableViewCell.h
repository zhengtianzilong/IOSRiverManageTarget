//
//  ZLDayNotifictionTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLNewListDataModel.h"
@interface ZLDayNotifictionTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) ZLNewListDataModel *listDataModel;

@end
