//
//  ZLRiverInfoBaseChangeAreaTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/9.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverInfoBaseChangeAreaTableViewCell.h"
#import "BRAddressPickerView.h"
@interface ZLRiverInfoBaseChangeAreaTableViewCell()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation ZLRiverInfoBaseChangeAreaTableViewCell
- (void)dealloc {
    
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self setupUI];
        
    }
    return self;
    
}

- (void)setupUI{
    [self.contentView addSubview:self.bgView];
    
    [self.bgView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.areaBtn];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(90);
        make.top.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bgView).offset(10);
        make.right.equalTo(self.bgView.mas_right);
        //        make.top.equalTo(self.bgView).offset(10);
        make.centerY.equalTo(self.bgView);
        make.height.mas_equalTo(40);
        
    }];
    [self.areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bgView.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.titleLabel);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
    }];
    
}

- (void)tapClick{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@0,@0,@0] isAutoSelect:YES resultBlock:^(NSArray *selectAddressArr) {
       
        ZLLog(@"%@", selectAddressArr);
        
        NSString *title = [NSString stringWithFormat:@"%@ %@ %@",selectAddressArr[0],selectAddressArr[1],selectAddressArr[2]];
        
        [_areaBtn setTitle:title forState:(UIControlStateNormal)];
        
    }];
    
}


- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    
    return _bgView;
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"所在区县：";
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = CHINESE_SYSTEM(13);
        
    }
    return _titleLabel;
}

- (UIButton *)areaBtn{
    
    if (!_areaBtn) {
        _areaBtn = [[UIButton alloc]init];
        _areaBtn.backgroundColor = [UIColor whiteColor];
        
        [_areaBtn setTitle:@"江苏省 南京市 浦口区" forState:(UIControlStateNormal)];
        [_areaBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _areaBtn.titleLabel.font = CHINESE_SYSTEM(13);
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        
//        [_areaBtn addGestureRecognizer:tap];
        
        [_areaBtn addTarget:self action:@selector(tapClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        
    }
    return  _areaBtn;
    
    
}

@end
