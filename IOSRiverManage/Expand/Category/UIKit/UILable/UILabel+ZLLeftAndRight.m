//
//  UILabel+ZLLeftAndRight.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/27.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "UILabel+ZLLeftAndRight.h"

@implementation UILabel (ZLLeftAndRight)
- (void)changeAlignmentRightandLeft {
    CGRect textSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.font} context:nil];
    CGFloat margin = (self.frame.size.width - textSize.size.width) / (self.text.length - 1);
    NSNumber *number = [NSNumber numberWithFloat:margin];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self.text];
    
    [attributeString addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1)];
    
    self.attributedText = attributeString;
}
@end
