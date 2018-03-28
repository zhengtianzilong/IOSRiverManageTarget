//
//  ZLBaseNavViewController.m
//  AIProduct
//
//  Created by mac on 2017/8/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ZLBaseNavViewController.h"

@interface ZLBaseNavViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIViewController *currentShowVC;


@end

@implementation ZLBaseNavViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    
    ZLBaseNavViewController *nvc = [super initWithRootViewController:rootViewController];
    
    self.interactivePopGestureRecognizer.delegate = self;
    nvc.delegate = self;
    return nvc;
    
    
}
//这个方法是在手势将要激活前调用：返回YES允许侧滑手势的激活，返回NO不允许侧滑手势的激活
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    return NO;
    
//    //首先在这确定是不是我们需要管理的侧滑返回手势
//    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
//        if (self.currentShowVC == self.topViewController) {
//            //如果 currentShowVC 存在说明堆栈内的控制器数量大于 1 ，允许激活侧滑手势
//            return YES;
//        }
//        //如果 currentShowVC 不存在，禁用侧滑手势。如果在根控制器中不禁用侧滑手势，而且不小心触发了侧滑手势，会导致存放控制器的堆栈混乱，直接的效果就是你发现你的应用假死了，点哪都没反应，感兴趣是神马效果的朋友可以自己试试 = =。
//        return NO;
//    }
//    
//    //这里就是非侧滑手势调用的方法啦，统一允许激活
//    return YES;
}


- (UIGestureRecognizer *)interactivePopGestureRecognizer{
    
    return nil;
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    
}

//获取侧滑返回手势
- (UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer
{
    UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = nil;
    if (self.view.gestureRecognizers.count > 0)
    {
        for (UIGestureRecognizer *recognizer in self.view.gestureRecognizers)
        {
            if ([recognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
            {
                screenEdgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)recognizer;
                break;
            }
        }
    }
    return screenEdgePanGestureRecognizer;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        //第二级则隐藏底部Tab
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
