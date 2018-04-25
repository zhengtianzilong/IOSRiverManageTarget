//
//  ZLSimpleMainTapBarVCConfig.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/9.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLSimpleMainTapBarVCConfig.h"
#import "ZLBaseNavViewController.h"

#import "ZLSimpleHomeMainVC.h"
#import "ZLPolicyVC.h"

#import "ZLMyVC.h"

@interface ZLSimpleMainTapBarVCConfig ()

@property (nonatomic, strong,readwrite)CYLTabBarController *tabBarController;

@end

@implementation ZLSimpleMainTapBarVCConfig

- (CYLTabBarController *)tabBarController{
    
    if (_tabBarController == nil) {
        
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        
        
        _tabBarController = tabBarController;
        
        
        _tabBarController.delegate = self;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers{
    ZLSimpleHomeMainVC *firstViewController = [[ZLSimpleHomeMainVC alloc] init];
    UIViewController *firstNavigationController = [[ZLBaseNavViewController alloc]
                                                   initWithRootViewController:firstViewController];
    
    ZLPolicyVC *secondViewController = [[ZLPolicyVC alloc] init];
    UIViewController *secondNavigationController = [[ZLBaseNavViewController alloc]
                                                    initWithRootViewController:secondViewController];
    
    
    ZLMyVC *thirdViewController = [[ZLMyVC alloc] init];
    UIViewController *thirdNavigationController = [[ZLBaseNavViewController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    
    NSArray *viewControllers = @[firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,];
    
    return viewControllers;
    
}

- (NSArray *)tabBarItemsAttributesForController{
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"tabbar_home",
                                                 CYLTabBarItemSelectedImage : @"tabbar_home_selected",
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"河湖信息",
                                                  CYLTabBarItemImage : @"tabbar_policy",
                                                  CYLTabBarItemSelectedImage : @"tabbar_policy_selected",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"我的",
                                                 CYLTabBarItemImage : @"tabbar_my",
                                                 CYLTabBarItemSelectedImage : @"tabbar_my_selected",
                                                 };
    
    
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       ];
    return tabBarItemsAttributes;
    
    
}
@end
