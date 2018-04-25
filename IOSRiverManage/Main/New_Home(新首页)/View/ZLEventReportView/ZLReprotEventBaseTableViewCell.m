//
//  ZLReprotEventBaseTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/17.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLReprotEventBaseTableViewCell.h"
@interface ZLReprotEventBaseTableViewCell()<UITextViewDelegate>

//@property (nonatomic, strong) UIView *bgView;

@end

@implementation ZLReprotEventBaseTableViewCell
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
//    bounds.size = newSize;
    bounds.size =  CGSizeMake(newSize.width, newSize.height);
    textView.bounds = bounds;
    // 让 table view 重新计算高度
    UITableView *tableView = [self tableView];
    
//    if (@available(iOS 11.0, *)) {
//
//        [UIView performWithoutAnimation:^{
//            [tableView performBatchUpdates:nil completion:nil];
//            [textView sizeToFit];
//        }];
//
//    } else {
//        [tableView beginUpdates];
//        [tableView endUpdates];
//    }
    
//    [textView.textContainer setSize:CGSizeMake(newSize.width, newSize.height - 13)];

    
    [textView scrollRangeToVisible:NSMakeRange(0,0)];
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
    
    //    [self.contentView addSubview:self.bgView];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.infoTextView];
    
    //    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.contentView).offset(0);
    //        make.width.mas_equalTo(90);
    //        make.top.equalTo(self.contentView).offset(0);
    //        make.height.mas_equalTo(50);
    //    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(90);
        make.top.equalTo(self.contentView).offset(0);
        //        make.centerY.equalTo(self.bgView);
        make.height.mas_equalTo(45);
        
    }];
    [self.infoTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.titleLabel);
        make.height.mas_greaterThanOrEqualTo(45);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
    }];
    
}

//- (UIView *)bgView{
//
//    if (!_bgView) {
//
//        _bgView = [[UIView alloc]init];
//        _bgView.backgroundColor = [UIColor whiteColor];
//    }
//
//    return _bgView;
//
//}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"XXXXX";
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = Font(13);
        
    }
    return _titleLabel;
}

- (UITextView *)infoTextView{
    if (!_infoTextView) {
        _infoTextView = [[UITextView alloc]init];
        _infoTextView.backgroundColor = [UIColor whiteColor];
        _infoTextView.textContainerInset = UIEdgeInsetsMake(10,0, 10, 0);
        _infoTextView.font = CHINESE_SYSTEM(13);
//        [_infoTextView scrollRangeToVisible:_infoTextView.selectedRange];
        _infoTextView.layoutManager.allowsNonContiguousLayout = NO;
        _infoTextView.scrollEnabled = NO;
        _infoTextView.delegate = self;
        
    }
    return _infoTextView;
}


@end
