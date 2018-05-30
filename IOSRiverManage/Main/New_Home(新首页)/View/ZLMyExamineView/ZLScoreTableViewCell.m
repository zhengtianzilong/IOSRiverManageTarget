//
//  ZLScoreTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLScoreTableViewCell.h"
//#import "UITextView+ZWPlaceHolder.h"



@interface ZLScoreTableViewCell()<UITextViewDelegate>

@property (nonatomic, assign) BOOL isHaveDian;

@property (nonatomic, assign) BOOL isFirstZero;

@end

@implementation ZLScoreTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
        
    }
    return self;
    
}

- (void)setUpUI{
    
//    _tipsImageV = [[UIImageView alloc]init];
//    _tipsImageV.image = [UIImage imageNamed:@"score_tips"];
//    [self.contentView addSubview:_tipsImageV];
    
//    _numberLabel = [[UILabel alloc]init];
//    _numberLabel.font = CHINESE_SYSTEM(12);
//    _numberLabel.text = @"01";
//    _numberLabel.textColor = [UIColor whiteColor];
//    [_tipsImageV addSubview:_numberLabel];
    
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
    
    
    _totalScoreTextField = [[ZLPlaceholderTextView alloc]init];
//    _totalScoreTextField.placeholder = @"请输入分值";
    
    _totalScoreTextField.placeholder = @"请输入分值";
    _totalScoreTextField.placeholderColor = [UIColor lightGrayColor];
    _totalScoreTextField.scrollEnabled = NO;
    _totalScoreTextField.delegate = self;
    _totalScoreTextField.font = CHINESE_SYSTEM(12);
    _totalScoreTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    _totalScoreTextField.textContainerInset = UIEdgeInsetsMake(0,0, 0, 0);
    
    [self.contentView addSubview:_totalScoreTextField];
    
    
//    [_tipsImageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView.mas_right).offset(0);
//        make.top.equalTo(self.contentView).offset(0);
//    }];
//
//
//    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.tipsImageV).offset(5);
//        make.right.equalTo(self.tipsImageV.mas_right).offset(-5);
//    }];
    
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        //        make.top.equalTo(self.contentView).offset(5);
//        make.right.equalTo(_tipsImageV.mas_left).offset(-5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
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
        make.width.mas_equalTo(80);
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

- (void)setDetailModel:(ZLGetScoreDetailModel *)detailModel{
    
    _detailModel = detailModel;
    
    self.title.text = detailModel.quotaName;
    
    if (detailModel.content == nil) {
        
        detailModel.content = @"";
        
    }
    
    self.descriptionLabel.text = detailModel.content;
    
    if (detailModel.score == nil) {
        
        detailModel.score = @"";
        
    }
    
    self.score.text = [NSString stringWithFormat:@"%@分数",detailModel.score];
    
     self.totalScoreTextField.text = detailModel.selfComment;
    
//    if (![self.status isEqualToString:@"0"]) {
//
//        self.totalScoreTextField.text = detailModel.selfComment;
//
//    }else if([self.status isEqualToString:@"0"]) {
//        detailModel.selfComment = nil;
//        self.totalScoreTextField.text = nil;
//
//    }
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    NSInteger score = [self.score.text integerValue];
    
    if (textView == self.totalScoreTextField) {
        
        NSString *total = [NSString stringWithFormat:@"%@%@",textView.text, text];
        
        if ([total floatValue] == score) {
            
            if ([text isEqualToString:@""]) {
                
                return YES;
                
            }
            
            if ([text isEqualToString:@"."]) {
                
                return NO;
                
            }
        }else if ([total floatValue] > score && ![text isEqualToString:@""]) {
            
            return NO;
            
        }
        
        if ([textView.text rangeOfString:@"."].location==NSNotFound) {
            
            _isHaveDian = NO;
            
        }
        
        if ([textView.text rangeOfString:@"0"].location==NSNotFound) {
            
            _isFirstZero = NO;
            
        }
        
        
        
        if ([text length]>0)
            
        {
            
            unichar single=[text characterAtIndex:0];//当前输入的字符
            
            if ((single >='0' && single<='9') || single=='.')//数据格式正确
                
            {
                
                
                
                if([textView.text length]==0){
                    
                    if(single == '.'){
                        
                        //首字母不能为小数点
                        
                        return NO;
                        
                    }
                    
                    if (single == '0') {
                        
                        _isFirstZero = YES;
                        
                        return YES;
                        
                    }
                    
                }
                
                
                
                if (single=='.'){
                    
                    if(!_isHaveDian)//text中还没有小数点
                        
                    {
                        
                        _isHaveDian=YES;
                        
                        return YES;
                        
                    }else{
                        
                        return NO;
                        
                    }
                    
                }else if(single=='0'){
                    
                    if ((_isFirstZero&&_isHaveDian)||(!_isFirstZero&&_isHaveDian)) {
                        
                        //首位有0有.（0.01）或首位没0有.（10200.00）可输入两位数的0
                        
                        if([textView.text isEqualToString:@"0.0"]){
                            
                            return NO;
                            
                        }
                        
                        NSRange ran=[textView.text rangeOfString:@"."];
                        
                        int tt=(int)(range.location-ran.location);
                        
                        if (tt <= 2){
                            
                            return YES;
                            
                        }else{
                            
                            return NO;
                            
                        }
                        
                    }else if (_isFirstZero&&!_isHaveDian){
                        
                        //首位有0没.不能再输入0
                        
                        return NO;
                        
                    }else{
                        
                        return YES;
                        
                    }
                    
                }else{
                    
                    if (_isHaveDian){
                        
                        //存在小数点，保留两位小数
                        
                        NSRange ran=[textView.text rangeOfString:@"."];
                        
                        int tt= (int)(range.location-ran.location);
                        
                        if (tt <= 2){
                            
                            return YES;
                            
                        }else{
                            
                            return NO;
                            
                        }
                        
                    }else if(_isFirstZero&&!_isHaveDian){
                        
                        //首位有0没点
                        
                        return NO;
                        
                    }else{
                        
                        return YES;
                        
                    }
                    
                }
                
            }else{
                
                //输入的数据格式不正确
                
                return NO;
                
            }
            
        }else{
            
            return YES;
            
        }
        
    }
    
    
    
    
    return YES;

}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (_scroeInputBlock) {
        self.scroeInputBlock(textView.text);
        
    }

}



@end
