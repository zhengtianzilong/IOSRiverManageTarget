//
//  ZLPolicyRiverFiveTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLPolicyRiverFiveTableViewCell.h"

@implementation ZLPolicyRiverFiveTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.tipImageV];
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
}

- (void)setFiveModel:(ZLPolicyFiveModel *)fiveModel{
    _fiveModel = fiveModel;
    
    self.tipImageV.image = [UIImage imageNamed:fiveModel.imageName];
    
    self.titleLabel.text = fiveModel.title;
    
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self.tipImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        //        make.top.equalTo(self.titleLabel);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
        make.centerY.equalTo(self.contentView);
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.tipImageV.mas_right).offset(10);
//        make.top.equalTo(self.contentView).offset(5);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
         make.centerY.equalTo(self.contentView);
        //        make.width.mas_equalTo(100);
        
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"问题清单";
        _titleLabel.font = CHINESE_SYSTEM(15);
    }
    return _titleLabel;
}

- (UIImageView *)tipImageV{
    if (!_tipImageV) {
        _tipImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_level4"]];
    }
    return _tipImageV;
}






@end
