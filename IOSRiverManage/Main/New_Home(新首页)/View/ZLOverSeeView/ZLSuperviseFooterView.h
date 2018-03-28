//
//  ZLSuperviseFooterView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSuperviseDetailDataModel.h"
@interface ZLSuperviseFooterView : UITableViewCell
// 交办工作内容
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UILabel *describe;

// 备注
@property (nonatomic, strong) UILabel *noteLabel;
@property (nonatomic, strong) UILabel *note;

@property (nonatomic, strong) ZLSuperviseDetailDataModel *detailModel;

@end
