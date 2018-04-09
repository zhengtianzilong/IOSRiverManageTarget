//
//  ZLBillboardInfoView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLBillboardInfoView.h"
#import "ZLBillboardCollectionViewCell.h"
#import "NSArray+ZLJiuGongGe.h"
@interface ZLBillboardInfoView ()

@end
@implementation ZLBillboardInfoView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
     if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         
         self.backgroundColor = [UIColor whiteColor];
         [self.contentView addSubview:self.nameLabel];
         [self.contentView addSubview:self.name];
         [self.contentView addSubview:self.addressLabel];
         [self.contentView addSubview:self.address];
         [self.contentView addSubview:self.pictureLabel];
         [self.contentView addSubview:self.countyLabel];
         [self.contentView addSubview:self.county];
         [self.contentView addSubview:self.title];
         [self.contentView addSubview:self.checkAddressBtn];
         [self.contentView addSubview:self.deleteBtn];
         
         UIView *containerView = [[UIView alloc] init];
         [self.contentView addSubview:containerView];
         self.containerView = containerView;
         
         
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
         
         [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.title);
             make.top.equalTo(self.title.mas_bottom).offset(5);
             make.height.mas_equalTo(20);
             make.width.mas_equalTo(60);
         }];
         
         [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.nameLabel.mas_right).offset(10);
             make.top.equalTo(self.nameLabel);
             make.right.equalTo(self.deleteBtn.mas_left);
             make.height.mas_equalTo(20);
         }];
         
         [self.countyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.title);
             make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
             make.height.mas_equalTo(20);
             make.width.mas_equalTo(60);
         }];
         
         [self.county mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.countyLabel.mas_right).offset(10);
             make.top.equalTo(self.countyLabel);
             make.height.mas_equalTo(20);
             make.right.equalTo(self.deleteBtn.mas_left);
         }];
         
         
         [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.nameLabel);
             make.top.equalTo(self.countyLabel.mas_bottom).offset(5);
             make.height.mas_equalTo(20);
             make.width.mas_equalTo(60);
         }];
         
         [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.addressLabel.mas_right).offset(10);
             make.top.equalTo(self.addressLabel);
             make.right.equalTo(self.deleteBtn.mas_left);
             make.height.mas_greaterThanOrEqualTo(20);
//             make.height.mas_equalTo(20);
         }];
         
         [self.pictureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.nameLabel);
             make.top.greaterThanOrEqualTo(self.address.mas_bottom).offset(5);
//             make.top.equalTo(self.addressLabel.mas_bottom).offset(5);
             make.height.mas_equalTo(20);
             make.width.mas_equalTo(80);
         }];
         
         // 固定containerView的宽
         // 宫格的宽随containerView的宽改变
         // 固定宫格的高
         // containerView的高随宫格的高改变
         [self distributeDynamic2CellWithCount:1 warp:3];
         
         [self.checkAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
             make.centerX.equalTo(self.contentView);
             make.top.equalTo(self.containerView.mas_bottom);
             make.height.mas_equalTo(25);
             make.width.mas_equalTo(150);
             make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
         }];
         
         
         
     }
    return self;
    
    
}

- (void)setPublicBrandModel:(ZLPublicityBrandModel *)publicBrandModel{
    
    _publicBrandModel = publicBrandModel;
    
    _name.text = _publicBrandModel.PUBLICITY_BRAND_NAME;
    _county.text = _publicBrandModel.AREA_NAME;
    _address.text = _publicBrandModel.DETAIL;
    
    for (UIView *view in self.containerView.subviews) {
        if ([view.class isEqual:[UIImageView class]]) {
            
            UIImageView *imageV = (UIImageView *)view;
            
            NSString *urlString = [NSString stringWithFormat:@"%@/%@",@"http://192.168.0.80:1011/", _publicBrandModel.PUBLICITY_BRAND_URL];
            
            NSURL *url = [NSURL URLWithString:urlString];
            [imageV sd_setImageWithURL:url];
        }
    }
    
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//
//        
//    }
//    
//    return self;
//}

// 固定containerView的宽
// 宫格的宽随containerView的宽改变
// 固定宫格的高
// containerView的高随宫格的高改变
- (void)distributeDynamic2CellWithCount:(NSUInteger)count warp:(NSUInteger)warp {
    
    [self.containerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pictureLabel.mas_right).offset(10);
        make.top.equalTo(self.pictureLabel);
        make.right.equalTo(self.deleteBtn.mas_left);
    }];
    
    for (int i = 0; i < count; i++) {
        UIImageView *imageV = [[UIImageView alloc] init];
//        imageV.backgroundColor = [UIColor redColor];
        [self.containerView addSubview:imageV];
    }
    
    [self.containerView.subviews mas_distributeSudokuViewsWithFixedItemWidth:0 fixedItemHeight:60
                                                            fixedLineSpacing:10 fixedInteritemSpacing:10
                                                                   warpCount:3
                                                                  topSpacing:10
                                                               bottomSpacing:10 leadSpacing:10 tailSpacing:10];
}


- (void)layoutSubviews{
    [super layoutSubviews];
   
//    [_nameLabel changeAlignmentRightandLeft];
//    [_countyLabel changeAlignmentRightandLeft];
//    [_pictureLabel changeAlignmentRightandLeft];
//    [_addressLabel changeAlignmentRightandLeft];
}


- (void)deletePublicClick{
    if (_deletePublic) {
        
        self.deletePublic(self.publicBrandModel);
    }
}

- (void)checkAddressBtnClick{
    
    if (_billboardInfoAddress) {
        
        self.billboardInfoAddress(self.publicBrandModel);
        
    }
    
}


- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.text = @"公示牌信息";
        _title.textColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
        _title.font = SYSTEMFONT(18);
    }
    return _title;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"公示牌名";
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



- (UILabel *)pictureLabel{
    if (!_pictureLabel) {
        _pictureLabel = [[UILabel alloc]init];
        _pictureLabel.text = @"公示牌照片";
        _pictureLabel.font = SYSTEMFONT(14);
    }
    return _pictureLabel;
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

- (UIButton *)checkAddressBtn{
    if (!_checkAddressBtn) {
        _checkAddressBtn = [[UIButton alloc]init];
        [_checkAddressBtn setTitle:@"查看公示牌位置" forState:(UIControlStateNormal)];
        [_checkAddressBtn setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
        _checkAddressBtn.titleLabel.font = SYSTEMFONT(14);
        [_checkAddressBtn setImage:[UIImage imageNamed:@"info_positioning"] forState:(UIControlStateNormal)];
        
        [_checkAddressBtn setImagePosition:(LXMImagePositionLeft) spacing:10];
        [_checkAddressBtn addTarget:self action:@selector(checkAddressBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _checkAddressBtn;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc]init];
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        
        [_deleteBtn addTarget:self action:@selector(deletePublicClick) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _deleteBtn;
}

@end
