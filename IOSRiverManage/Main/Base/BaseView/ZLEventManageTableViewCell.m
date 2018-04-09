//
//  ZLEventManageTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/1/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManageTableViewCell.h"

@implementation ZLEventManageTableViewCell


- (void)setFrame:(CGRect)frame{
    
    frame.size.width = Main_Screen_Width - 20;
    frame.origin.x = 10;
    [super setFrame:frame];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
        
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        
    }
    return self;
    
}

- (void)setUpUI{
    
    
    _state = [[UILabel alloc]init];
    _state.text = @"已发起";
    _state.font = CHINESE_SYSTEM(15);
    _state.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_state];
    
    _colorIndicator = [[UIImageView alloc]init];
    _colorIndicator.image = [UIImage imageNamed:@"event_point"];
    [self.contentView addSubview:_colorIndicator];
    
    _title = [[UILabel alloc]init];
    _title.font = CHINESE_SYSTEM(16);
    _title.text = @"河面脏乱差";
    [self.contentView addSubview:_title];
    
    
    _lineViewTop = [[UIView alloc]init];
    _lineViewTop.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    [self.contentView addSubview:_lineViewTop];
    
    _imageV = [[UIImageView alloc]init];
    _imageV.image = [UIImage imageNamed:@"event_placeImage"];
    [self.contentView addSubview:_imageV];
    
    
    _initiatorLabel = [[UILabel alloc]init];
    _initiatorLabel.font = CHINESE_SYSTEM(14);
    _initiatorLabel.text = @"发起人:";
    [self.contentView addSubview:_initiatorLabel];
    
    _initiatorName = [[UILabel alloc]init];
    _initiatorName.text = @"李乐";
    _initiatorName.font = CHINESE_SYSTEM(14);
    [self.contentView addSubview:_initiatorName];
    
    
    
    _receivedLabel = [[UILabel alloc]init];
    _receivedLabel.text = @"接收人:";
    _receivedLabel.font = CHINESE_SYSTEM(14);
    [self.contentView addSubview:_receivedLabel];
    
    
    _receivedName = [[UILabel alloc]init];
    _receivedName.text = @"陈庆,李丽";
    _receivedName.font = CHINESE_SYSTEM(14);
    [self.contentView addSubview:_receivedName];
    
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.text = @"内 容:";
    _contentLabel.font = CHINESE_SYSTEM(14);
    [self.contentView addSubview:_contentLabel];
    
    
    _content = [[UILabel alloc]init];
    _content.text = @"河道有许多垃圾袋,饮料瓶等等,相关部门注意看看啊啊啊啊啊啊啊啊啊啊多多发付军爱所付军奥所付所撒多付囧撒多军付";
    _content.font = CHINESE_SYSTEM(14);
    _content.numberOfLines = 2;
    [self.contentView addSubview:_content];
    
    
    _lineViewBottom = [[UIView alloc]init];
    _lineViewBottom.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    [self.contentView addSubview:_lineViewBottom];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.text = @"2017-10-11 11:28";
    _timeLabel.font = CHINESE_SYSTEM(14);
    [self.contentView addSubview:_timeLabel];
    
    
    [_state mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(self.contentView).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
    }];
    
    [_colorIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.width.height.mas_equalTo(10);
        make.centerY.equalTo(_state);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_colorIndicator.mas_right).offset(5);
//        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(_state.mas_left).offset(-5);
        make.centerY.equalTo(_colorIndicator);
        
        make.height.mas_equalTo(20);
        
    }];
    
    [_lineViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(_state.mas_bottom).offset(5);
        make.height.mas_equalTo(1);
    }];
    
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(_lineViewTop.mas_bottom).offset(15);
        make.height.mas_equalTo(65);
        make.width.mas_equalTo(65);
    }];
    
    [_initiatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_imageV.mas_right).offset(10);
        make.top.equalTo(_imageV.mas_top);
        make.height.mas_equalTo(20);
    }];
    
    [_initiatorName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_initiatorLabel.mas_right).offset(0);
        make.top.equalTo(_initiatorLabel);
        make.height.mas_equalTo(_initiatorLabel);
    }];
    
    [_receivedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_initiatorLabel);
        make.top.equalTo(_initiatorLabel.mas_bottom);
       make.height.mas_equalTo(_initiatorLabel);
    }];
    
    [_receivedName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_receivedLabel.mas_right).offset(0);
        make.top.equalTo(_receivedLabel);
        make.height.mas_equalTo(_initiatorLabel);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_initiatorLabel);
        make.top.equalTo(_receivedLabel.mas_bottom);
        make.height.mas_equalTo(_initiatorLabel);
        make.width.mas_equalTo(45);
    }];
//    [_contentLabel setContentCompressionResistancePriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentLabel.mas_right).offset(0);
        make.top.equalTo(_contentLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_equalTo(20);
//        make.bottom.equalTo(_lineViewBottom.mas_top).offset(0);
    }];
//    [_content setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
//    [_content setContentCompressionResistancePriority:(UILayoutPriorityFittingSizeLevel) forAxis:(UILayoutConstraintAxisHorizontal)];
    
    [_lineViewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(_content.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];

    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_imageV);
        make.top.equalTo(_lineViewBottom.mas_bottom).offset(10);
//        make.height.mas_equalTo(30);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        
//        make.width.mas_equalTo(Main_Screen_Width / 2);
        
    }];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
   
    
    
    
}


@end
