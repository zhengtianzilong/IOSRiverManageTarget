//
//  ZLScoreTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLGetScoreDetailModel.h"
#import "ZLPlaceholderTextView.h"
typedef void(^scroeInputBlock)(NSString *text);


@interface ZLScoreTableViewCell : UITableViewCell


//@property (nonatomic, strong) UIImageView *tipsImageV;
//
//@property (nonatomic, strong) UILabel *numberLabel;


@property (nonatomic, strong) UILabel *title;
/**
 描述
 */
@property (nonatomic, strong) UILabel *descriptionLabel;


/**
 分数
 */
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *score;

/**
 自评总分
 */
@property (nonatomic, strong) UILabel *totalScoreLabel;
@property (nonatomic, strong) ZLPlaceholderTextView *totalScoreTextField;

@property (nonatomic, strong) scroeInputBlock scroeInputBlock;

@property (nonatomic, strong) ZLGetScoreDetailModel *detailModel;


// 根据状态来判断保存还是没保存
@property (nonatomic, strong) NSString *status;



@end
