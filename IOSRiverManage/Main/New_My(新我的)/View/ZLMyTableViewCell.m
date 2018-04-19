//
//  ZLMyTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyTableViewCell.h"

@implementation ZLMyTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.icon];
        
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
//        make.width.height.mas_equalTo(AdaptedWidth(50));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(self.icon);
        
    }];
}

- (UIImageView *)icon{
    if (!_icon) {
        _icon=[[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _icon;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    }
    return _contentLabel;
}

@end
