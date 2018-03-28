//
//  ZLSuperviseHeadView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSuperviseDetailDataModel.h"
@interface ZLSuperviseHeadView : UITableViewCell
// 标题
@property (nonatomic, strong) UILabel *titleLabel;
// 状态:
@property (nonatomic, strong) UILabel *stateLable;
@property (nonatomic, strong) UILabel *state;
// 编号
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *count;
// 督办单位
@property (nonatomic, strong) UILabel *supDepartmentLabel;
@property (nonatomic, strong) UILabel *supDepartment;


// 督办时间
@property (nonatomic, strong) UILabel *supTimeLabel;
@property (nonatomic, strong) UILabel *supTime;

// 交办单
@property (nonatomic, strong) UILabel *assignedLabel;

@property (nonatomic, strong) ZLSuperviseDetailDataModel *detailModel;

@end
