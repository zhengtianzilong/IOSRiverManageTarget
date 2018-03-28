//
//  ZLPolicyRiverFiveTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPolicyFiveModel.h"
@interface ZLPolicyRiverFiveTableViewCell : UITableViewCell
// 标题
@property (nonatomic, strong) UILabel *titleLabel;
// 图片
@property (nonatomic, strong) UIImageView *tipImageV;

@property (nonatomic, strong) ZLPolicyFiveModel *fiveModel;

@end
