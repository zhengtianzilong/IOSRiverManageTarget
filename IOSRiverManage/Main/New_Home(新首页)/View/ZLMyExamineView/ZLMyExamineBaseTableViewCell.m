//
//  ZLMyExamineBaseTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/15.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyExamineBaseTableViewCell.h"

@implementation ZLMyExamineBaseTableViewCell

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
    
    
//    _state = [[UILabel alloc]init];
//    _state.text = @"已发起";
//    _state.font = Font(13);
//    _state.textColor = HEXCOLOR(CVIEW_EVENT_TIPS_COLOR);
//    _state.textAlignment = NSTextAlignmentRight;
//    [self.contentView addSubview:_state];
    
    _colorIndicator = [[UIImageView alloc]init];
    _colorIndicator.image = [UIImage imageNamed:@"score_point"];
    [self.contentView addSubview:_colorIndicator];
    
    _title = [[UILabel alloc]init];
    _title.font = Font(14);
    _title.text = @"河面脏乱差";
    [self.contentView addSubview:_title];
    
    
    _lineViewTop = [[UIView alloc]init];
    _lineViewTop.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    [self.contentView addSubview:_lineViewTop];
    
//    _imageV = [[UIImageView alloc]init];
//    _imageV.image = [UIImage imageNamed:@"event_placeImage"];
//    [self.contentView addSubview:_imageV];
    
    
    _startTimeLable = [[UILabel alloc]init];
    _startTimeLable.font = Font(12);
    _startTimeLable.text = @"考核开始时间：";
    [self.contentView addSubview:_startTimeLable];
    
    _startTime = [[UILabel alloc]init];
    _startTime.text = @"李乐";
    _startTime.font = CHINESE_SYSTEM(12);
    [self.contentView addSubview:_startTime];
    
    _endTimeLable = [[UILabel alloc]init];
    _endTimeLable.text = @"考核结束时间：";
    _endTimeLable.font = Font(12);
    [self.contentView addSubview:_endTimeLable];
    
    
    _endTime = [[UILabel alloc]init];
    _endTime.text = @"陈庆,李丽";
    _endTime.font = CHINESE_SYSTEM(12);
    [self.contentView addSubview:_endTime];
    
    
    _scoreLabel = [[UILabel alloc]init];
    _scoreLabel.text = @"总分：";
    _scoreLabel.font = Font(12);
    [self.contentView addSubview:_scoreLabel];
    
    
    _score = [[UILabel alloc]init];
    _score.text = @"河道有许多垃圾袋,饮料瓶等等,相关部门注意看看啊啊啊啊啊啊啊啊啊啊多多发付军爱所付军奥所付所撒多付囧撒多军付";
    _score.font = CHINESE_SYSTEM(12);
    [self.contentView addSubview:_score];
    
    _totalScoreLabel = [[UILabel alloc]init];
    _totalScoreLabel.text = @"自评总分：";
    _totalScoreLabel.font = Font(12);
    [self.contentView addSubview:_totalScoreLabel];
    
    
    _totalScore = [[UILabel alloc]init];
    _totalScore.text = @"河道有许多垃圾袋,饮料瓶等等,相关部门注意看看啊啊啊啊啊啊啊啊啊啊多多发付军爱所付军奥所付所撒多付囧撒多军付";
    _totalScore.font = CHINESE_SYSTEM(12);
    [self.contentView addSubview:_totalScore];
    

    _lineViewBottom = [[UIView alloc]init];
    _lineViewBottom.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    [self.contentView addSubview:_lineViewBottom];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.text = @"2017-10-11 11:28";
    _timeLabel.font = CHINESE_SYSTEM(12);
    [self.contentView addSubview:_timeLabel];
    
    [self.contentView addSubview:self.scoreBtn];
    

    [self.contentView addSubview:self.commitBtn];
    
    
//    [_state mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(self.contentView.mas_right).offset(-5);
//        make.top.equalTo(self.contentView).offset(5);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(60);
//    }];
    
    [_colorIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.width.height.mas_equalTo(12);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_colorIndicator.mas_right).offset(5);
        //        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.centerY.equalTo(_colorIndicator);
        make.height.mas_equalTo(20);
        
    }];
    
    
    
    [_lineViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(_title.mas_bottom).offset(5);
        make.height.mas_equalTo(1);
    }];
    
    
    [_startTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(_lineViewTop.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(60);
    }];
    
    [_startTimeLable setContentCompressionResistancePriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    [_startTimeLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    
    [self setNeedsLayout];
    
    
    [_startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_startTimeLable.mas_right).offset(0);
        make.top.equalTo(_startTimeLable);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_equalTo(_startTimeLable);
    }];
    
    [_endTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_startTimeLable);
        make.top.equalTo(_startTimeLable.mas_bottom);
        make.height.mas_equalTo(_startTimeLable);
        //        make.width.mas_equalTo(60);
    }];
    
    [_endTimeLable setContentCompressionResistancePriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    [_endTimeLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    
    
    [_endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_endTimeLable.mas_right).offset(0);
        make.top.equalTo(_endTimeLable);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_equalTo(_endTimeLable);
    }];
    
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_startTimeLable);
        make.top.equalTo(_endTimeLable.mas_bottom);
        make.height.mas_equalTo(_endTimeLable);
        //        make.width.mas_equalTo(60);
    }];
    [_scoreLabel setContentCompressionResistancePriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    [_scoreLabel setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    
    [_score mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scoreLabel.mas_right).offset(0);
        make.top.equalTo(_scoreLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_equalTo(20);
        //        make.bottom.equalTo(_lineViewBottom.mas_top).offset(0);
    }];
   
    [_totalScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_startTimeLable);
        make.top.equalTo(_scoreLabel.mas_bottom);
        make.height.mas_equalTo(_endTimeLable);
        //        make.width.mas_equalTo(60);
    }];
    [_totalScoreLabel setContentCompressionResistancePriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    [_totalScoreLabel setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    
    [_totalScore mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_totalScoreLabel.mas_right).offset(0);
        make.top.equalTo(_totalScoreLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_equalTo(20);
        //        make.bottom.equalTo(_lineViewBottom.mas_top).offset(0);
    }];
    
    
    
    [_lineViewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(_totalScoreLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(1);
    }];
    
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_startTimeLable);
        make.top.equalTo(_lineViewBottom.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        
        //        make.width.mas_equalTo(Main_Screen_Width / 2);
        
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.lineViewBottom.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(55);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    [self.scoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.commitBtn.mas_left).offset(-10);
        make.top.equalTo(self.lineViewBottom.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(55);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    
}

- (void)scoreBtnBtnClick{
    
    if (self.scoreClick) {
        
        self.scoreClick();
        
    }
    
}

- (void)commitBtnBtnClick{
    
    if (self.commitClick) {
        
        self.commitClick();
        
    }
    
}

- (UIButton *)scoreBtn{
    if (!_scoreBtn) {
        _scoreBtn = [[UIButton alloc]init];
        [_scoreBtn setTitle:@"评分" forState:(UIControlStateNormal)];
        [_scoreBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _scoreBtn.titleLabel.font = CHINESE_SYSTEM(14);
        _scoreBtn.layer.borderWidth = 1;
        _scoreBtn.layer.cornerRadius = 5;
        _scoreBtn.layer.borderColor = HEXCOLOR(CVIEW_GRAY_COLOR).CGColor;
        _scoreBtn.layer.masksToBounds = YES;
        [_scoreBtn addTarget:self action:@selector(scoreBtnBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _scoreBtn;
}

- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [[UIButton alloc]init];
        [_commitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
        [_commitBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _commitBtn.titleLabel.font = CHINESE_SYSTEM(14);
        _commitBtn.layer.borderWidth = 1;
        _commitBtn.layer.cornerRadius = 5;
        _commitBtn.layer.borderColor = HEXCOLOR(CVIEW_GRAY_COLOR).CGColor;
        _commitBtn.layer.masksToBounds = YES;
        [_commitBtn addTarget:self action:@selector(commitBtnBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _commitBtn;
}




@end
