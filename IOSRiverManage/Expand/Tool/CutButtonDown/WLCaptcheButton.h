//
//  WLCaptcheButton.h
//  WLButtonCountingDownDemo
//
//  Created by wayne on 16/1/14.
//  Copyright © 2016年 ZHWAYNE. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE
@interface WLCaptcheButton : UIButton

@property (nonatomic, copy)  NSString *identifyKey;
@property (nonatomic, strong)  UIColor *disabledBackgroundColor;
@property (nonatomic, strong)  UIColor *disabledTitleColor;

- (void)fire;

@end
