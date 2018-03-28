//
//  ZLTimeLineTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLTaskIncidentListModel.h"
@interface ZLTimeLineTableViewCell : UITableViewCell
/**
 颜色指示器
 */
@property(nonatomic, strong) UIImageView *colorIndicator;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *descripe;

@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, strong) ZLTaskIncidentListModel *dataModel;

@end
