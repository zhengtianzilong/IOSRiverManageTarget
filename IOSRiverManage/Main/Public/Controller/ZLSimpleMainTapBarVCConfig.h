//
//  ZLSimpleMainTapBarVCConfig.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/9.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLTabBarController.h"
@interface ZLSimpleMainTapBarVCConfig : NSObject<UITabBarControllerDelegate>

@property (nonatomic, strong,readonly) CYLTabBarController *tabBarController;


@end
