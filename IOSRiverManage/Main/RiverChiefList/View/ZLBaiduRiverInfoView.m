//
//  ZLBaiduRiverInfoView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/20.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLBaiduRiverInfoView.h"

@implementation ZLBaiduRiverInfoView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
        
    }
    return self;
}

- (void)setUpUI{

    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = AdaptedFontBoldSize(22);
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(AdaptedWidth(40));
        make.top.equalTo(self).offset(AdaptedWidth(10));
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(AdaptedHeight(50));
        
        
    }];
    
//    _levelLabel = [[UILabel alloc]init];
//    _levelLabel.font = AdaptedFontBoldSize(18);
//    [self addSubview:_levelLabel];
//    [_levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(_titleLabel.mas_right).offset(AdaptedWidth(0));
//        make.bottom.equalTo(_titleLabel);
//        make.right.equalTo(self.mas_right);
//        make.height.mas_equalTo(AdaptedHeight(40));
//        
//        
//    }];

    _startLabel = [[UILabel alloc]init];
    _startLabel.text = @"起:";
    _startLabel.font = AdaptedFontSize(17);
    [self addSubview:_startLabel];
    [_startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(AdaptedWidth(40));
        make.top.equalTo(_titleLabel.mas_bottom).offset(AdaptedWidth(0));
        make.height.mas_equalTo(22);
        
        
    }];
    
    _startAddressLabel = [[UILabel alloc]init];
    _startAddressLabel.font = AdaptedFontSize(17);
    [self addSubview:_startAddressLabel];
    [_startAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_startLabel.mas_right);
        make.top.equalTo(_startLabel);
        make.height.mas_equalTo(22);
    }];
    
    _endLabel = [[UILabel alloc]init];
    _endLabel.text = @"终:";
    _endLabel.font = AdaptedFontSize(17);
    [self addSubview:_endLabel];
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_startLabel);
        make.top.equalTo(_startLabel.mas_bottom).offset(AdaptedWidth(0));
        make.height.mas_equalTo(22);
    }];
    
    _endAddressLabel = [[UILabel alloc]init];
//    _endAddressLabel.text = @"水西门大街132号";
    _endAddressLabel.font = AdaptedFontSize(17);
    [self addSubview:_endAddressLabel];
    [_endAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_endLabel.mas_right);
        make.top.equalTo(_endLabel);
        make.height.mas_equalTo(22);
    }];
}

- (void)setDemandModel:(ZLRiverDemandModel *)demandModel{
    // 省 市 区 街道 村
    _demandModel = demandModel;
    
    // 河段等级
    NSString *riverLevel = @"";
    
    if ([demandModel.org_type isEqualToString:@"1"]) {
        riverLevel = @"(省级河段)";
    }else if ([demandModel.org_type isEqualToString:@"2"]) {
        riverLevel = @"(市级河段)";
    }else if ([demandModel.org_type isEqualToString:@"3"]) {
        riverLevel = @"(区级河段)";
    }else if ([demandModel.org_type isEqualToString:@"4"]) {
        riverLevel = @"(街道级河段)";
    }else{
        riverLevel = @"(村级河段)";
    }
    
//      NSAttributedString *levelattribut = [[NSAttributedString alloc]initWithString:riverLevel attributes:@{NSFontAttributeName:AdaptedFontBoldSize(17)}];
    NSMutableAttributedString *totalStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",demandModel.rivers_name,riverLevel]];
    
    [totalStr addAttribute:NSFontAttributeName value:AdaptedFontBoldSize(17) range:NSMakeRange(demandModel.rivers_name.length, riverLevel.length)];
    
    [totalStr addAttribute:NSFontAttributeName value:AdaptedFontBoldSize(22) range:NSMakeRange(0, demandModel.rivers_name.length)];
    
    _titleLabel.attributedText = totalStr;
  
    
    
    
//    _levelLabel.text = riverLevel;
    

    
    _startAddressLabel.text = demandModel.start_point_desc;
    _endAddressLabel.text = demandModel.end_point_desc;
    
    [self setNeedsLayout];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    
//    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_titleLabel.mas_right);
//    }];
//    
}

@end
