//
//  UIView+ZLEaseBlankPage.m
//  AIProduct
//
//  Created by mac on 2017/8/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIView+ZLEaseBlankPage.h"
static char BlankPageViewKey;
@implementation UIView (ZLEaseBlankPage)

- (void)setBlankPageView:(ZLEaseBlankPageView *)blankPageView{
    
    [self willChangeValueForKey:@"BlankPageViewKey"];
    
    objc_setAssociatedObject(self, &BlankPageViewKey, blankPageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"BlankPageViewKey"];
    
}

- (ZLEaseBlankPageView *)blankPageView{
    return  objc_getAssociatedObject(self, &BlankPageViewKey);
}

- (void)configWith:(EaseBlankPageType)blankPageType
           hasData:(BOOL)hasData hasError:(BOOL)hasError
         tipsTitle:(NSString *)tipsTitle
         nameImage:(NSString *)nameImage
 reloadButtonBlock:(void(^)(id sender))block{
    
    if (hasData) {
        if (self.blankPageView) {
            
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
            
        }
    }else{
        if (!self.blankPageView) {
            self.blankPageView = [[ZLEaseBlankPageView alloc]initWithFrame:self.bounds];
        }
        self.blankPageView.hidden = NO;
        [[self blankPageContainer] addSubview:self.blankPageView];
        
        [self.blankPageView configWith:blankPageType hasData:hasData hasError:hasError tipsTitle:tipsTitle nameImage:nameImage reloadButtonBlock:block];
    }
}

- (UIView *)blankPageContainer{
    
    UIView *blankPageContainer = self;
    for (UIView *aView in [self subviews]) {
        
        if ([aView isKindOfClass:[UITableView class]]) {
            blankPageContainer = aView;
            ((UITableView *)blankPageContainer).separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        
    }
    return blankPageContainer;
}

@end
