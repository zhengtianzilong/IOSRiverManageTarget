//
//  ZLPolicyRiverInfoTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZLNewUserRiversDataModel.h"

@interface ZLPolicyRiverInfoTableViewCell : UITableViewCell
// 标题
@property (nonatomic, strong) UILabel *titleLabel;
// 等级
@property (nonatomic, strong) UIImageView *tipImageV;
// 达标
@property (nonatomic, strong) UIImageView *completeImageV;

// 区
@property (nonatomic, strong) UILabel *riverLabel;

// 河道等级
//@property (nonatomic, strong) UILabel *riverLevelLabel;

@property (nonatomic, strong) ZLNewUserRiversDataModel *detailModel;



@end
