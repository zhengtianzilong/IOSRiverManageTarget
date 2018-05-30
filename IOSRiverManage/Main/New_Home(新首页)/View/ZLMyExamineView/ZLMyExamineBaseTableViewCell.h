//
//  ZLMyExamineBaseTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/15.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLHaveNoExamineModel.h"
#import "ZLHaveExamineModel.h"
typedef void(^zlScoreClick)(void);
typedef void(^zlScoreCommitClick)(ZLHaveNoExamineModel *model);
@interface ZLMyExamineBaseTableViewCell : UITableViewCell
/**
 颜色指示器
 */
@property(nonatomic, strong) UIImageView *colorIndicator;

@property (nonatomic, strong) UILabel *title;
//@property (nonatomic, strong) UILabel *state;

//@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *initiatorLabel;
/**
 开始时间
 */
@property (nonatomic, strong) UILabel *startTimeLable;
@property (nonatomic, strong) UILabel *startTime;
/**
 结束时间
 */
@property (nonatomic, strong) UILabel *endTimeLable;
@property (nonatomic, strong) UILabel *endTime;
/**
 分数
 */
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *score;

/**
 自评总分
 */
@property (nonatomic, strong) UILabel *totalScoreLabel;
@property (nonatomic, strong) UILabel *totalScore;


/**
 时间
 */
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *lineViewTop;

@property (nonatomic, strong) UIView *lineViewBottom;

@property (nonatomic, strong) UIButton *scoreBtn;
@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) zlScoreClick scoreClick;
@property (nonatomic, strong) zlScoreCommitClick commitClick;

@property (nonatomic, strong) ZLHaveNoExamineModel *noExamineModel;

@property (nonatomic, strong) ZLHaveExamineModel *examineModel;

@end
