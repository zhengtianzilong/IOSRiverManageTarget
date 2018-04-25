//
//  ZLRiverInfoBaseView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/1/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverInfoBaseView.h"
@interface ZLRiverInfoBaseView ()

@end

@implementation ZLRiverInfoBaseView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.riverCountLabel];
        [self.contentView addSubview:self.riverCount];
        [self.contentView addSubview:self.riverStartLabel];
        [self.contentView addSubview:self.riverStart];
        [self.contentView addSubview:self.riverEndLabel];
        [self.contentView addSubview:self.riverEnd];
        [self.contentView addSubview:self.riverDutyLabel];
        [self.contentView addSubview:self.riverDuty];
        [self.contentView addSubview:self.riverTargetLabel];
        [self.contentView addSubview:self.riverTarget];
        [self.contentView addSubview:self.riverCountyLabel];
        [self.contentView addSubview:self.riverCounty];
        [self.contentView addSubview:self.riverLevelLabel];
        [self.contentView addSubview:self.riverLevel];
        [self.contentView addSubview:self.riverLengthLabel];
        [self.contentView addSubview:self.riverLength];
        [self.contentView addSubview:self.checkAddressBtn];
        [self.contentView addSubview:self.editBtn];
        
        
        [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(self.contentView).offset(10);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(20);
        }];
        
        [self.riverCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(10);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        
        [self.riverCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.riverCountLabel.mas_right).offset(10);
            make.top.equalTo(self.riverCountLabel);
            make.right.equalTo(self.editBtn.mas_right);
            make.height.mas_equalTo(20);
        }];
        
        [self.riverCountyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.riverCountLabel);
            make.top.equalTo(self.riverCountLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        [self.riverCounty mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.riverCountyLabel.mas_right).offset(10);
            make.top.equalTo(self.riverCountyLabel);
            make.right.equalTo(self.editBtn.mas_right);
            make.height.mas_equalTo(20);
            
        }];
        
        [self.riverLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.riverCountLabel);
            make.top.equalTo(self.riverCountyLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        [self.riverLevel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.riverLevelLabel.mas_right).offset(10);
            make.top.equalTo(self.riverLevelLabel);
            make.height.mas_equalTo(20);
            make.right.equalTo(self.editBtn.mas_left);
            
        }];
        
        [self.riverLengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.riverCountLabel);
            make.top.equalTo(self.riverLevelLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        [self.riverLength mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.riverLengthLabel.mas_right).offset(10);
            make.top.equalTo(self.riverLengthLabel);
            make.height.mas_equalTo(20);
            make.right.equalTo(self.editBtn.mas_left);
            
        }];
        
        
        [self.riverStartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.riverCountLabel);
            make.top.equalTo(self.riverLengthLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        
        [self.riverStart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.riverStartLabel.mas_right).offset(10);
            make.top.equalTo(self.riverStartLabel);
            make.right.equalTo(self.editBtn.mas_left);
            make.height.mas_equalTo(20);
        }];
        
        [self.riverEndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.riverCountLabel);
            make.top.equalTo(self.riverStartLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        
        [self.riverEnd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.riverEndLabel.mas_right).offset(10);
            make.top.equalTo(self.riverEndLabel);
            make.right.equalTo(self.editBtn.mas_left);
            make.height.mas_equalTo(20);
        }];
        
        [self.riverDutyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.riverCountLabel);
            make.top.equalTo(self.riverEndLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        
        [self.riverDuty mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.riverDutyLabel.mas_right).offset(10);
            make.top.equalTo(self.riverDutyLabel).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.height.mas_greaterThanOrEqualTo(20);
        }];
        
        [self.riverTargetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.riverCountLabel);
            make.top.greaterThanOrEqualTo(self.riverDuty.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        
        [self.riverTarget mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.riverTargetLabel.mas_right).offset(10);
            make.top.equalTo(self.riverTargetLabel);
            make.right.equalTo(self.editBtn.mas_left);
            
            make.height.mas_greaterThanOrEqualTo(20);
        }];
        
        [self.checkAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.riverTarget.mas_bottom);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(160);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        
        
        
        
    }
    
    return self;
}

- (void)setInfoBaseModel:(ZLRiverInfoBaseModel *)infoBaseModel{
    
    _infoBaseModel = infoBaseModel;
    
    _riverCount.text = _infoBaseModel.RIVER_CODE;
    
    _riverCounty.text = _infoBaseModel.AREA_NAME;
    
    _riverLevel.text = _infoBaseModel.RIVER_GRADE;
    
    
    if (_infoBaseModel.RIVER_LENGTH == nil) {
        
        _infoBaseModel.RIVER_LENGTH = @"";
        
    }
    
    _riverLength.text =  [NSString stringWithFormat:@"%@(千米)",_infoBaseModel.RIVER_LENGTH];
    
    _riverStart.text = _infoBaseModel.START_DESC;
    
    _riverEnd.text = _infoBaseModel.END_DESC;
    
    _riverDuty.text = _infoBaseModel.DUTY;
    
    _riverTarget.text = _infoBaseModel.TARGET;
}



- (void)checkAddressBtnClick{
    
    if (_infoBaseView) {
        
        self.infoBaseView(self.infoBaseModel);
        
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    [_riverCountLabel changeAlignmentRightandLeft];
//    [_riverCountyLabel changeAlignmentRightandLeft];
//    [_riverLevelLabel changeAlignmentRightandLeft];
//    [_riverLengthLabel changeAlignmentRightandLeft];
//    [_riverStartLabel changeAlignmentRightandLeft];
//    [_riverEndLabel changeAlignmentRightandLeft];
//    [_riverDutyLabel changeAlignmentRightandLeft];
//    [_riverTargetLabel changeAlignmentRightandLeft];
    
}
- (UILabel *)riverCountLabel{
    if (!_riverCountLabel) {
        _riverCountLabel = [[UILabel alloc]init];
        _riverCountLabel.text = @"河道编号";
        _riverCountLabel.font = Font(12);
    }
    return _riverCountLabel;
}

- (UILabel *)riverCount{
    if (!_riverCount) {
        _riverCount = [[UILabel alloc]init];
        _riverCount.font = CHINESE_SYSTEM(12);
        _riverCount.text = @"111111";
    }
    return _riverCount;
}

- (UILabel *)riverStartLabel{
    if (!_riverStartLabel) {
        _riverStartLabel = [[UILabel alloc]init];
        _riverStartLabel.text = @"河道起点";
        _riverStartLabel.font = Font(12);
    }
    return _riverStartLabel;
}

- (UILabel *)riverStart{
    if (!_riverStart) {
        _riverStart = [[UILabel alloc]init];
        _riverStart.font = CHINESE_SYSTEM(12);
        _riverStart.text = @"111111";
    }
    return _riverStart;
}

- (UILabel *)riverEndLabel{
    if (!_riverEndLabel) {
        _riverEndLabel = [[UILabel alloc]init];
        _riverEndLabel.text = @"河道终点";
        _riverEndLabel.font = Font(12);
    }
    return _riverEndLabel;
}

- (UILabel *)riverEnd{
    if (!_riverEnd) {
        _riverEnd = [[UILabel alloc]init];
        _riverEnd.font = CHINESE_SYSTEM(12);
        _riverEnd.text = @"111111";
    }
    return _riverEnd;
}

- (UILabel *)riverDutyLabel{
    if (!_riverDutyLabel) {
        _riverDutyLabel = [[UILabel alloc]init];
        _riverDutyLabel.text = @"河长职责";
        _riverDutyLabel.font = Font(12);
    }
    return _riverDutyLabel;
}

- (UILabel *)riverDuty{
    if (!_riverDuty) {
        _riverDuty = [[UILabel alloc]init];
        _riverDuty.font = CHINESE_SYSTEM(12);
        _riverDuty.numberOfLines = 0;
        _riverDuty.text = @"整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标整治目标";
        
    }
    return _riverDuty;
}

- (UILabel *)riverTargetLabel{
    if (!_riverTargetLabel) {
        _riverTargetLabel = [[UILabel alloc]init];
        _riverTargetLabel.text = @"治理目标";
        _riverTargetLabel.font = Font(12);
    }
    return _riverTargetLabel;
}

- (UILabel *)riverTarget{
    if (!_riverTarget) {
        _riverTarget = [[UILabel alloc]init];
        _riverTarget.font = CHINESE_SYSTEM(12);
        _riverTarget.text = @"111111";
        _riverTarget.numberOfLines = 0;
    }
    return _riverTarget;
}

- (UILabel *)riverCountyLabel{
    if (!_riverCountyLabel) {
        _riverCountyLabel = [[UILabel alloc]init];
        _riverCountyLabel.text = @"所属区县";
        _riverCountyLabel.font = Font(12);
    }
    return _riverCountyLabel;
}

- (UILabel *)riverCounty{
    if (!_riverCounty) {
        _riverCounty = [[UILabel alloc]init];
        _riverCounty.font = CHINESE_SYSTEM(12);
        _riverCounty.text = @"111111";
    }
    return _riverCounty;
}

- (UILabel *)riverLevelLabel{
    if (!_riverLevelLabel) {
        _riverLevelLabel = [[UILabel alloc]init];
        _riverLevelLabel.text = @"所属级别";
        _riverLevelLabel.font = Font(12);
    }
    return _riverLevelLabel;
}

- (UILabel *)riverLevel{
    if (!_riverLevel) {
        _riverLevel = [[UILabel alloc]init];
        _riverLevel.font = CHINESE_SYSTEM(12);
        _riverLevel.text = @"111111";
    }
    return _riverLevel;
}

- (UILabel *)riverLengthLabel{
    if (!_riverLengthLabel) {
        _riverLengthLabel = [[UILabel alloc]init];
        _riverLengthLabel.text = @"河道长度";
        _riverLengthLabel.font = Font(12);
    }
    return _riverLengthLabel;
}

- (UILabel *)riverLength{
    if (!_riverLength) {
        _riverLength = [[UILabel alloc]init];
        _riverLength.font = CHINESE_SYSTEM(12);
        _riverLength.text = @"111111";
    }
    return _riverLength;
}

- (UIButton *)checkAddressBtn{
    if (!_checkAddressBtn) {
        _checkAddressBtn = [[UIButton alloc]init];
        [_checkAddressBtn setTitle:@"查看河道方位" forState:(UIControlStateNormal)];
        [_checkAddressBtn setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
        _checkAddressBtn.titleLabel.font = Font(12);
        [_checkAddressBtn setImage:[UIImage imageNamed:@"info_positioning"] forState:(UIControlStateNormal)];
        
        [_checkAddressBtn setImagePosition:(LXMImagePositionLeft) spacing:10];
        [_checkAddressBtn addTarget:self action:@selector(checkAddressBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _checkAddressBtn;
}

- (UIButton *)editBtn{
    if (!_editBtn) {
        _editBtn = [[UIButton alloc]init];
        [_editBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
    }
    return _editBtn;
}

@end
