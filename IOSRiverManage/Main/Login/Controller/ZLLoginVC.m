//
//  ZLLoginVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/12.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLLoginVC.h"
#import "ZLLoginTopView.h"
#import "ZLLoginInputView.h"
#import "ZLMainTabBarControllerConfig.h"
#import "ZLLoginService.h"
#import "ZLNewLoginModel.h"
#import "ZLNewAreaService.h"
#import "ZLNewAreaModel.h"
#import "ZLNewGetUserRiversService.h"
#import "ZLNewUserRiversModel.h"
#import "ZLGetUserListByIncidentService.h"
#import "ZLGetDepartmentListByIncidentService.h"
#import "ZLGetDepartModel.h"
#import "ZLGetUserListByTaskNormalService.h"
#import "ZLGetDepartmentListByTaskService.h"
#import "ZLGetEventUserListModel.h"
#import "ZLSimpleMainTapBarVCConfig.h"
@interface ZLLoginVC ()<YTKChainRequestDelegate>

@property (nonatomic, strong) ZLLoginTopView *topView;
@property (nonatomic, strong) ZLLoginInputView *inputView;

@property (nonatomic, strong) YTKKeyValueStore *store;

@end

@implementation ZLLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.store = [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
    
    NSString *tableName = DBUserTable;
    
    [self.store createTableWithName:tableName];
    
    [self.view addSubview:self.topView];
    
    [self.view addSubview:self.inputView];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(TopBarHeight + 10);
        make.width.mas_equalTo(Main_Screen_Width);
        make.left.equalTo(self.view);
        //        make.height.mas_equalTo(Main_Screen_Height / 3 - TopBarHeight);
    }];
    
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.topView.mas_bottom);
        make.width.mas_equalTo(Main_Screen_Width);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    
    self.inputView.nameTextField.text = [self.store getStringById:DBUserName fromTable:DBUserTable];
    self.inputView.passTextField.text =  [self.store getStringById:DBPassword fromTable:DBUserTable];
    
    
    
}

- (void)loginBtnClick{
    [self.view endEditing:YES];
    
    //     [self goToMainController];
    
    if (_inputView.nameTextField.text.length <= 0 || _inputView.passTextField.text.length <= 0) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"请填写正确的用户名或密码" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return;
    }
    
    [self.store putString:_inputView.nameTextField.text withId:DBUserName intoTable:DBUserTable];
    
    [SVProgressHUD showWithStatus:@"登录中"];
    
    YTKChainRequest *chain = [[YTKChainRequest alloc]init];
    ZLLoginService *loginService = [[ZLLoginService alloc]initWithuserName:self.inputView.nameTextField.text passworld:self.inputView.passTextField.text];
    
    [chain addRequest:loginService callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
        
        ZLLoginService *loginService = (ZLLoginService *)baseRequest;
        
        ZLNewLoginModel *model = [[ZLNewLoginModel alloc]initWithString:loginService.responseString error:nil];
        
        if ([model.code isEqualToString:@"0"]) {
            
            [self.store putString:_inputView.passTextField.text withId:DBPassword intoTable:DBUserTable];
            
            [self.store putString:model.data.areaCode withId:DBUserAreaCode intoTable:DBUserTable];
            
            [[NSUserDefaults standardUserDefaults] setObject:model.data.token forKey:DBUserToken];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //             ZLNewAreaService *areaService = [[ZLNewAreaService alloc]init];
            //
            //            [chainRequest addRequest:areaService callback:nil];
            
            ZLNewGetUserRiversService *getUserRiversService = [[ZLNewGetUserRiversService alloc]init];
            
            [chainRequest addRequest:getUserRiversService callback:nil];
            
            ZLGetUserListByIncidentService *getUserListService = [[ZLGetUserListByIncidentService alloc]initWithriverCode:@""];
            [chainRequest addRequest:getUserListService callback:nil];
            
            ZLGetDepartmentListByIncidentService *getDepartListService = [[ZLGetDepartmentListByIncidentService alloc]init];
            [chainRequest addRequest:getDepartListService callback:nil];
            
            ZLGetUserListByTaskNormalService *getTaskNormalService = [[ZLGetUserListByTaskNormalService alloc]initWithriverCode:nil];
            [chainRequest addRequest:getTaskNormalService callback:nil];
            
            ZLGetDepartmentListByTaskService *getDepartListTaskService = [[ZLGetDepartmentListByTaskService alloc]init];
            [chainRequest addRequest:getDepartListTaskService callback:nil];
            
        }else{
            [SVProgressHUD showErrorWithStatus:model.detail];
            [SVProgressHUD dismissWithDelay:0.3];
        }
        
        //               {"code":0,"detail":"成功","data":{"areaCode":"32","userName":"admin","userId":"10000","token":"6605b805-4efc-45b6-ae7e-26271c963fe0"}}
        
    }];
    
    chain.delegate = self;
    [chain start];
    
    
    
    
    
    
}

/**
 跳到主控制器
 */
- (void)goToMainControllerWithVersion:(NSString *)version {
    [self removeFromParentViewController];
    self.view = nil;
    
    if ([version isEqualToString:@"1"]) {
        // 基础版
        ZLSimpleMainTapBarVCConfig *tabBarVCConfig = [[ZLSimpleMainTapBarVCConfig alloc]init];
        CYLTabBarController *tabBarVC = tabBarVCConfig.tabBarController;
        
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
        
    }else if ([version isEqualToString:@"2"]){
        
        ZLMainTabBarControllerConfig *tabBarVCConfig = [[ZLMainTabBarControllerConfig alloc]init];
        CYLTabBarController *tabBarVC = tabBarVCConfig.tabBarController;
        
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
    }
}

- (void)chainRequestFinished:(YTKChainRequest *)chainRequest{
    
    ZLLoginService *request = (ZLLoginService *)chainRequest.requestArray[0];
    
    ZLNewLoginModel *model = [[ZLNewLoginModel alloc]initWithString:request.responseString error:nil];
    
    if ([model.code isEqualToString:@"0"]) {
        
        //        ZLNewAreaService *getObject = (ZLNewAreaService *)chainRequest.requestArray[1];
        //
        //        NSString *getObjectDic = getObject.responseString;
        //
        //        ZLNewAreaModel *areaModel = [[ZLNewAreaModel alloc]initWithString:getObjectDic error:nil];
        
        
        ZLNewGetUserRiversService *getUserRivers = (ZLNewGetUserRiversService *)chainRequest.requestArray[1];
        NSString *getUserString = getUserRivers.responseString;
        ZLNewUserRiversModel *riversModel = [[ZLNewUserRiversModel alloc]initWithString:getUserString error:nil];
        
        [self.store putString:getUserString withId:DBUserRivers intoTable:DBUserTable];
        //        ZLLog(@"%@",areaModel);
        
        
        //        if (![areaModel.code isEqualToString:@"0"]) {
        
        //            [SVProgressHUD showErrorWithStatus:@"登录失败"];
        //            [SVProgressHUD dismissWithDelay:0.3];
        
        //        }else{
        
        [self.store putString:request.responseString withId:DBLoginModel intoTable:DBUserTable];
        [self.store putString:[ZLUtility getDateByTimestamp:[ZLUtility getNowTimestampSec] type:4] withId:DBLoginTokenCreateTime intoTable:DBUserTable];
        
        ZLGetUserListByIncidentService *getUserList = (ZLGetUserListByIncidentService *)chainRequest.requestArray[2];
        
        ZLGetEventUserListModel *eventUserList = [[ZLGetEventUserListModel alloc]initWithString:getUserList.responseString error:nil];
        
        if ([eventUserList.code isEqualToString:@"0"]) {
            
           [self.store putString:getUserList.responseString withId:DBEventPeopleListRivers intoTable:DBUserTable];
            
        }
        
        ZLGetDepartmentListByIncidentService *getDepartList = (ZLGetDepartmentListByIncidentService *)chainRequest.requestArray[3];
        
        ZLGetDepartModel *departModel = [[ZLGetDepartModel alloc]initWithString:getDepartList.responseString error:nil];
        
        if ([departModel.code isEqualToString:@"0"]) {
            [self.store putString:getDepartList.responseString withId:DBEventDepartListRivers intoTable:DBUserTable];
        }
        
        ZLGetUserListByTaskNormalService *getTaskUsersList = (ZLGetUserListByTaskNormalService *)chainRequest.requestArray[4];
        
        ZLGetEventUserListModel *taskUserList = [[ZLGetEventUserListModel alloc]initWithString:getTaskUsersList.responseString error:nil];
        
        if ([taskUserList.code isEqualToString:@"0"]) {
            
            [self.store putString:getTaskUsersList.responseString withId:DBTaskPeopleListRivers intoTable:DBUserTable];
            
        }

        ZLGetDepartmentListByTaskService *getDepartTaskList = (ZLGetDepartmentListByTaskService *)chainRequest.requestArray[5];
        
        ZLGetDepartModel *taskDepartModel = [[ZLGetDepartModel alloc]initWithString:getDepartTaskList.responseString error:nil];
        
        if ([taskDepartModel.code isEqualToString:@"0"]) {
            [self.store putString:getDepartTaskList.responseString withId:DBTaskDepartListRivers intoTable:DBUserTable];
        }
        
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        [SVProgressHUD dismissWithDelay:0.3];
        
        
        [self goToMainControllerWithVersion:model.data.version];
        
        
        
        //        }
    }else{
        [SVProgressHUD showErrorWithStatus:model.detail];
        [SVProgressHUD dismissWithDelay:0.3];
    }
}



- (void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(YTKBaseRequest *)request{
    
    ZLLog(@"%@",request.response);
    [SVProgressHUD dismiss];
    [SVProgressHUD showInfoWithStatus:@"网络错误"];
    [SVProgressHUD dismissWithDelay:0.3];
    
    
}


- (ZLLoginTopView *)topView{
    
    if (!_topView) {
        
        _topView = [[ZLLoginTopView alloc]init];
        
    }
    return _topView;
    
}

- (ZLLoginInputView *)inputView{
    
    if (!_inputView) {
        
        _inputView = [[ZLLoginInputView alloc]init];
        [_inputView.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _inputView;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
