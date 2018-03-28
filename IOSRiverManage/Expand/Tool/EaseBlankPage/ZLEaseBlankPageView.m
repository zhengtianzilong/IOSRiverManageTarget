//
//  ZLEaseBlankPageView.m
//  AIProduct
//
//  Created by mac on 2017/8/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ZLEaseBlankPageView.h"

@implementation ZLEaseBlankPageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// 配置页面
- (void)configWith:(EaseBlankPageType)blankPageType
           hasData:(BOOL)hasData hasError:(BOOL)hasError
         tipsTitle:(NSString *)tipsTitle
         nameImage:(NSString *)nameImage
 reloadButtonBlock:(void(^)(id sender))block{
    
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    self.alpha = 1.0;
    
    // 图片
    if (!_tipsImageView) {
        _tipsImageView = [[UIImageView alloc]init];
        [self addSubview:_tipsImageView];
    }
    
    // 文字
    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = AdaptedFontSize(24);
        _tipLabel.textColor = HEXCOLORAndAlpha(0x11ccf9, 0.65);
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
        
    }
    
    // 布局
    [_tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_top).with.offset(AdaptedHeight(118));
        
    }];
    
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.centerX.equalTo(self);
        make.top.equalTo(_tipsImageView.mas_bottom).offset(AdaptedHeight(25));
        make.height.mas_equalTo(AdaptedHeight(50));
        
    }];
    
    _reloadButtonBlock = nil;
    
    if (!_reloadButton) {
        
        _reloadButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_reloadButton setImage:[UIImage imageNamed:@"blankpage_button_reload"] forState:(UIControlStateNormal)];
        
        _reloadButton.adjustsImageWhenHighlighted = YES;
        [_reloadButton addTarget:self action:@selector(reloadButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self addSubview:_reloadButton];
        
        [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(self);
            make.top.equalTo(_tipLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(130, 40));
            
        }];
       
        
    }
    _reloadButton.hidden = NO;
    _reloadButtonBlock = block;
    
    if (hasError) {
        
        [_tipsImageView setImage:[UIImage imageNamed:@"blankpage_image_loadFail"]];
        _tipLabel.text = @"貌似出了点错误";
        if (blankPageType == EaseBlankPageTypeMaterialScheduling) {
            
            _reloadButton.hidden = YES;
            
        }
        
    }else{
        // 空白数据
        if (_reloadButton) {
            _reloadButton.hidden = NO;
        }
        NSString *imageName,*tipStr;
        switch (blankPageType) {
            case EaseBlankPageTypeProject:
            {
                imageName = nameImage;
                tipStr = tipsTitle;
            }
                break;
            case EaseBlankPageTypeNoButton:
            {
                _reloadButton.hidden = YES;
                imageName = nameImage;
                tipStr = tipsTitle;
            }
                break;
            default://其它页面（这里没有提到的页面，都属于其它）
            {
                imageName = nameImage;
                tipStr = tipsTitle;
            }
                break;

        }
        
        [_tipsImageView setImage:[UIImage imageNamed:imageName]];
        _tipLabel.text = tipStr;
        
    }
    
}


/**
 按钮点击事件
 */
- (void)reloadButtonClick:(UIButton *)sender{
    
    self.hidden = YES;
    [self removeFromSuperview];
    // 延迟0.2秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // block回调
        if (_reloadButtonBlock) {
            
            _reloadButtonBlock(sender);
            
        }
        
    });
    
}

@end
