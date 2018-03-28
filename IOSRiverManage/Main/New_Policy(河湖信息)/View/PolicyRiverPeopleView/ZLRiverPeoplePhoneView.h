//
//  ZLRiverPeoplePhoneView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLRIverPeopleDataModel.h"
#import "ZLRiverPeopleLowerModel.h"
@interface ZLRiverPeoplePhoneView : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *nameLable;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) ZLRIverPeopleDataModel *dataModel;

@property (nonatomic, strong) ZLRiverPeopleLowerModel *lowerModel;

@end
