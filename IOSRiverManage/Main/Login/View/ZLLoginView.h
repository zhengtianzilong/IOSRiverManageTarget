//
//  ZLLoginView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/15.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZLLoginTextFieldView.h"

//#import "LVTextFiled.h"
@interface ZLLoginView : UIView

@property (nonatomic, strong)UIButton *loginBtn;
//@property(nonatomic,strong)LVTextFiled *nameFiled;
//@property(nonatomic,strong)LVTextFiled *passwordFiled;

@property (nonatomic, strong) ZLLoginTextFieldView *nameFiledView;

@property (nonatomic, strong) ZLLoginTextFieldView *passwordFiledView;

@end
