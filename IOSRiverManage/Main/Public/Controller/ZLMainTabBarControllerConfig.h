//
//  ZLMainTabBarControllerConfig.h
//  AIProduct
//
//  Created by mac on 2017/8/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLTabBarController.h"
@interface ZLMainTabBarControllerConfig : NSObject<UITabBarControllerDelegate>

@property (nonatomic, strong,readonly) CYLTabBarController *tabBarController;

@end
