//
//  ZLMyEventDealDetailCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyEventDealDetailCell.h"
#import "NSArray+ZLJiuGongGe.h"
@interface ZLMyEventDealDetailCell ()
@end

@implementation ZLMyEventDealDetailCell
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
//        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_greaterThanOrEqualTo(80);
        
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
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.eventLabel];
    [self.contentView addSubview:self.event];
    [self.contentView addSubview:self.stateLable];
    [self.contentView addSubview:self.state];
    [self.contentView addSubview:self.originatorLabel];
    [self.contentView addSubview:self.originator];
    [self.contentView addSubview:self.receiveLabel];
    [self.contentView addSubview:self.receive];
    [self.contentView addSubview:self.departLabel];
    [self.contentView addSubview:self.depart];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.describeLabel];
    [self.contentView addSubview:self.describe];
    [self.contentView addSubview:self.attachmentLabel];
    [self.contentView addSubview:self.attachment];
    UIView *containerView = [[UIView alloc] init];
    [self.contentView addSubview:containerView];
    self.containerView = containerView;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.contentView.mas_right);
        //        make.width.mas_equalTo(100);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
        make.width.equalTo(self.contentView);
        //        make.width.mas_equalTo(100);
        
    }];
    
    [self.eventLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.lineView.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
        
    }];
    
    [self.event mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.eventLabel.mas_right);
        make.top.equalTo(self.eventLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(50);
        
    }];
    
    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.eventLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
        
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
        make.width.mas_equalTo(60);
        
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
        make.width.mas_equalTo(60);
    }];
    
    [self.receive mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.receiveLabel.mas_right);
        make.top.equalTo(self.receiveLabel);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.departLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.receiveLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
        
    }];
    
    [self.depart mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.departLabel.mas_right);
        make.top.equalTo(self.departLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(50);
        
    }];
    
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.departLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
        
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
        make.width.mas_equalTo(60);
        
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
    
    [self.attachmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.containerView.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
        
    }];
    
    [self.attachment mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.attachmentLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.attachmentLabel).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom);
        //        make.height.mas_equalTo(80);
        //        make.width.mas_equalTo(50);
        
    }];
    
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
        _titleLabel.text = @"事件信息";
        _titleLabel.font = Font(18);
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
    }
    return _lineView;
}

- (UILabel *)eventLabel{
    if (!_eventLabel) {
        _eventLabel = [[UILabel alloc]init];
        _eventLabel.text = @"事件名称：";
        _eventLabel.font = Font(14);
    }
    return _eventLabel;
}
- (UILabel *)event{
    if (!_event) {
        _event = [[UILabel alloc]init];
        _event.text = @"XXXXX";
        _event.font = CHINESE_SYSTEM(14);
    }
    return _event;
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
        _originatorLabel.text = @"创建人：";
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

- (UILabel *)departLabel{
    if (!_departLabel) {
        _departLabel = [[UILabel alloc]init];
        _departLabel.text = @"接收部门：";
        _departLabel.font = Font(14);
    }
    return _departLabel;
}

- (UILabel *)depart{
    if (!_depart) {
        _depart = [[UILabel alloc]init];
        _depart.text = @"123";
        _depart.font = CHINESE_SYSTEM(14);
    }
    return _depart;
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
        _describeLabel.text = @"内容：";
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

- (UILabel *)attachmentLabel{
    if (!_attachmentLabel) {
        _attachmentLabel = [[UILabel alloc]init];
        _attachmentLabel.text = @"附件：";
        _attachmentLabel.font = Font(14);
        
    }
    return _attachmentLabel;
}

- (UILabel *)attachment{
    if (!_attachment) {
        _attachment = [[UILabel alloc]init];
        _attachment.text = @"系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记";
        _attachment.font = CHINESE_SYSTEM(14);
        _attachment.numberOfLines = 0;
    }
    return _attachment;
}

@end
