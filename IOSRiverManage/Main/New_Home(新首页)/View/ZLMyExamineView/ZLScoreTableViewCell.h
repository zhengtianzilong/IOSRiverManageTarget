//
//  ZLScoreTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^scroeInputBlock)(NSString *text);


@interface ZLScoreTableViewCell : UITableViewCell


@property (nonatomic, strong) UIImageView *tipsImageV;

@property (nonatomic, strong) UILabel *numberLabel;


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
@property (nonatomic, strong) UITextField *totalScoreTextField;

@property (nonatomic, strong) scroeInputBlock scroeInputBlock;



@end
