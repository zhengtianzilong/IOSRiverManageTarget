//
//  ZLTaskDealDetailCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZLTaskRiverTaskDetailListModel.h"

typedef void(^detailBtnClick)(ZLTaskRiverTaskDetailListModel *model);
typedef void(^backBtnClick)(ZLTaskRiverTaskDetailListModel *model);
typedef void(^completeBtnClick)(ZLTaskRiverTaskDetailListModel *model);

@interface ZLTaskDealDetailCell : UITableViewCell
/**
 颜色指示器
 */
@property(nonatomic, strong) UIImageView *colorIndicator;

@property (nonatomic, strong) UILabel *peopleLabel;
@property (nonatomic, strong) UILabel *people;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *state;
//@property (nonatomic, strong) UILabel *feedLabel;
//@property (nonatomic, strong) UILabel *feed;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *time;

@property (nonatomic, strong) UIButton *detailBtn;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *completeBtn;


/**
 从不同控制器传入
 */
@property (nonatomic, strong) NSString *passCode;


@property (nonatomic, strong) detailBtnClick detailClick;

@property (nonatomic, strong) backBtnClick backClick;

@property (nonatomic, strong) completeBtnClick completeClick;

@property (nonatomic, strong) ZLTaskRiverTaskDetailListModel *dataModel;

@end
