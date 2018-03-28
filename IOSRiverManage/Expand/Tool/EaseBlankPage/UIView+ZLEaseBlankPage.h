//
//  UIView+ZLEaseBlankPage.h
//  AIProduct
//
//  Created by mac on 2017/8/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLEaseBlankPageView.h"
@interface UIView (ZLEaseBlankPage)

@property (nonatomic, strong) ZLEaseBlankPageView *blankPageView;

- (void)configWith:(EaseBlankPageType)blankPageType
           hasData:(BOOL)hasData hasError:(BOOL)hasError
         tipsTitle:(NSString *)tipsTitle
         nameImage:(NSString *)nameImage
 reloadButtonBlock:(void(^)(id sender))block;

@end
