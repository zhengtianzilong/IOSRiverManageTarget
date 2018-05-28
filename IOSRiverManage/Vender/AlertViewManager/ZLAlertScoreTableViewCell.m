//
//  ZLAlertScoreTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLAlertScoreTableViewCell.h"

@implementation ZLAlertScoreTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.tipsLabel];
        [self.contentView addSubview:self.contentLabel];
        
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.top.equalTo(self.contentView.mas_top);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
            make.bottom.equalTo(self.contentView.mas_bottom);
            
            
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.tipsLabel.mas_right).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.height.mas_equalTo(20);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
            
        }];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    

}


- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        
        _contentLabel.text = @"5分";
        _contentLabel.font = CHINESE_SYSTEM(13);
    }
    return _contentLabel;
}

- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        
        _tipsLabel.text = @"指标分值：";
        _tipsLabel.font = CHINESE_SYSTEM(13);
    }
    return _tipsLabel;
}





@end
