//
//  ZLRiverIntakeInfoTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverIntakeInfoTableViewCell.h"
#import "NSArray+ZLJiuGongGe.h"
#import "ZLGetVideoFirstImage.h"
@interface ZLRiverIntakeInfoTableViewCell ()<MWPhotoBrowserDelegate>
@property (nonatomic,retain) NSMutableArray *photosArray;
@end
@implementation ZLRiverIntakeInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.codeLabel];
        [self.contentView addSubview:self.code];
        
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
        [self.contentView addSubview:self.useLabel];
        [self.contentView addSubview:self.use];
        
        [self.contentView addSubview:self.pictureLabel];
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
//            make.top.equalTo(self.addressLabel.mas_bottom).offset(5);
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
        
        [self.useLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.phoneLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        
        [self.use mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.useLabel.mas_right).offset(5);
            make.top.equalTo(self.useLabel);
            make.right.equalTo(self.deleteBtn.mas_left);
            make.height.mas_greaterThanOrEqualTo(20);
        }];
        
        [self.pictureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.greaterThanOrEqualTo(self.useLabel.mas_bottom).offset(5);
            //             make.top.equalTo(self.addressLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
//            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        
        
        
        
        
    }
    return self;
    
    
}

- (void)setPumpingPortModel:(ZLPumpingPortModel *)pumpingPortModel{
    
    _pumpingPortModel = pumpingPortModel;
    _code.text = _pumpingPortModel.CODE;
    
    _name.text = _pumpingPortModel.NAME;
    
    _county.text = _pumpingPortModel.AREA_NAME;
    
    _address.text = _pumpingPortModel.ADDRESS;
    
    _people.text = _pumpingPortModel.CONTACTPERSON;
    
    _phone.text = _pumpingPortModel.PHONE;
    
    _use.text = _pumpingPortModel.CONTANT;
    
    // 固定containerView的宽
    // 宫格的宽随containerView的宽改变
    // 固定宫格的高
    // containerView的高随宫格的高改变
    
    if (_pumpingPortModel.imgList.count > 0) {
        [self distributeDynamic2CellWithCount:_pumpingPortModel.imgList.count warp:3 withImageUrl:_pumpingPortModel.imgList];
    }else{
        
        [self.pictureLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.greaterThanOrEqualTo(self.useLabel.mas_bottom).offset(5);
            //             make.top.equalTo(self.addressLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        
        
//        [self distributeDynamic2CellWithCount:0 warp:3 withImageUrl:_pumpingPortModel.imgList];
    }
    
//    [self.checkAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.contentView);
//        make.top.equalTo(self.containerView.mas_bottom).offset(10);
//        make.height.mas_equalTo(25);
//        make.width.mas_equalTo(150);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
//    }];
    
}

// 固定containerView的宽
// 宫格的宽随containerView的宽改变
// 固定宫格的高
// containerView的高随宫格的高改变
- (void)distributeDynamic2CellWithCount:(NSUInteger)count warp:(NSUInteger)warp withImageUrl:(NSArray *)urls {
    
    [self.containerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pictureLabel.mas_right).offset(10);
        make.top.equalTo(self.pictureLabel);
        make.right.equalTo(self.deleteBtn.mas_left);
        make.height.mas_equalTo(80);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    for (int i = 0; i < count; i++) {
        UIImageView *imageV = [[UIImageView alloc] init];
        
        ZLTaskInfoImageListModel *imageModel = urls[i];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImage_URL, imageModel.fileAddr]];
        
        NSString *urlString = [NSString stringWithFormat:@"%@%@",BaseImage_URL,imageModel.fileAddr];
        
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImage_URL,urls[i]]];
//
//        NSString *urlString = [NSString stringWithFormat:@"%@%@",BaseImage_URL,urls[i]];
        NSString *suffix = [urlString pathExtension];
        MWPhoto *photo = [MWPhoto photoWithURL:url];
        if ([suffix isEqualToString:@"mp4"]) {
            
            photo.videoURL = url;
            photo.isVideo = YES;
            
//            imageV.image = [UIImage imageNamed:@"PlayVideo"];
//            imageV.image = [[ZLGetVideoFirstImage sharedManager]thumbnailImageForVideo:url atTime:1];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                UIImage *image = [[ZLGetVideoFirstImage sharedManager]thumbnailImageForVideo:url atTime:1];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageV.image = image;
                });
                
            });
            
            
        }else{
            
            [imageV sd_setImageWithURL:url];
            
        }
        
        [self.photosArray addObject:photo];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        
        imageV.tag = (i + 1000);
        imageV.userInteractionEnabled = YES;
        [imageV addGestureRecognizer:tap];
        
        //        imageV.backgroundColor = [UIColor redColor];
        [self.containerView addSubview:imageV];
    }
    
    
    [self.containerView.subviews mas_distributeSudokuViewsWithFixedItemWidth:0 fixedItemHeight:80
                                                            fixedLineSpacing:10 fixedInteritemSpacing:10
                                                                   warpCount:3
                                                                  topSpacing:10
                                                               bottomSpacing:10 leadSpacing:10 tailSpacing:10];
}

//必须实现的方法
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return  self.photosArray.count;
}
- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    
    if (index < self.photosArray.count) {
        return [self.photosArray objectAtIndex:index];
    }
    return nil;
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    
    UIImageView *imageV = (UIImageView *)tap.view;
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.alwaysShowControls = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.displayNavArrows = NO;
    browser.startOnGrid = NO;
    browser.enableGrid = YES;
    [browser setCurrentPhotoIndex:imageV.tag - 1000];
    //这样处理的目的是让整个页面跳转更加自然
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:browser];
    navC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.viewController presentViewController:navC animated:YES completion:nil];
}




- (void)layoutSubviews{
    [super layoutSubviews];
    
//    [_nameLabel changeAlignmentRightandLeft];
//    [_countyLabel changeAlignmentRightandLeft];
//    [_pictureLabel changeAlignmentRightandLeft];
//    [_addressLabel changeAlignmentRightandLeft];
}

- (void)deleteBtnClick{
    
    if (_deletepump) {
        
        self.deletepump(self.pumpingPortModel);
        
    }
    
}

- (void)checkAddressBtnClick{
    
    if (_checkAddress) {
        
        self.checkAddress(self.pumpingPortModel);
        
    }
    
}


- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.text = @"取水口信息";
        _title.textColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
        _title.font = Font(16);
    }
    return _title;
}

- (UILabel *)codeLabel{
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc]init];
        _codeLabel.text = @"取水口编码";
        _codeLabel.font = Font(12);
    }
    return _codeLabel;
}

- (UILabel *)code{
    if (!_code) {
        _code = [[UILabel alloc]init];
        _code.font = CHINESE_SYSTEM(12);
        _code.text = @"111111";
    }
    return _code;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"取水口名称";
        _nameLabel.font = Font(12);
    }
    return _nameLabel;
}

- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.font = CHINESE_SYSTEM(12);
        _name.text = @"111111";
    }
    return _name;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.text = @"位置";
        
        _addressLabel.font = Font(12);
    }
    return _addressLabel;
}

- (UILabel *)address{
    if (!_address) {
        _address = [[UILabel alloc]init];
        _address.font = CHINESE_SYSTEM(12);
        _address.numberOfLines = 0;
        _address.text = @"111111";
    }
    return _address;
}



- (UILabel *)peopleLabel{
    if (!_peopleLabel) {
        _peopleLabel = [[UILabel alloc]init];
        _peopleLabel.text = @"联系人";
        _peopleLabel.font = Font(12);
    }
    return _peopleLabel;
}
- (UILabel *)people{
    if (!_people) {
        _people = [[UILabel alloc]init];
        _people.text = @"ssdadds";
        _people.font = CHINESE_SYSTEM(12);
    }
    return _people;
}

- (UILabel *)countyLabel{
    if (!_countyLabel) {
        _countyLabel = [[UILabel alloc]init];
        _countyLabel.font = Font(12);
        _countyLabel.text = @"所属区县";
    }
    return _countyLabel;
}


- (UILabel *)county{
    if (!_county) {
        _county = [[UILabel alloc]init];
        _county.font = CHINESE_SYSTEM(12);
        _county.text = @"111111";
    }
    return _county;
}

- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = Font(12);
        _phoneLabel.text = @"联系电话";
    }
    return _phoneLabel;
}


- (UILabel *)phone{
    if (!_phone) {
        _phone = [[UILabel alloc]init];
        _phone.font = CHINESE_SYSTEM(12);
        _phone.text = @"111111sss";
    }
    return _phone;
}

- (UILabel *)useLabel{
    if (!_useLabel) {
        _useLabel = [[UILabel alloc]init];
        _useLabel.font = Font(12);
        _useLabel.text = @"取水用途";
    }
    return _useLabel;
}


- (UILabel *)use{
    if (!_use) {
        _use = [[UILabel alloc]init];
        _use.font = CHINESE_SYSTEM(12);
        _use.numberOfLines = 0;
        _use.text = @"111111取水用途取水用途取水用途取水用途取水用途取水用途取水用途取水用途取水用途";
    }
    return _use;
}



- (UIButton *)checkAddressBtn{
    if (!_checkAddressBtn) {
        _checkAddressBtn = [[UIButton alloc]init];
        [_checkAddressBtn setTitle:@"查看取水口位置" forState:(UIControlStateNormal)];
        [_checkAddressBtn setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
        _checkAddressBtn.titleLabel.font = Font(12);
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
        
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _deleteBtn;
}

- (UILabel *)pictureLabel{
    if (!_pictureLabel) {
        _pictureLabel = [[UILabel alloc]init];
        _pictureLabel.text = @"取水口照片";
        _pictureLabel.font = Font(12);
    }
    return _pictureLabel;
}



@end
