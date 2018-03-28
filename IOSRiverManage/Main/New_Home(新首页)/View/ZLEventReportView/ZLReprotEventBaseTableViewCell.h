//
//  ZLReprotEventBaseTableViewCell.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/17.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import <YYText/YYText.h>
typedef void(^textViewGetText)(NSString *text, NSInteger tag);
@interface ZLReprotEventBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextView *infoTextView;


@property (nonatomic, strong) textViewGetText getText;

@end
