//
//  ZLEaseBlankPageView.h
//  AIProduct
//
//  Created by mac on 2017/8/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,EaseBlankPageType) {
    
    EaseBlankPageTypeView = 0,
    EaseBlankPageTypeProject,
    EaseBlankPageTypeNoButton,
    EaseBlankPageTypeMaterialScheduling
    
};

@interface ZLEaseBlankPageView : UIView

@property (nonatomic, strong) UIImageView *tipsImageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *reloadButton;
@property (nonatomic, copy) void(^reloadButtonBlock)(id sender);


- (void)configWith:(EaseBlankPageType)blankPageType
           hasData:(BOOL)hasData hasError:(BOOL)hasError
         tipsTitle:(NSString *)tipsTitle
         nameImage:(NSString *)nameImage
 reloadButtonBlock:(void(^)(id sender))block;

@end
