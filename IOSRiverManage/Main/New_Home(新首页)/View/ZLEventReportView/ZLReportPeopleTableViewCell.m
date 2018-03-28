//
//  ZLReportPeopleTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/17.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLReportPeopleTableViewCell.h"
@interface ZLReportPeopleTableViewCell()<UITextViewDelegate>

//@property (nonatomic, strong) UIView *bgView;

@end

@implementation ZLReportPeopleTableViewCell
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

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}
- (void)setupUI{
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.infoTextView];
    [self.contentView addSubview:self.imageV];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(90);
//        make.right.equalTo(self.bgView.mas_right);
                make.top.equalTo(self.contentView).offset(10);
//        make.centerY.equalTo(self.bgView);
        make.height.mas_equalTo(45);
        
    }];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.mas_equalTo(25);
        //        make.right.equalTo(self.bgView.mas_right);
        make.centerY.equalTo(self.contentView);
        //        make.centerY.equalTo(self.bgView);
        make.height.mas_equalTo(25);
        
    }];
    
    [self.infoTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel.mas_right);
        make.right.equalTo(self.imageV.mas_left);
        make.top.equalTo(self.titleLabel);
        make.height.mas_greaterThanOrEqualTo(45);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
    }];
    

    
}

- (void)tapClick{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    if (_selectInfo) {
        
        self.selectInfo(self.infoTextView);
        
    }
    
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"所在区县:";
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = CHINESE_SYSTEM(17);
        
    }
    return _titleLabel;
}

- (UITextView *)infoTextView{
    
    if (!_infoTextView) {
        _infoTextView = [[UITextView alloc]init];
        
        _infoTextView.font = CHINESE_SYSTEM(17);
        _infoTextView.editable = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
//        _infoTextView addPlaceHolder:@""
        [_infoTextView addGestureRecognizer:tap];
        _infoTextView.delegate = self;
        _infoTextView.scrollEnabled = NO;
//        [_infoTextView addTarget:self action:@selector(tapClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        
    }
    return  _infoTextView;
}

- (UIImageView *)imageV{
    
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
    }
    
    return _imageV;
    
    
}

@end
