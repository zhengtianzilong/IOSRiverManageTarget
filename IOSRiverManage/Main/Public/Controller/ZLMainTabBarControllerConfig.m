//
//  ZLMainTabBarControllerConfig.m
//  AIProduct
//
//  Created by mac on 2017/8/2.
//  Copyright © 2017年 mac. All rights reserved.
//


#import "ZLMainTabBarControllerConfig.h"
#import "ZLBaseNavViewController.h"

#import "ZLHomeMainVC.h"
#import "ZLPolicyVC.h"

#import "ZLMyVC.h"

@interface ZLMainTabBarControllerConfig ()

@property (nonatomic, strong,readwrite)CYLTabBarController *tabBarController;

@end

@implementation ZLMainTabBarControllerConfig

- (CYLTabBarController *)tabBarController{
    
    if (_tabBarController == nil) {
        
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        

        _tabBarController = tabBarController;
        
               
        _tabBarController.delegate = self;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers{
    ZLHomeMainVC *firstViewController = [[ZLHomeMainVC alloc] init];
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
    
#if WanApp
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"海湾信息",
                                                  CYLTabBarItemImage : @"tabbar_policy",
                                                  CYLTabBarItemSelectedImage : @"tabbar_policy_selected",
                                                  };
#else
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"河湖信息",
                                                  CYLTabBarItemImage : @"tabbar_policy",
                                                  CYLTabBarItemSelectedImage : @"tabbar_policy_selected",
                                                  };
    
#endif
    
    
   
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
