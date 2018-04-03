//
//  AppDelegate.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/13.
//  Copyright © 2017年 caizilong. All rights reserved.
//
#import "AppDelegate.h"
#import "ZLLoginViewController.h"
#import "ZLBaseNavViewController.h"
#import "ZLMainTabBarControllerConfig.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>
#import "ZLBadgeZeroService.h"
#import <FLEX/FLEX.h>
#import "XGPush.h"
#import "ZLHomeWebViewViewController.h"

#import "ZLLoginVC.h"

#import <AMapFoundationKit/AMapFoundationKit.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<UITabBarControllerDelegate, CYLTabBarControllerDelegate,BMKGeneralDelegate,XGPushDelegate,XGPushTokenManagerDelegate>

@property (nonatomic, strong) YTKKeyValueStore *store;

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.floatWindow = [[FloatingWindow alloc] initWithFrame:CGRectMake(0, Main_Screen_Height, 0, 0) imageName:@"av_call"];
    [self.floatWindow makeKeyAndVisible];
    self.floatWindow.hidden = YES;
    
    [self configBaiDuSDK];
    // 配置信鸽
    [self xgConfigWithOptions:launchOptions];
    
    [self configPGYSDK];
    
    [self configureBoardManager];
    
    [self configGaoDeSDK];
    
    // 应用不在后台时,收到的推送
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    [self setupLoginViewControllerWithUserInfo:userInfo];
    
    [self customizeTabbarItem];
    
    [[FLEXManager sharedManager] showExplorer];
    
    
    
    return YES;
}

- (void)configPGYSDK {
    [[PgyManager sharedPgyManager] startManagerWithAppId:@"f06f925116be13fb5d740af0ff399b46"];
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:@"f06f925116be13fb5d740af0ff399b46"];
    
    [[PgyUpdateManager sharedPgyManager] checkUpdate];
    [[PgyManager sharedPgyManager] setEnableFeedback:NO];
}

- (void)configBaiDuSDK {
    BMKMapManager *manager = [[BMKMapManager alloc]init];
//    qzRihoClqkXkLMISsEjBBYed6n7ZUHOH
    
#ifdef TouBiao
    BOOL success = [manager start:@"qzRihoClqkXkLMISsEjBBYed6n7ZUHOH" generalDelegate:nil];
#else
    BOOL success = [manager start:kBaiduMapKey generalDelegate:nil];
#endif
    
    
    if (!success) {
        
        ZLLog(@"百度地图启动失败");
    }
}


- (void)configGaoDeSDK{
    [AMapServices sharedServices].apiKey = @"633d6913a686092e161c8fe6ad5cafa0";
    
}

#pragma mark -- 百度代理
- (void)onGetNetworkState:(int)iError{
    
    ZLLog(@"NetworkState:%d",iError);
    
}

- (void)onGetPermissionState:(int)iError{
    ZLLog(@"GetPermissionState:%d",iError);
}

//CLUB-Q2QX-2CP6-PY4G-VU2H
/**
 配置信鸽
 */
- (void)xgConfigWithOptions:(NSDictionary *)launchOptions{
    // 打开debug开关
    [[XGPush defaultManager]setEnableDebug:YES];
    // 查看debug开发是否打开
    BOOL debugEnabled = [[XGPush defaultManager]isEnableDebug];
    ZLLog(@"debugEnabled%d",debugEnabled);
    // 开始推送 2200269075
    [[XGPush defaultManager]startXGWithAppID:2200269075 appKey:@"I2Q55UXZ2D5E" delegate:self];
    
    // 上报数据
    [[XGPush defaultManager]reportXGNotificationInfo:launchOptions];
    [XGPushTokenManager defaultTokenManager].delegatge = self;
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    [[XGPush defaultManager]reportXGNotificationInfo:userInfo];
    
}



#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    [[XGPush defaultManager]reportXGNotificationInfo:notification.request.content.userInfo];
    completionHandler(UNNotificationPresentationOptionBadge |
                      UNNotificationPresentationOptionSound |
                      UNNotificationPresentationOptionAlert);
    
}


/**
 收到远程的推送

 */
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    
    [[XGPush defaultManager]reportXGNotificationInfo:response.notification.request.content.userInfo];
//    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:ULoginModel];
//    ZLLoginModel *loginModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    if (loginModel.ret_data.length > 0) {
//        loginModel.ret_data = [NSString stringWithFormat:@"%@/hzz/phoneController.do?supervise",Base_URL];
//    }
//
//    if (response.notification.request.content.userInfo != nil && loginModel.ret_data.length > 0) {
//        [self pushLoginOrWebWithUserInfo:response.notification.request.content.userInfo loginModel:loginModel];
//    }
    completionHandler();
    
    
}

#endif


/**
 自定义tabbaritem的样式
 */
- (void)customizeTabbarItem{
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = HEXCOLOR(0x11ccf9);
    
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = HEXCOLOR(0xa5a5a5);

    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    UITabBar *tabBar = [UITabBar appearance];
    
    [tabBar setBarTintColor:[UIColor whiteColor]];
    tabBar.translucent = NO;
    
    [tabBar setShadowImage:[self imageWithColor:HEXCOLORAndAlpha(0x11ccf9, 0.2) size:CGSizeMake(Main_Screen_Width,0.5)]];
    [tabBar setBackgroundImage:[[UIImage alloc]init]];
    
    [tabBarItem setTitleTextAttributes:selectedAttrs forState:(UIControlStateSelected)];
    
    
    [tabBarItem setTitleTextAttributes:normalAttrs forState:(UIControlStateNormal)];
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
        if (!color || size.width <=0 || size.height <=0) return nil;
        CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
        UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
        CGContextRef context =UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
}

#pragma mark 键盘收回管理
-(void)configureBoardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.keyboardDistanceFromTextField=20;
    manager.enableAutoToolbar = NO;
}

- (NSInteger)getDifferenceByDate:(NSString *)date {
    //获得当前时间
    NSDate *now = [NSDate date];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *oldDate = [dateFormatter dateFromString:date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:oldDate  toDate:now  options:0];
    return [comps day];
}

#pragma mark 自定义跳转不同的页面
//登录页面
-(void)setupLoginViewControllerWithUserInfo:(NSDictionary *)userInfo
{
    
    self.store = [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
    
    NSString *tableName = DBUserTable;
    
    [self.store createTableWithName:tableName];
    
    NSString *tokenCreateTime = [self.store getStringById:DBLoginTokenCreateTime fromTable:DBUserTable];
    
    
    ZLLoginVC *logInVc = [[ZLLoginVC alloc]init];
    
//    ZLBaseNavViewController *loginNav = [[ZLBaseNavViewController alloc]initWithRootViewController:logInVc];
    
    ZLMainTabBarControllerConfig *tabBarVCConfig = [[ZLMainTabBarControllerConfig alloc]init];
    
    CYLTabBarController *tabBarVC = tabBarVCConfig.tabBarController;
    tabBarVC.delegate = self;
    if (tokenCreateTime.length > 0) {
         NSInteger day = [self getDifferenceByDate:tokenCreateTime];
        
        if (day > 10) {
            self.window.rootViewController = logInVc;
        }else{
            
            self.window.rootViewController = tabBarVC;
        }
        
    }else{
        self.window.rootViewController = logInVc;
    }
    
   
    
    
    


    
//    if (userInfo != nil) {
//        logInVc.userInfo = userInfo;
//    }else{
//        logInVc.userInfo = nil;
//    }
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

//// 点击推送跳转
//- (void)pushLoginOrWebWithUserInfo:(NSDictionary *)userInfo loginModel:(ZLLoginModel *)loginModel{
//
//    ZLHomeWebViewViewController *webVC = [[ZLHomeWebViewViewController alloc]init];
//    
//    webVC.loginModel = loginModel;
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:webVC];
//    nav.interactivePopGestureRecognizer.enabled = NO;
//    self.window.rootViewController = nav;
//}


#pragma mark - TabBardelegate
// 点击TabBar的代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    ZLLog(@"你点击了%lu",(unsigned long)tabBarController.selectedIndex);
    
}

#pragma mark - XGPushDelegate
/**
 开始服务
 */
- (void)xgPushDidFinishStart:(BOOL)isSuccess error:(NSError *)error{
    ZLLog(@"%s, result %@, error %@", __FUNCTION__, isSuccess?@"OK":@"NO", error);
    
}

/**
 停止服务
 */
- (void)xgPushDidFinishStop:(BOOL)isSuccess error:(NSError *)error{
    ZLLog(@"%s, result %@, error %@", __FUNCTION__, isSuccess?@"OK":@"NO", error);

}

/**
 监控信鸽服务上报推送消息的情况
 */
- (void)xgPushDidReportNotification:(BOOL)isSuccess error:(NSError *)error{
    ZLLog(@"%s, result %@, error %@", __FUNCTION__, isSuccess?@"OK":@"NO", error);

}

//http://192.168.0.250:18081/hzz/phoneController.do?home&token=HZZUSER-0aa537e7ec784d9abbff53cbe6b3d574-cas
/**
 监控token对象绑定的情况

 @param identifier token对象绑定的标识
 @param type 对象绑定的类型
 @param error 错误
 */
- (void)xgPushDidBindWithIdentifier:(NSString *)identifier type:(XGPushTokenBindType)type error:(NSError *)error{
    
    ZLLog(@"DidBindWithIdentifier %@",error );
    
}


/**
 监控token对象解绑的情况

 @param identifier token对象绑定的标识
 @param type 对象绑定的类型
 @param error error 错误
 */
- (void)xgPushDidUnbindWithIdentifier:(NSString *)identifier type:(XGPushTokenBindType)type error:(NSError *)error{
     ZLLog(@"UnbindWithIdentifier %@",error);
}

// 调用注册设备token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
//    a542c8524356c3d089986dc8bed00415afc5454c25cbf6763a79baf2c89b6ee9
    [[XGPushTokenManager defaultTokenManager]registerDeviceToken:deviceToken];
    
    
    // 绑定标签和账号
//    [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:@"your tag"
//                                                            type:XGPushTokenBindTypeTag];
//    
//    [[XGPushTokenManager defaultTokenManager] unbindWithIdentifer:@"your tag"
//                                                             type:XGPushTokenBindTypeTag];
//    
//    [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:@"youraccount" type:XGPushTokenBindTypeAccount];
//     
//     [[XGPushTokenManager defaultTokenManager] unbindWithIdentifer:@"youraccount" type:XGPushTokenBindTypeAccount];
    
    
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
//    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:ULoginModel];
//    ZLLoginModel *loginModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    // 说明是登录过的 在首页里的
//    if (application.applicationIconBadgeNumber > 0 && loginModel.userId.length > 0) {
//        
//        ZLBadgeZeroService *service = [[ZLBadgeZeroService alloc]initWithUid:loginModel.userId];
//        [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//            NSDictionary *dic = request.responseObject;
//            if ([dic[@"code"] isEqualToString:@"0"]) {
//                [application setApplicationIconBadgeNumber:0];
//            }
//            
//        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//            
//        }];
//    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    
}

@end
