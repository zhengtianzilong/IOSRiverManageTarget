//
//  ZLEventReportSubView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/20.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ZLEventReportSubView : UIView

//@property (nonatomic, strong) UITextField *eventTextfiled;

@property (nonatomic, strong) UITextField *eventTextfiled;

@property (nonatomic, strong)  UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UIView *lineView;


- (instancetype)initWithName:(NSString *)name placeHolder:(NSString *)placeHolder haveButton:(BOOL)haveButto;
@end

