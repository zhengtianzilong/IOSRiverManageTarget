//
//  ZLRiverInfoBaseChangeTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/8.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^textViewGetText)(NSString *text, NSInteger tag);

@interface ZLRiverInfoBaseChangeTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextView *infoTextView;

@property (nonatomic, strong) textViewGetText getText;

@end
