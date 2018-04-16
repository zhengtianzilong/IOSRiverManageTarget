//
//  ZLPolicyRiverInfoTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLPolicyRiverInfoTableViewCell.h"

@implementation ZLPolicyRiverInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.tipImageV];
    [self.contentView addSubview:self.riverLabel];
//    [self.contentView addSubview:self.riverLevelLabel];
    [self.contentView addSubview:self.completeImageV];
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
}

- (void)setDetailModel:(ZLNewUserRiversDataModel *)detailModel{
    
    _detailModel = detailModel;
    
    _titleLabel.text = _detailModel.riverName;
    
    if (_detailModel.riverGrade == nil) {
        _detailModel.riverGrade = @"";
    }
    
    _riverLabel.text = _detailModel.riverGrade;
    
    
    NSString *levelImage = @"";
    if (_detailModel.nowadaysQuality != nil) {
        
        if ([_detailModel.nowadaysQuality isEqualToString:@"Ⅰ"]) {
            
            levelImage = @"home_level1";
            
        }
        
        if ([_detailModel.nowadaysQuality isEqualToString:@"Ⅱ"]) {
            
            levelImage = @"home_level2";
            
        }
        
        if ([_detailModel.nowadaysQuality isEqualToString:@"Ⅲ"]) {
            
            levelImage = @"home_level3";
            
        }
        if ([_detailModel.nowadaysQuality isEqualToString:@"Ⅳ"]) {
            
            levelImage = @"home_level4";
            
        }
        
        if ([_detailModel.nowadaysQuality isEqualToString:@"Ⅴ"]) {
            
            levelImage = @"home_level5";
            
        }
        if ([_detailModel.nowadaysQuality isEqualToString:@"VI"]) {
            
            levelImage = @"home_level1";
            
        }
         _tipImageV.image = [UIImage imageNamed:levelImage];
    }
    
    
   
    
    
    if ([_detailModel.isStandard isEqualToString:@"1"]) {
        
        _completeImageV.image = [UIImage imageNamed:@"home_complete"];
        
    }else{
         _completeImageV.image = [UIImage imageNamed:@"home_uncomplete"];
    }
    
}



- (void)layoutSubviews{
    [super layoutSubviews];

    [self.tipImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10);
//        make.top.equalTo(self.titleLabel);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(20);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.completeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.tipImageV.mas_left).offset(-10);
        make.centerY.equalTo(self.contentView);
//        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(50);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(5);
        make.height.mas_equalTo(20);
        
        
        //        make.width.mas_equalTo(100);
        
    }];
    
    [self.riverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        //        make.width.mas_equalTo(50);
        
    }];
    
//    [self.riverLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.riverLabel.mas_right).offset(10);
//        make.top.equalTo(self.riverLabel);
//        make.height.mas_equalTo(20);
//        //        make.width.mas_equalTo(50);
//
//    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"秦淮河";
        _titleLabel.font = CHINESE_SYSTEM(15);
    }
    return _titleLabel;
}

- (UIImageView *)tipImageV{
    if (!_tipImageV) {
        _tipImageV = [[UIImageView alloc]init];
    }
    return _tipImageV;
}

- (UIImageView *)completeImageV{
    if (!_completeImageV) {
        _completeImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_uncomplete"]];
    }
    return _completeImageV;
}


- (UILabel *)riverLabel{
    if (!_riverLabel) {
        _riverLabel = [[UILabel alloc]init];
        _riverLabel.text = @"玄武区";
        _riverLabel.font = CHINESE_SYSTEM(14);
        _riverLabel.textColor = [UIColor lightGrayColor];
    }
    return _riverLabel;
}
//- (UILabel *)riverLevelLabel{
//    if (!_riverLevelLabel) {
//        _riverLevelLabel = [[UILabel alloc]init];
//        _riverLevelLabel.text = @"区级河道";
//        _riverLevelLabel.font = CHINESE_SYSTEM(14);
//        _riverLevelLabel.textColor = [UIColor lightGrayColor];
//    }
//    return _riverLevelLabel;
//}




@end
