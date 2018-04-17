//
//  ZLReportDepartTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/17.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZLSelectInfo)(UITextView *infoTextView);
typedef void(^textViewGetText)(NSString *text, NSInteger tag);

@interface ZLReportDepartTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextView *infoTextView;

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) ZLSelectInfo selectInfo;

@property (nonatomic, strong) textViewGetText getText;
@end
