//
//  ZLRiverOutletInfoTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverOutletInfoTableViewCell.h"
@interface ZLRiverOutletInfoTableViewCell ()
@end
@implementation ZLRiverOutletInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.code];
        [self.contentView addSubview:self.codeLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.address];
        [self.contentView addSubview:self.peopleLabel];
        [self.contentView addSubview:self.people];
        [self.contentView addSubview:self.countyLabel];
        [self.contentView addSubview:self.county];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.checkAddressBtn];
        [self.contentView addSubview:self.deleteBtn];
        [self.contentView addSubview:self.phoneLabel];
        [self.contentView addSubview:self.phone];
        [self.contentView addSubview:self.pollutantsLabel];
        [self.contentView addSubview:self.pollutants];
        
        
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(self.contentView).offset(10);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(20);
        }];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(10);
            make.height.mas_equalTo(20);
            
            
        }];
        
        [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title);
            make.top.equalTo(self.title.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        
        [self.code mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.codeLabel.mas_right).offset(5);
            make.top.equalTo(self.codeLabel);
            make.right.equalTo(self.deleteBtn.mas_left);
            make.height.mas_equalTo(20);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title);
            make.top.equalTo(self.codeLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).offset(5);
            make.top.equalTo(self.nameLabel);
            make.right.equalTo(self.deleteBtn.mas_left);
            make.height.mas_equalTo(20);
        }];
        
        [self.countyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        
        [self.county mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.countyLabel.mas_right).offset(5);
            make.top.equalTo(self.countyLabel);
            make.height.mas_equalTo(20);
            make.right.equalTo(self.deleteBtn.mas_left);
        }];
        
        
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.countyLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        
        [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.addressLabel.mas_right).offset(5);
            make.top.equalTo(self.addressLabel);
            make.right.equalTo(self.deleteBtn.mas_left);
            make.height.mas_greaterThanOrEqualTo(20);
        }];
        
        [self.peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.greaterThanOrEqualTo(self.address.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        
        [self.people mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.peopleLabel.mas_right).offset(5);
            make.top.equalTo(self.peopleLabel);
            make.right.equalTo(self.deleteBtn.mas_left);
            make.height.mas_equalTo(20);
        }];
        
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.peopleLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        
        [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.phoneLabel.mas_right).offset(5);
            make.top.equalTo(self.phoneLabel);
            make.right.equalTo(self.deleteBtn.mas_left);
            make.height.mas_equalTo(20);
        }];
        
        [self.pollutantsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.phoneLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        
        [self.pollutants mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.pollutantsLabel.mas_right).offset(5);
            make.top.equalTo(self.pollutantsLabel);
            make.right.equalTo(self.deleteBtn.mas_left);
                        make.height.mas_greaterThanOrEqualTo(20);
        }];
        
        
        [self.checkAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.pollutants.mas_bottom);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(150);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        
        
        
    }
    return self;
    
    
}

- (void)setOutletModel:(ZLSewageOutletModel *)outletModel{
    
    _outletModel = outletModel;
    
    _code.text = _outletModel.CODE;
    _name.text = _outletModel.NAME;
    _county.text = _outletModel.AREA_NAME;
    _address.text = _outletModel.ADDRESS;
    
    _people.text = _outletModel.CONTACT_PERSON;
    
    _phone.text = _outletModel.PHONE;
    
    _pollutants.text = _outletModel.CONTANT;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //    [_nameLabel changeAlignmentRightandLeft];
    //    [_countyLabel changeAlignmentRightandLeft];
    //    [_pictureLabel changeAlignmentRightandLeft];
    //    [_addressLabel changeAlignmentRightandLeft];
}


- (void)deleteClick{
    
    if (_outletDelete) {
        self.outletDelete(self.outletModel);
    }
    
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.text = @"排污口信息";
        _title.textColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
        _title.font = SYSTEMFONT(18);
    }
    return _title;
}

- (UILabel *)codeLabel{
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc]init];
        _codeLabel.text = @"取水口编码";
        _codeLabel.font = SYSTEMFONT(14);
    }
    return _codeLabel;
}

- (UILabel *)code{
    if (!_code) {
        _code = [[UILabel alloc]init];
        _code.font = SYSTEMFONT(14);
        _code.text = @"111111";
    }
    return _code;
}


- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"排污口名称";
        _nameLabel.font = SYSTEMFONT(14);
    }
    return _nameLabel;
}

- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.font = SYSTEMFONT(14);
        _name.text = @"111111";
    }
    return _name;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.text = @"位置";
        
        _addressLabel.font = SYSTEMFONT(14);
    }
    return _addressLabel;
}

- (UILabel *)address{
    if (!_address) {
        _address = [[UILabel alloc]init];
        _address.font = SYSTEMFONT(14);
        _address.text = @"111111";
        _address.numberOfLines = 0;
    }
    return _address;
}



- (UILabel *)peopleLabel{
    if (!_peopleLabel) {
        _peopleLabel = [[UILabel alloc]init];
        _peopleLabel.text = @"联系人";
        _peopleLabel.font = SYSTEMFONT(14);
    }
    return _peopleLabel;
}
- (UILabel *)people{
    if (!_people) {
        _people = [[UILabel alloc]init];
        _people.text = @"ssdadds";
        _people.font = SYSTEMFONT(14);
    }
    return _people;
}

- (UILabel *)countyLabel{
    if (!_countyLabel) {
        _countyLabel = [[UILabel alloc]init];
        _countyLabel.font = SYSTEMFONT(14);
        _countyLabel.text = @"所属区县";
    }
    return _countyLabel;
}


- (UILabel *)county{
    if (!_county) {
        _county = [[UILabel alloc]init];
        _county.font = SYSTEMFONT(14);
        _county.text = @"111111";
    }
    return _county;
}

- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = SYSTEMFONT(14);
        _phoneLabel.text = @"联系电话";
    }
    return _phoneLabel;
}


- (UILabel *)phone{
    if (!_phone) {
        _phone = [[UILabel alloc]init];
        _phone.font = SYSTEMFONT(14);
        _phone.text = @"111111sss";
    }
    return _phone;
}

- (UILabel *)pollutantsLabel{
    if (!_pollutantsLabel) {
        _pollutantsLabel = [[UILabel alloc]init];
        _pollutantsLabel.font = SYSTEMFONT(14);
        _pollutantsLabel.text = @"主要污染物";
    }
    return _pollutantsLabel;
}


- (UILabel *)pollutants{
    if (!_pollutants) {
        _pollutants = [[UILabel alloc]init];
        _pollutants.font = SYSTEMFONT(14);
        _pollutants.numberOfLines = 0;
        _pollutants.text = @"111111取水用途取水用途取水用途取水用途取水用途取水用途取水用途取水用途取水用途";
    }
    return _pollutants;
}



- (UIButton *)checkAddressBtn{
    if (!_checkAddressBtn) {
        _checkAddressBtn = [[UIButton alloc]init];
        [_checkAddressBtn setTitle:@"查看排污口位置" forState:(UIControlStateNormal)];
        [_checkAddressBtn setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
        _checkAddressBtn.titleLabel.font = SYSTEMFONT(14);
        [_checkAddressBtn setImage:[UIImage imageNamed:@"info_positioning"] forState:(UIControlStateNormal)];
        
        [_checkAddressBtn setImagePosition:(LXMImagePositionLeft) spacing:10];
        
    }
    return _checkAddressBtn;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc]init];
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"info_edit"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _deleteBtn;
}

@end
