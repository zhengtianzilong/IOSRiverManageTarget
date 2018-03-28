//
//  ZLMyScrollView.m
//  SmartGas
//
//  Created by caizilong on 16/6/15.
//  Copyright © 2016年 caizilong. All rights reserved.
//

#import "ZLMyScrollView.h"

@implementation ZLMyScrollView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer.state != 0) {
        return YES;
    } else {
        return NO;
    }
}
@end
