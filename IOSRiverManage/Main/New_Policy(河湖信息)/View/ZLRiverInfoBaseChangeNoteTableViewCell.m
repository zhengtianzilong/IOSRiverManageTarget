//
//  ZLRiverInfoBaseChangeNoteTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/9.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverInfoBaseChangeNoteTableViewCell.h"

@interface ZLRiverInfoBaseChangeNoteTableViewCell()<UITextViewDelegate>

@property (nonatomic, strong) UIView *bgView;

@end

@implementation ZLRiverInfoBaseChangeNoteTableViewCell
- (void)dealloc {
    
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
        
    }
    return self;
    
}


- (void)textViewDidChange:(UITextView *)textView
{
    CGRect bounds = textView.bounds;
    // 计算 text view 的高度
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    bounds.size = newSize;
    textView.bounds = bounds;
    // 让 table view 重新计算高度
    UITableView *tableView = [self tableView];
    
    [tableView beginUpdates];
    [tableView endUpdates];
    
    if (_getText) {
        self.getText(textView.text, textView.tag);
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    
    
}

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}
- (void)setupUI{
    
    [self.contentView  addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.infoTextView];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(Main_Screen_Width - 20);
        make.top.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(30);
        
    }];
    [self.infoTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.height.mas_greaterThanOrEqualTo(100);
        
        make.bottom.equalTo(self.contentView.mas_bottom);
        
    }];
    
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"XXXXX";
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = CHINESE_SYSTEM(13);
        
    }
    return _titleLabel;
}

- (UITextView *)infoTextView{
    if (!_infoTextView) {
        _infoTextView = [[UITextView alloc]init];
        _infoTextView.backgroundColor = [UIColor whiteColor];
        
        _infoTextView.font = CHINESE_SYSTEM(13);
        _infoTextView.zw_limitCount = 140;
        //设置整个控件文字的上下距离
//        _infoTextView.textContainerInset = UIEdgeInsetsMake(5, 0, 5, 0);
        
        _infoTextView.textContainerInset = UIEdgeInsetsMake((45 - 21)/2.0,0, (45 - 21)/2.0, 0);
        
        _infoTextView.scrollEnabled = NO;
        [_infoTextView scrollRangeToVisible:_infoTextView.selectedRange];
        _infoTextView.scrollEnabled = NO;
        _infoTextView.delegate = self;
        
    }
    return _infoTextView;
}


@end
