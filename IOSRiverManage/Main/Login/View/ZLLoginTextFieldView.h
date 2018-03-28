//
//  ZLLoginTextFieldView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/23.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLLoginTextFieldView : UIView

@property (nonatomic, strong) UITextField *loginTextField;

-(instancetype)initWithImage:(NSString *)img holdStr:(NSString *)holderStr;

@end
