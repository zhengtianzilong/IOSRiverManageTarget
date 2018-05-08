//
//  AppDelegate.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/13.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloatingWindow.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong ,nonatomic) FloatingWindow *floatWindow;

@property (nonatomic, strong) NSDictionary *userInfo;

@end

