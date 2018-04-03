//
//  ZLRiverRecordCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/26.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLRiverRecordDataModel.h"
@interface ZLRiverRecordCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *startLabel;

@property (nonatomic, strong) UILabel *startTime;

@property (nonatomic, strong) UILabel *endTimeLabel;

@property (nonatomic, strong) UILabel *endTime;

@property (nonatomic, strong) ZLRiverRecordDataModel *listDataModel;

@end
