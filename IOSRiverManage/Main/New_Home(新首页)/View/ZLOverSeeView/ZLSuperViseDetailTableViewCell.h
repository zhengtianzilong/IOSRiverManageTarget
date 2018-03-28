//
//  ZLSuperViseDetailTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLAssignTaskDetailDataModel.h"
@interface ZLSuperViseDetailTableViewCell : UITableViewCell
// 编号
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *count;
// 责任单位
@property (nonatomic, strong) UILabel *departmentLabel;
@property (nonatomic, strong) UILabel *department;

// 责任人
@property (nonatomic, strong) UILabel *peopleLabel;
@property (nonatomic, strong) UILabel *people;

// 交办时间
@property (nonatomic, strong) UILabel *assignedTimeLabel;
@property (nonatomic, strong) UILabel *assignedTime;

// 完成时间
@property (nonatomic, strong) UILabel *completeTimeLabel;
@property (nonatomic, strong) UILabel *completeTime;


@property (nonatomic, strong) ZLAssignTaskDetailDataModel *detailModel;

@end
