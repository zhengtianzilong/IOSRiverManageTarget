//
//  AppDelegate.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/13.
//  Copyright © 2017年 caizilong. All rights reserved.
//
#import "AppDelegate.h"
#import "ZLBaseNavViewController.h"
#import "ZLMainTabBarControllerConfig.h"
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>
#import "ZLBadgeZeroService.h"
//#import <FLEX/FLEX.h>
#import "XGPush.h"
#import "ZLNewLoginModel.h"
#import "ZLLoginVC.h"
#import "ZLMyEventDetailVC.h"
#import "ZLTaskDetailVC.h"
#import "ZLSimpleMainTapBarVCConfig.h"
#import "ZLOverSeeDetailVC.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<UITabBarControllerDelegate, CYLTabBarControllerDelegate,XGPushDelegate,XGPushTokenManagerDelegate, UNUserNotificationCenterDelegate,GeTuiSdkDelegate>

@property (nonatomic, strong) YTKKeyValueStore *store;

@property (nonatomic, strong) ZLNewLoginModel *loginModel;

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.floatWindow = [[FloatingWindow alloc] initWithFrame:CGRectMake(0, Main_Screen_Height, 0, 0) imageName:@"av_call"];
    [self.floatWindow makeKeyAndVisible];
    self.floatWindow.hidden = YES;
    
    [self configGeiTui];
    

    [self configPGYSDK];
    
    [self configureBoardManager];
    
    [self configGaoDeSDK];
    
    [self customizeTabbarItem];
//    [[FLEXManager sharedManager] showExplorer];
    

    // 应用不在后台时,收到的推送
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    [self setupLoginViewControllerWithUserInfo:userInfo];
    if (userInfo) {
        self.userInfo = userInfo;
    }
    
    
    return YES;
}

- (void)configPGYSDK {
    [[PgyManager sharedPgyManager] startManagerWithAppId:kPgyKey];
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:kPgyKey];
    
    [[PgyUpdateManager sharedPgyManager] checkUpdate];
    [[PgyManager sharedPgyManager] setEnableFeedback:NO];
}



- (void)configGaoDeSDK{
    [AMapServices sharedServices].apiKey = kGaodeMapKey;
    
}

/**
 配置个推
 */
- (void)configGeiTui{
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    
    [self registerRemoteNotification];
    [self registLocationNotification];
}

#pragma mark注册本地通知
-(void)registLocationNotification
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0){
        // 使用 UNUserNotificationCenter 来管理通知
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        //监听回调事件
        center.delegate = self;
        
        //iOS 10 使用以下方法注册，才能得到授权
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  // Enable or disable features based on authorization.
                              }];
        
        //获取当前的通知设置，UNNotificationSettings 是只读对象，不能直接修改，只能通过以下方法获取
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            
        }];
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0&&[[UIDevice currentDevice].systemVersion floatValue] < 10.0){
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }
    }
}


- (void)registerRemoteNotification{
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge |UNAuthorizationOptionSound|UNAuthorizationOptionAlert|UNAuthorizationOptionCarPlay ) completionHandler:^(BOOL granted, NSError * _Nullable error) {
           
            if (!error) {
                ZLLog(@"request authorization succeeded");
            }
            
        }];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
        
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
        
    }
}

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId{
    //个推SDK已注册，返回clientId
    
    [self.store putString:clientId withId:@"clientId" intoTable:DBUserTable];
    
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
}


#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// iOS 10: App在前台获取到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
   
    NSLog(@"willPresentNotification:%@", notification.request.content.userInfo);
    [self.store putObject:notification.request.content.userInfo withId:@"qiantaihuoque" intoTable:DBUserTable];
    
    // 根据APP需要，判断是否要提示 户Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}
// iOS 10: 点击通知进 App时触发，在该方法内统计有效 户点击数   iOS 10: 点击通知进入App时触发
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    
    NSLog(@"didReceiveNotification:%@", response.notification.request.content.userInfo);
    [self.store putObject:response.notification.request.content.userInfo withId:@"dianjitongzhijin" intoTable:DBUserTable];
    // [ GTSdk ]:将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
    completionHandler();
    
    if (response.notification.request.content.userInfo) {
    
    NSString *payloadStr = [response.notification.request.content.userInfo objectForKey:@"payload"];
    NSData *jsonData = [payloadStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSString *type=[NSString stringWithFormat:@"%@",dic[@"type"]];
    // 1事件 2 任务 3 交办
    
    
    CYLTabBarController *tabBarVC = (CYLTabBarController *)self.window.rootViewController;
    
    ZLBaseNavViewController *nav = tabBarVC.selectedViewController;
    
    UIViewController *baseVC = (UIViewController *)nav.visibleViewController;
    
        NSString *Id=[NSString stringWithFormat:@"%@",dic[@"id"]];
        if ([type isEqualToString:@"1"]) {
            if ([baseVC isKindOfClass:[ZLMyEventDetailVC class]]) {
                
                ZLMyEventDetailVC *vc = (ZLMyEventDetailVC *)baseVC;
                vc.eventId = Id;
                vc.userCode = _loginModel.data.userId;
                
                [vc getData];
                
            }else{
                ZLMyEventDetailVC *vc = [[ZLMyEventDetailVC alloc]init];
                vc.eventId = Id;
                vc.userCode = _loginModel.data.userId;
                [nav pushViewController:vc animated:YES];
            }
        }else if ([type isEqualToString:@"2"]){
            
            if ([baseVC isKindOfClass:[ZLMyEventDetailVC class]]) {
                
                ZLTaskDetailVC *vc = (ZLTaskDetailVC *)baseVC;
                vc.code = Id;
                
                [vc getData];
                
            }else{
                ZLTaskDetailVC *vc = [[ZLTaskDetailVC alloc]init];
                //        vc.passCode = @"待办任务";
                vc.code = Id;
                [nav pushViewController:vc animated:YES];
            }
        }else if ([type isEqualToString:@"3"]){
            
            if ([baseVC isKindOfClass:[ZLOverSeeDetailVC class]]) {
                
                ZLOverSeeDetailVC *vc = (ZLOverSeeDetailVC *)baseVC;
                vc.code = Id;
                
                [vc getData];
                
            }else{
                ZLOverSeeDetailVC *vc = [[ZLOverSeeDetailVC alloc]init];
                //        vc.passCode = @"待办任务";
                vc.code = Id;
                [nav pushViewController:vc animated:YES];
            }
        }
    }
}
#endif

/** APP已经接收到“远程”通知(推送) - 透传推送消息 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    // 处 APNs代码，通过userInfo可以取到推送的信息(包括内容， 标， 定义参数等)。如果需要弹 窗等其他操作，则需要  编码。
    NSLog(@"\n>>>[Receive RemoteNotification - Background Fetch]:%@\n\n",userInfo);
    [self.store putObject:userInfo withId:@"touchuan" intoTable:DBUserTable];
    
    [GeTuiSdk handleRemoteNotification:userInfo];
    //静默推送收到消息后也需要将APNs信息传给个推统计 [GeTuiSdk handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    if (userInfo) {
        
        NSString *payloadStr = [userInfo objectForKey:@"payload"];
        NSData *jsonData = [payloadStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSString *type=[NSString stringWithFormat:@"%@",dic[@"type"]];
        // 1事件 2 任务 3 交办
        CYLTabBarController *tabBarVC = (CYLTabBarController *)self.window.rootViewController;
        
        ZLBaseNavViewController *nav = tabBarVC.selectedViewController;
        
        UIViewController *baseVC = (UIViewController *)nav.visibleViewController;
        
        NSString *Id=[NSString stringWithFormat:@"%@",dic[@"id"]];
        if ([type isEqualToString:@"1"]) {
            if ([baseVC isKindOfClass:[ZLMyEventDetailVC class]]) {
                
                ZLMyEventDetailVC *vc = (ZLMyEventDetailVC *)baseVC;
                vc.eventId = Id;
                vc.userCode = _loginModel.data.userId;
                
                [vc getData];
                
            }else{
                ZLMyEventDetailVC *vc = [[ZLMyEventDetailVC alloc]init];
                vc.eventId = Id;
                vc.userCode = _loginModel.data.userId;
                [nav pushViewController:vc animated:YES];
            }
        }else if ([type isEqualToString:@"2"]){
            
            if ([baseVC isKindOfClass:[ZLMyEventDetailVC class]]) {
                
                ZLTaskDetailVC *vc = (ZLTaskDetailVC *)baseVC;
                vc.code = Id;
                
                [vc getData];
                
            }else{
                ZLTaskDetailVC *vc = [[ZLTaskDetailVC alloc]init];
                //        vc.passCode = @"待办任务";
                vc.code = Id;
                [nav pushViewController:vc animated:YES];
            }
        }else if ([type isEqualToString:@"3"]){
            
            if ([baseVC isKindOfClass:[ZLOverSeeDetailVC class]]) {
                
                ZLOverSeeDetailVC *vc = (ZLOverSeeDetailVC *)baseVC;
                vc.code = Id;
                
                [vc getData];
                
            }else{
                ZLOverSeeDetailVC *vc = [[ZLOverSeeDetailVC alloc]init];
                //        vc.passCode = @"待办任务";
                vc.code = Id;
                [nav pushViewController:vc animated:YES];
            }
        }
        
    }
    
    
    
}


- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId{

    NSString *payloadMsg = nil;
    if (payloadData) {
        
        payloadMsg = [[NSString alloc]initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    NSError *error=nil;
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:payloadData options:NSJSONReadingMutableContainers error:&error];
    
    [self.store putObject:dic withId:@"payloadData" intoTable:DBUserTable];
    
    
    NSString *title=[NSString stringWithFormat:@"%@",dic[@"title"]];
    NSString *detail=[NSString stringWithFormat:@"%@",dic[@"content"]];
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg :%@%@",taskId,msgId,payloadMsg,offLine ? @"<离线消息>" : @""];
    
    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
    // 当app不在前台时，接收到的推送消息offLine值均为YES
    // 判断app是否是点击通知栏消息进行唤醒或开启
    // 如果是点击icon图标使得app进入前台，则不做操作，并且同一条推送通知，此方法只执行一次
    if (!offLine) {//  离线消息已经有苹果的apns推过消息了，避免上线后再次受到消息
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0){
            NSDictionary *dic = [NSDictionary dictionaryWithObject:payloadMsg forKey:@"payload"];
            [self registerNotification:1 andTitle:title andMess:detail userInfo:dic];
        }else{
            [self registerLocalNotificationInOldWay:1 andTitle:title andMess:detail userInfo:dic];
        }
    }
    
    
}

#pragma mark本地推送
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//使用 UNNotification 本地通知
-(void)registerNotification:(NSInteger )alerTime andTitle:(NSString*)title andMess:(NSString*)mes userInfo:(NSDictionary *)userInfo{
    
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    
    //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:mes
                                                         arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    content.userInfo= userInfo;
    
    // 在 alertTime 后推送本地推送
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:alerTime repeats:NO];
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"
                                                                          content:content trigger:trigger];
    
    //添加推送成功后的处理！
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
    }];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[UIApplication sharedApplication].applicationIconBadgeNumber+1];
    [GeTuiSdk setBadge:[UIApplication sharedApplication].applicationIconBadgeNumber];
}
#endif

- (void)registerLocalNotificationInOldWay:(NSInteger)alertTime andTitle:(NSString*)title andMess:(NSString*)mes userInfo:(NSDictionary *)userInfo{
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"fireDate=%@",fireDate);
    
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔-不重复
    notification.repeatInterval = kCFCalendarUnitEra;
    
    // 通知内容
    notification.alertTitle = title;
    notification.alertBody = mes;
    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    notification.userInfo = userInfo;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、
        notification.repeatInterval = NSDayCalendarUnit;
    }
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[UIApplication sharedApplication].applicationIconBadgeNumber+1];
    [GeTuiSdk setBadge:[UIApplication sharedApplication].applicationIconBadgeNumber];
}

- (void)GeTuiSdkDidOccurError:(NSError *)error{
    
    [self.store putObject:error.userInfo withId:@"error" intoTable:DBUserTable];
    
}


/**
 自定义tabbaritem的样式
 */
- (void)customizeTabbarItem{
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = HEXCOLOR(CNAVGATIONBAR_COLOR);
    
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = HEXCOLOR(0xa5a5a5);

    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    UITabBar *tabBar = [UITabBar appearance];
    
    [tabBar setBarTintColor:[UIColor whiteColor]];
    tabBar.translucent = NO;
    
//    [tabBar setShadowImage:[self imageWithColor:HEXCOLORAndAlpha(0x11ccf9, 0.2) size:CGSizeMake(Main_Screen_Width,0.5)]];
//    [tabBar setBackgroundImage:[[UIImage alloc]init]];
    
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
    
    NSString *userModel = [self.store getStringById:DBLoginModel fromTable:DBUserTable];
    
    self.loginModel = [[ZLNewLoginModel alloc]initWithString:userModel error:nil];
    
    NSString *version = [[NSUserDefaults standardUserDefaults]objectForKey:DBApp_Version];
    
    ZLLoginVC *logInVc = [[ZLLoginVC alloc]init];
    CYLTabBarController *tabBarVC = nil;
    
    if([version isEqualToString:@"2"]){
        ZLSimpleMainTapBarVCConfig *tabBarVCConfig = [[ZLSimpleMainTapBarVCConfig alloc]init];
        tabBarVC = tabBarVCConfig.tabBarController;
    }else if ([version isEqualToString:@"1"]){
        ZLMainTabBarControllerConfig *tabBarVCConfig = [[ZLMainTabBarControllerConfig alloc]init];
        tabBarVC = tabBarVCConfig.tabBarController;
    }
    
    tabBarVC.delegate = self;
    if (tokenCreateTime.length > 0) {
         NSInteger day = [self getDifferenceByDate:tokenCreateTime];
        
        if (day > 10 || version == nil) {
            self.window.rootViewController = logInVc;
        }else{
            
            self.window.rootViewController = tabBarVC;
        }
        
    }else{
        self.window.rootViewController = logInVc;
    }
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
   
    
}


#pragma mark - TabBardelegate
// 点击TabBar的代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    ZLLog(@"你点击了%lu",(unsigned long)tabBarController.selectedIndex);
    
}


// 调用注册设备token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    // 向个推服务 注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
    
    
    
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
    
//    if (application.applicationIconBadgeNumber > 0) {
//
//        [application setApplicationIconBadgeNumber:0];
//        [GeTuiSdk setBadge:0];
//
//    }
    
    //设置推送红点取消
    //1.设置本地推送
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    localNote.applicationIconBadgeNumber = -1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
    [[UIApplication sharedApplication] cancelLocalNotification:localNote];
    [GeTuiSdk setBadge:0];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
    
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    
}

@end
