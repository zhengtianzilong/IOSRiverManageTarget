//
//  ZLScoreTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLScoreTableViewCell.h"

@interface ZLScoreTableViewCell()<UITextFieldDelegate>



@end

@implementation ZLScoreTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
        
    }
    return self;
    
}

- (void)setUpUI{
    
    _tipsImageV = [[UIImageView alloc]init];
    _tipsImageV.image = [UIImage imageNamed:@"score_tips"];
    [self.contentView addSubview:_tipsImageV];
    
    _numberLabel = [[UILabel alloc]init];
    _numberLabel.font = CHINESE_SYSTEM(12);
    _numberLabel.text = @"01";
    _numberLabel.textColor = [UIColor whiteColor];
    [_tipsImageV addSubview:_numberLabel];
    
    _title = [[UILabel alloc]init];
    _title.font = CHINESE_SYSTEM(12);
    _title.text = @"河面脏乱差";
    [self.contentView addSubview:_title];
    
    _descriptionLabel = [[UILabel alloc]init];
    _descriptionLabel.font = CHINESE_SYSTEM(12);
    _descriptionLabel.text = @"考核开始时间：";
    [self.contentView addSubview:_descriptionLabel];
    

    
    _scoreLabel = [[UILabel alloc]init];
    _scoreLabel.text = @"指标分值：";
    _scoreLabel.font = Font(12);
    [self.contentView addSubview:_scoreLabel];
    
    
    _score = [[UILabel alloc]init];
    _score.text = @"陈庆,李丽";
    _score.font = CHINESE_SYSTEM(12);
    [self.contentView addSubview:_score];
    

    
    _totalScoreLabel = [[UILabel alloc]init];
    _totalScoreLabel.text = @"自评：";
    _totalScoreLabel.font = Font(12);
    [self.contentView addSubview:_totalScoreLabel];
    
    
    _totalScoreTextField = [[UITextField alloc]init];
    _totalScoreTextField.placeholder = @"请输入分值";
    _totalScoreTextField.delegate = self;
    _totalScoreTextField.font = CHINESE_SYSTEM(12);
    _totalScoreTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.contentView addSubview:_totalScoreTextField];
    
    
    [_tipsImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(0);
//        make.width.height.mas_equalTo(40);
        make.top.equalTo(self.contentView).offset(0);
    }];
    
    
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsImageV).offset(5);
        make.right.equalTo(self.tipsImageV.mas_right).offset(-5);
    }];
    
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        //        make.top.equalTo(self.contentView).offset(5);
//        make.right.equalTo(_tipsImageV.mas_left).offset(-5);
        make.right.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView).offset(5);
        make.height.mas_equalTo(20);
    }];
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_title);
        make.top.equalTo(_title.mas_bottom).offset(5);
        make.right.equalTo(_title);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(60);
    }];
    
    [_descriptionLabel setContentCompressionResistancePriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    [_descriptionLabel setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    
    [self setNeedsLayout];
    
    
    
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_title);
        make.top.equalTo(_descriptionLabel.mas_bottom).offset(5);
        make.right.equalTo(_title);
        make.height.mas_equalTo(20);
    }];
    
    [_scoreLabel setContentCompressionResistancePriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    [_scoreLabel setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    
    
    [_score mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scoreLabel.mas_right).offset(0);
        make.top.equalTo(_scoreLabel);
        make.right.equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(_scoreLabel);
    }];
    
  
    
    [_totalScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(_scoreLabel);
        make.height.mas_equalTo(_scoreLabel);
        //        make.width.mas_equalTo(60);
    }];
    [_totalScoreLabel setContentCompressionResistancePriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    [_totalScoreLabel setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    
    [_totalScoreTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_totalScoreLabel.mas_right).offset(0);
        make.top.equalTo(_totalScoreLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (_scroeInputBlock) {
        self.scroeInputBlock(textField.text);
        
    }
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//
//
//    return YES;
//}

@end
