//
//  ZLAddressBookTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLAddressBookTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) UIButton *phoneBtn;

//- (void)configCellWithModel:(Student *)model;


@end
