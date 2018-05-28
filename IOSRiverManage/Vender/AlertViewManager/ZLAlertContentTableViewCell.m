//
//  ZLAlertContentTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLAlertContentTableViewCell.h"
@implementation ZLAlertContentTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.contentLabel];
        
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.top.equalTo(self.contentView.mas_top);
            
            make.bottom.equalTo(self.contentView.mas_bottom);
            
        }];
        
    }
    return self;
}



- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = CHINESE_SYSTEM(13);
        _contentLabel.text = @"Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.2018-05-28 08:56:33.518462+0800 IOSRiverManageWan[21397:8945215] [BoringSSL] Function boringssl_session_err";
        
        
    }
    return _contentLabel;
}



@end
