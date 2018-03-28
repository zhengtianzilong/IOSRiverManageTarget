//
//  ZLHomeRiverRunningView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/7.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLNewUserRiversDataModel.h"
@interface ZLHomeRiverRunningView : UIView

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *peopleLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *stateLabel;

@property (nonatomic, strong) UILabel *checkLabel;

@property (nonatomic, strong) NSString *timeString;

@property (nonatomic, strong) ZLNewUserRiversDataModel *riverDataModel;

@end
