//
//  ZLLoginViewController.m
//  AIProduct
//
//  Created by mac on 2017/8/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ZLLoginViewController.h"
#import "ZLLoginView.h"
#import "ZLLoginService.h"
#import "ZLMainTabBarControllerConfig.h"
#import <AFNetworking/AFNetworking.h>
#import "ZLDesTool.h"
#import "ZLLoginModel.h"
#import "ZLHomeWebViewViewController.h"
#import "ZLEventObjectService.h"
#import "ZLEventObjectModel.h"
#import "ZLEvent_DownObjectService.h"
#import "ZLBaseNavViewController.h"
#import "XGPush.h"
#import "ZLBadgeZeroService.h"
#import "ZLRiversDemandReachService.h"
#import "ZLRiverDemandModel.h"
@interface ZLLoginViewController ()<UITextFieldDelegate,YTKChainRequestDelegate>

@property (nonatomic, strong) ZLLoginView *loginView;
@property (nonatomic, strong) NSMutableArray *eventObjectArray;
@property (nonatomic, strong) NSMutableArray *downObjectArray;
@property (nonatomic, strong) YTKKeyValueStore *store;

/**
 河道信息
 */
@property (nonatomic, strong) NSMutableArray *riverSourceArray;

@end

@implementation ZLLoginViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.store = [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
    
    NSString *tableName = @"user_table";
    
    [self.store createTableWithName:tableName];
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    
    keyboardManager.shouldResignOnTouchOutside = YES;
 
    self.loginView.nameFiledView.loginTextField.text = [self.store getStringById:DBUserName fromTable:DBUserTable];
    self.loginView.passwordFiledView.loginTextField.text =  [self.store getStringById:DBPassword fromTable:DBUserTable];
//    self.loginView.nameFiledView.loginTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:UUserName];
//    self.loginView.passwordFiledView.loginTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:UPassword];
    [self.loginView.loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];

}

-(UIImage *)imageResize:(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - 登录按钮的响应方法
-(void)loginBtnClicked:(UIButton *)btn{
    
    [self.view endEditing:YES];
    
    if (_loginView.nameFiledView.loginTextField.text.length <= 0 || _loginView.passwordFiledView.loginTextField.text.length <= 0) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"请填写正确的用户名或密码" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
        return;
        
    }
    
    [SVProgressHUD showWithStatus:@"登录中"];
    
//    [[NSUserDefaults standardUserDefaults]setObject:_loginView.nameFiledView.loginTextField.text forKey:UUserName];
    
    [self.store putString:_loginView.nameFiledView.loginTextField.text withId:DBUserName intoTable:DBUserTable];
    
    [self.store putString:_loginView.passwordFiledView.loginTextField.text withId:DBPassword intoTable:DBUserTable];
    
//    [[NSUserDefaults standardUserDefaults]setObject:_loginView.passwordFiledView.loginTextField.text forKey:UPassword];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    YTKChainRequest *chain = [[YTKChainRequest alloc]init];
    ZLLoginService *loginService = [[ZLLoginService alloc]initWithuserName:self.loginView.nameFiledView.loginTextField.text passworld:self.loginView.passwordFiledView.loginTextField.text];

    [chain addRequest:loginService callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
        
        ZLLoginService *loginService = (ZLLoginService *)baseRequest;
        NSData *responseData = loginService.responseObject;
        NSString *str =  [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
        
        //       {"code":0,"detail":"成功","data":{"areaCode":"32","userName":"admin","userId":"10000","token":"6605b805-4efc-45b6-ae7e-26271c963fe0"}}



        
        
        NSString *deStr = [ZLDesTool decryptWithText:str];
        // 4028800c5dcf7178015dcfd701fd000a
        ZLLoginModel *loginModel = [[ZLLoginModel alloc]initWithString:deStr error:nil];
        if ([loginModel.ret_code isEqualToString:@"0000"]) {
            
            [[XGPushTokenManager defaultTokenManager]bindWithIdentifier:loginModel.userId type:(XGPushTokenBindTypeAccount)];
            
            ZLEventObjectService *objectService = [[ZLEventObjectService alloc]initWithuid:loginModel.userId riverId:@""];
            [chainRequest addRequest:objectService callback:nil];
            
            ZLEvent_DownObjectService *downObjectService = [[ZLEvent_DownObjectService alloc]initWithuid:loginModel.userId riverId:@""];
            [chainRequest addRequest:downObjectService callback:nil];
            
            
            ZLRiversDemandReachService *demandService = [[ZLRiversDemandReachService alloc]initWithUidCode:loginModel.userId];
            [chainRequest addRequest:demandService callback:nil];
            
            
            
//            // 如果有角标的话
//            if ([UIApplication sharedApplication].applicationIconBadgeNumber > 0) {
//
//                ZLBadgeZeroService *zeroBadgeService = [[ZLBadgeZeroService alloc]initWithUid:loginModel.userId];
//                [chainRequest addRequest:zeroBadgeService callback:nil];
//
//            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
            
        }
    }];
    
    chain.delegate = self;
    [chain start];
}



- (void)chainRequestFinished:(YTKChainRequest *)chainRequest{
    
    ZLLoginService *request = (ZLLoginService *)chainRequest.requestArray[0];
    NSData *responseData = request.responseObject;
    NSString *str =  [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    NSString *deStr = [ZLDesTool decryptWithText:str];
    
    ZLLoginModel *loginModel = [[ZLLoginModel alloc]initWithString:deStr error:nil];
    
    ZLLog(@"%@",loginModel);
    
    if ([loginModel.ret_code isEqualToString:@"0000"]) {

        ZLEventObjectService *getObject = (ZLEventObjectService *)chainRequest.requestArray[1];
        NSDictionary *getObjectDic = getObject.responseJSONObject;
        
        // 下发任务获取的对象
        ZLEvent_DownObjectService *downObject = (ZLEvent_DownObjectService *)chainRequest.requestArray[2];
        NSDictionary *downObjectDic = downObject.responseJSONObject;
        
        ZLRiversDemandReachService *demandReach = (ZLRiversDemandReachService *)chainRequest.requestArray[3];
        
        NSDictionary *dic = demandReach.responseObject;
        
        NSArray *modelArray = dic[@"data"];
        
        if (modelArray.count > 0) {
            
            for (NSDictionary *dic in modelArray) {
                
                ZLRiverDemandModel *model = [[ZLRiverDemandModel alloc]initWithDictionary:dic error:nil];
                
                [self.riverSourceArray addObject:model];
                
                ZLLog(@"%@",model);
            }
        }
        

        if (![getObjectDic[@"code"] isEqualToString:@"0"] || ![downObjectDic[@"code"] isEqualToString:@"0"]) {
            
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
            [SVProgressHUD dismissWithDelay:0.3];
            
        }else{
            [self getEventObjectWith:getObjectDic[@"data"] container:self.eventObjectArray forKey:DBEventObject];
            ZLLog(@"%@",getObjectDic);
            [self getEventObjectWith:downObjectDic[@"data"] container:self.downObjectArray forKey:DBDownEventObject];
            
            [self.store putString:loginModel.toJSONString withId:DBLoginModel intoTable:DBUserTable];
            
//            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:loginModel];
//            [[NSUserDefaults standardUserDefaults]setObject:data forKey:ULoginModel];
//            [[NSUserDefaults standardUserDefaults] synchronize];

            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [SVProgressHUD dismissWithDelay:0.3];
            [self removeFromParentViewController];
            
            
            ZLHomeWebViewViewController *webVC = [[ZLHomeWebViewViewController alloc]init];
            if (_userInfo) {
                webVC.userInfo = _userInfo;
                
            }
            webVC.loginModel = loginModel;
            webVC.riverSourceArray = self.riverSourceArray;
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:webVC];
            nav.interactivePopGestureRecognizer.enabled = NO;
            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
        [SVProgressHUD dismissWithDelay:0.3];
    }
}

- (void)getEventObjectWith:(NSArray *)data container:(NSMutableArray *)saveContainer forKey:(NSString *)key{
    
    for (NSDictionary *dic in data) {
        ZLEventObjectModel *objectModel = [[ZLEventObjectModel alloc]initWithDictionary:dic error:nil];
        
        NSString *json = objectModel.toJSONString;
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:objectModel];
//        [saveContainer addObject:data];
        [saveContainer addObject:json];
    }
//    NSArray *ObjectArray = [NSArray arrayWithArray:saveContainer];
//
//    [[NSUserDefaults standardUserDefaults]setObject:ObjectArray forKey:key];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    NSArray *ObjectArray = [NSArray arrayWithArray:saveContainer];
    [self.store putObject:ObjectArray withId:key intoTable:DBUserTable];
}

- (void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(YTKBaseRequest *)request{
    
    ZLLog(@"%@",request.response);
    [SVProgressHUD dismiss];
    [SVProgressHUD showInfoWithStatus:@"网络错误"];
    [SVProgressHUD dismissWithDelay:0.3];
    
    
}

- (NSMutableArray *)eventObjectArray{
    
    if (!_eventObjectArray) {
        _eventObjectArray = [NSMutableArray array];
    }
    return _eventObjectArray;
}

- (NSMutableArray *)downObjectArray{
    
    if (!_downObjectArray) {
        _downObjectArray  = [NSMutableArray array];
    }
    return _downObjectArray;
}

- (NSMutableArray *)riverSourceArray{
    
    if (!_riverSourceArray) {
        _riverSourceArray  = [NSMutableArray array];
    }
    return _riverSourceArray;
}


- (ZLLoginView *)loginView{
    if (!_loginView) {
        _loginView = [[ZLLoginView alloc]initWithFrame:CGRectMake(0, 0, App_Frame_Width, App_Frame_Height + 20)];
        [self.view addSubview:_loginView];
        
    }
    return _loginView;
}

@end
