//
//  UIFont+ZLFontPXAndPT.m
//  AIProduct
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIFont+ZLFontPXAndPT.h"
@implementation UIFont (ZLFontPXAndPT)

//+ (void)load{
//    Method systimeFont = class_getClassMethod(self, @selector(systemFontOfSize:));
// 
//    Method qsh_systimeFont = class_getClassMethod(self, @selector(qsh_systimeFont:));
//    
//    method_exchangeImplementations(qsh_systimeFont, systimeFont);
//    
//}

//PX转化为UIFont字号
+(UIFont *)pxSizeConvert:(CGFloat)pxSize{
    NSNumber *iosFontSize = [NSNumber numberWithFloat:pxSize/96*72];
    CGFloat size = [iosFontSize floatValue];
    
    UIFont *font = [UIFont systemFontOfSize:size];
    
    return font;
}

//+(UIFont *)qsh_systimeFont:(CGFloat)pxSize{
//    
//    CGFloat pt = (pxSize / 96) * 72;
//    UIFont *font = [UIFont qsh_systimeFont:pt];
//    
//    return  font;
//    
//    
//}

@end
