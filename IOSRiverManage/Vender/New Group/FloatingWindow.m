//
//  FloatingWindow.m
//  FloatingWindwoAmination
//
//  Created by huangzengquan on 16/5/25.
//  Copyright © 2016年 huangzengquan. All rights reserved.
//
#import "FloatingWindow.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CAAnimation.h>



#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height


static const float timeSplit = 1.f / 3.f;

@interface FloatingWindow () <CAAnimationDelegate>

@property (nonatomic ,strong) UILabel *timeLable;
@property (nonatomic ,strong) NSTimer *timer;
@property (nonatomic ,copy)  NSString *imageNameString;

@property (nonatomic ,strong) CAAnimation *samllAnimation;
@property (nonatomic ,assign) BOOL isExit;
@property (assign ,nonatomic) BOOL timeStart;

@property (nonatomic, strong) NSString *riverTitle;

@end

@implementation FloatingWindow

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame imageName:(NSString *)name
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelAlert + 1;
        
        
        self.rootViewController = [UIViewController new];

//        UIViewController *vc = [UIViewController new];
//
//        vc.view.backgroundColor = [UIColor redColor];
        
//        self.rootViewController = vc;
        
        //添加移动的手势
//        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(locationChange:)];
//        pan.delaysTouchesBegan = YES;
//        [self addGestureRecognizer:pan];
        //添加点击的手势
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
//        [self addGestureRecognizer:tap];
        self.hidden = YES;
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(convStartHere) name:@"FSAVConvStartNotification" object:nil];
        
    }
    return self;
}

#pragma mark--- 开始和结束
- (void)startWithTime:(NSInteger)time presentview:(UIView *)presentView inRect:(CGRect)rect withRiverTitle:(NSString *)riverTitle{
    self.hidden = NO;
    self.startFrame = rect;
//    [self circleSmallerWithView:presentView];
    self.time = time;
    self.presentView = presentView;
    
    self.riverTitle = riverTitle;
    
//    [self.presentView removeFromSuperview];
    [self makeIntoAnimation];
    
    
//    if (self.isExit) {
//        self.isExit = NO;
//        self.presentView.layer.mask = nil;
//        [self.floatDelegate assistiveTocuhs];
//    } else {
//
//    }
    
    
}

- (void)close {
    self.hidden = YES;
    self.presentView = nil;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)start {
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"RunningTime" object:nil userInfo:@{@"riverTitle":self.riverTitle}];
}

#pragma mark ---进去和出去动画
- (void)makeIntoAnimation {
    self.frame = self.startFrame;
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(0, Main_Screen_Height, Main_Screen_Width, Main_Screen_Height);
        self.hidden = YES;
    } completion:^(BOOL finished) {
        [self.presentView removeFromSuperview];
        [self start];

    }];
}


- (void)makeOuttoAnimation {
    self.showImageView.hidden = NO;
//    [self.presentView removeFromSuperview];
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
        [self makeKeyAndVisible];
        self.hidden = NO;
        [self.rootViewController.view addSubview:self.presentView];
    } completion:^(BOOL finished) {
//        [self circleBigger];
        
    }];
}


/**
 * 动画开始时
 */
- (void)animationDidStart:(CAAnimation *)theAnimation
{
    
}


/**
 * 动画结束时
 */
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    if (self.isExit) {
        self.isExit = NO;
        self.presentView.layer.mask = nil;
        [self.floatDelegate assistiveTocuhs];
    } else {
//        self.showImage = [self clipcircleImageFromView:self.presentView inRect:self.startFrame];
        [self.presentView removeFromSuperview];
        [self makeIntoAnimation];
    }
}

- (void)circleSmallerWithView:(UIView *)view {
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    CGRect startFrame = self.startFrame;
//    UIBezierPath *maskStartBP =  [UIBezierPath bezierPathWithOvalInRect:startFrame];
//    CGFloat radius = [UIScreen mainScreen].bounds.size.height - 100;
//    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(startFrame, -radius, -radius)];
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.path = maskStartBP.CGPath;
//    maskLayer.backgroundColor = (__bridge CGColorRef )([UIColor whiteColor]);
//    view.layer.mask = maskLayer;
//    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
//    maskLayerAnimation.fromValue = (__bridge id)(maskFinalBP.CGPath);
//    maskLayerAnimation.toValue = (__bridge id)((maskStartBP.CGPath));
//    maskLayerAnimation.duration = 0.5f;
//    __weak typeof(self) weakSelf = self;
//    maskLayerAnimation.delegate = weakSelf;
//    self.samllAnimation = maskLayerAnimation;
//    //    maskLayerAnimation.fillMode = kCAFillModeForwards;
//    maskLayerAnimation.removedOnCompletion = NO;
    [self addSubview:view];
//    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}



- (void)circleBigger {
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self addSubview:self.presentView];
//    UIBezierPath *maskStartBP =  [UIBezierPath bezierPathWithOvalInRect:self.startFrame];
//    CGFloat radius = [UIScreen mainScreen].bounds.size.height - 100;
//    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.startFrame, -radius, -radius)];
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.path = maskFinalBP.CGPath;
//    maskLayer.backgroundColor = (__bridge CGColorRef)([UIColor whiteColor]);
//    self.presentView.layer.mask = maskLayer;
//    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
//    maskLayerAnimation.fromValue = (__bridge id)(maskStartBP.CGPath);
//    maskLayerAnimation.toValue = (__bridge id)((maskFinalBP.CGPath));
//    maskLayerAnimation.duration = 0.5f;
//    __weak typeof(self) weakSelf = self;
//    maskLayerAnimation.delegate = weakSelf;
//    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}
- (UIViewController *)theTopviewControler{
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    
    UIViewController *parent = rootVC;
    
    while ((parent = rootVC.presentedViewController) != nil ) {
        rootVC = parent;
    }
    
    while ([rootVC isKindOfClass:[UINavigationController class]]) {
        rootVC = [(UINavigationController *)rootVC topViewController];
    }
    
    return rootVC;
}


- (void)click:(UITapGestureRecognizer*)t
{
    if (self.isCannotTouch) {
        return;
    }
    self.isExit = YES;
    [self makeOuttoAnimation];
    
}



@end
