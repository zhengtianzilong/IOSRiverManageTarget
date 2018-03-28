//
//  FloatingWindow.h
//  FloatingWindwoAmination
//
//  Created by huangzengquan on 16/5/25.
//  Copyright © 2016年 huangzengquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLBaseCustomNavViewController.h"

@protocol FloatingWindowTouchDelegate <NSObject>
//悬浮窗点击事件
- (void)assistiveTocuhs;
@end

@interface FloatingWindow : UIWindow

@property(nonatomic ,assign) NSInteger time;
@property(nonatomic ,assign) BOOL isShowMenu;
@property(nonatomic ,strong) UIImage *showImage;
@property(nonatomic ,strong) UIImageView *showImageView;
@property(nonatomic ,assign) CGRect startFrame;
@property(nonatomic ,assign) BOOL isCannotTouch;
@property (nonatomic ,strong) UIView *presentView;

@property(nonatomic ,strong)id<FloatingWindowTouchDelegate> floatDelegate;

- (id)initWithFrame:(CGRect)frame imageName:(NSString*)name;
- (void)close;
- (void)startWithTime:(NSInteger)time presentview:(UIView *)presentView inRect:(CGRect)rect withRiverTitle:(NSString *)riverTitle;
//- (void)startWithTime:(NSInteger)time presentview:(UIView *)presentView inRect:(CGRect)rect root:(ZLBaseCustomNavViewController *)root;
- (UIImage *)clipcircleImageFromView:(UIView *)view inRect:(CGRect)frame;
- (void)click:(UITapGestureRecognizer*)t;
@end




