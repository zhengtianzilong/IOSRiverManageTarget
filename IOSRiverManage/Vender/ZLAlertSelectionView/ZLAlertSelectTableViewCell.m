//
//  ZLAlertSelectTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/22.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLAlertSelectTableViewCell.h"
@interface ZLAlertSelectTableViewCell()


@end
@implementation ZLAlertSelectTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self commonInit];
        
    }
    return self;
}

- (void)commonInit{
    [self.contentView addSubview:self.selectionButton];
    [self.contentView addSubview:self.descriptionLabel];
    
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.selectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-15);
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(24);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.equalTo(self.contentView);
    }];
}

- (UIButton *)selectionButton {
    if (!_selectionButton) {
        _selectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectionButton setImage:[UIImage imageNamed:@"yj_selected"] forState:UIControlStateSelected];
        [_selectionButton setImage:[UIImage imageNamed:@"yj_normal"] forState:UIControlStateNormal];
        _selectionButton.userInteractionEnabled = NO;
        
    }
    return _selectionButton;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        [_descriptionLabel setFont:[UIFont systemFontOfSize:14]];
        [_descriptionLabel setTextColor: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0]];

        
    }
    return _descriptionLabel;
}


@end
