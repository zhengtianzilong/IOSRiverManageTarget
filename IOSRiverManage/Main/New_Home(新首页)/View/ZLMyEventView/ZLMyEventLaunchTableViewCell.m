//
//  ZLMyEventLaunchTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyEventLaunchTableViewCell.h"
//#import "ZLBillboardCollectionViewCell.h"
#import "NSArray+ZLJiuGongGe.h"
@interface ZLMyEventLaunchTableViewCell ()
@end

@implementation ZLMyEventLaunchTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

// 固定containerView的宽
// 宫格的宽随containerView的宽改变
// 固定宫格的高
// containerView的高随宫格的高改变
- (void)distributeDynamic2CellWithCount:(NSUInteger)count warp:(NSUInteger)warp {
    
    [self.containerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.describe);
        make.top.equalTo(self.describe.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
    }];
    
    for (int i = 0; i < count; i++) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor redColor];
        [self.containerView addSubview:view];
    }
    
    [self.containerView.subviews mas_distributeSudokuViewsWithFixedItemWidth:0 fixedItemHeight:60
                                                            fixedLineSpacing:10 fixedInteritemSpacing:10
                                                                   warpCount:3
                                                                  topSpacing:10
                                                               bottomSpacing:10 leadSpacing:10 tailSpacing:10];
}


- (void)setupUI{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.stateLable];
    [self.contentView addSubview:self.state];
    [self.contentView addSubview:self.originatorLabel];
    [self.contentView addSubview:self.originator];
    [self.contentView addSubview:self.receiveLabel];
    [self.contentView addSubview:self.receive];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.describeLabel];
    [self.contentView addSubview:self.describe];
    
    UIView *containerView = [[UIView alloc] init];
    [self.contentView addSubview:containerView];
    self.containerView = containerView;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(5);
        make.height.mas_equalTo(20);
        make.width.equalTo(self.contentView);
        //        make.width.mas_equalTo(100);
        
    }];
    
    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
        
    }];
    
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.stateLable.mas_right);
        make.top.equalTo(self.stateLable);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(50);
        
    }];
    
    [self.originatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.stateLable.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
        
    }];
    
    [self.originator mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.originatorLabel.mas_right);
        make.top.equalTo(self.originatorLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(50);
        
    }];
    
    
    [self.receiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.originatorLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
    }];
    
    [self.receive mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.receiveLabel.mas_right);
        make.top.equalTo(self.receiveLabel);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.receiveLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
        
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.timeLabel.mas_right);
        make.top.equalTo(self.timeLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(50);
        
    }];
    
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
        
    }];
    
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.describeLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.describeLabel).offset(0);
        //        make.height.mas_equalTo(80);
        //        make.width.mas_equalTo(50);
        
    }];
    
    
    // 固定containerView的宽
    // 宫格的宽随containerView的宽改变
    // 固定宫格的高
    // containerView的高随宫格的高改变
    [self distributeDynamic2CellWithCount:8 warp:3];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
   
    
    
//    [self.stateLable changeAlignmentRightandLeft];
//    [self.originatorLabel changeAlignmentRightandLeft];
//    [self.receiveLabel changeAlignmentRightandLeft];
//    [self.timeLabel changeAlignmentRightandLeft];
//    [self.describeLabel changeAlignmentRightandLeft];
}



- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
        _titleLabel.text = @"养鸡场查看";
        _titleLabel.font = CHINESE_SYSTEM(18);
    }
    return _titleLabel;
}


- (UILabel *)stateLable{
    if (!_stateLable) {
        _stateLable = [[UILabel alloc]init];
        _stateLable.text = @"状态：";
        _stateLable.font = Font(14);
    }
    return _stateLable;
}
- (UILabel *)state{
    if (!_state) {
        _state = [[UILabel alloc]init];
        _state.text = @"XXXXX";
        _state.font = CHINESE_SYSTEM(14);
    }
    return _state;
}

- (UILabel *)originatorLabel{
    if (!_originatorLabel) {
        _originatorLabel = [[UILabel alloc]init];
        _originatorLabel.text = @"发起人：";
        _originatorLabel.font = Font(14);
    }
    return _originatorLabel;
}

- (UILabel *)originator{
    if (!_originator) {
        _originator = [[UILabel alloc]init];
        _originator.text = @"80";
        _originator.font = CHINESE_SYSTEM(14);
    }
    return _originator;
}

- (UILabel *)receiveLabel{
    if (!_receiveLabel) {
        _receiveLabel = [[UILabel alloc]init];
        _receiveLabel.text = @"接收人：";
        _receiveLabel.font = Font(14);
    }
    return _receiveLabel;
}

- (UILabel *)receive{
    if (!_receive) {
        _receive = [[UILabel alloc]init];
        _receive.text = @"123";
        _receive.font = CHINESE_SYSTEM(14);
    }
    return _receive;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"时间：";
        _timeLabel.font = Font(14);
    }
    return _timeLabel;
}

- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.text = @"系统管理员标记";
        _time.font = CHINESE_SYSTEM(14);
    }
    return _time;
}



- (UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc]init];
        _describeLabel.text = @"描述：";
        _describeLabel.font = Font(14);
    }
    return _describeLabel;
}

- (UILabel *)describe{
    if (!_describe) {
        _describe = [[UILabel alloc]init];
        _describe.text = @"系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记";
        _describe.font = CHINESE_SYSTEM(14);
        _describe.numberOfLines = 0;
    }
    return _describe;
}




@end
