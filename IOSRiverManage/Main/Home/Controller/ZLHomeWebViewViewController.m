//
//  ZLHomeWebViewViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/18.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLHomeWebViewViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "ZLBaiduTrackViewController.h"
#import "ZLLeftViewController.h"
#import "ZLEventReportViewController.h"
#import "ZLBaiduiImportanceViewController.h"
#import "ZLEvent_SendDownViewController.h"
#import "ZLContinueEventReportViewController.h"
#import "ZLCompleteEventReportViewController.h"
#import "ZLContinueEventSendDownViewController.h"
#import "ZLCompleteEventSendDownViewController.h"
#import "ZLEventReportAndSendDownController.h"
#import "ZLBadgeZeroService.h"
#import "ZLGaodeViewController.h"
#import "ZLRiverDemandModel.h"
#import "ZLAlertSelectionView.h"
#import "ZLRiverRecordViewController.h"
#import "ZLEventManagerViewController.h"
#import "ZLRiverInfoManagerViewController.h"
@protocol JSObjectDelegate <JSExport>

- (void)unlogin;
// river.location(SorEtype,uuid,type);
JSExportAs(location, - (void)location:(NSString *)SorEtype NSString:(NSString *)uuid NSString:(NSString *)type);

//-(void)event_report;
//-(void)go_task;

-(void)submit_affair;

-(void)clearTips;

// 拨打电话
-(void)call:(NSString *)phone;

-(void)event_cont_report:(NSString *)eid;//继续上报
-(void)end_task:(NSString *)eid;//办结
-(void)task_xf:(NSString *)tid;//继续下发
-(void)task_fk:(NSString *)tid;//下发反馈

@end

@interface ZLHomeWebViewViewController ()<UIWebViewDelegate,JSObjectDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) NSString *loadedURL;
@property (nonatomic, assign) BOOL isFirstLoadWeb;
@end

@implementation ZLHomeWebViewViewController
{
    Boolean isLoad;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_webView reload];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

//061520
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = HEXCOLOR(KNavBarBG_color_blue);
    }
    
    //    NSData *loginData = [[NSUserDefaults standardUserDefaults]objectForKey:ULoginModel];
    //
    //    _loginModel = [NSKeyedUnarchiver unarchiveObjectWithData:loginData];
    
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, App_Frame_Width, App_Frame_Height)];
    self.webView.userInteractionEnabled = YES;
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_loginModel.ret_data]]];
    
//    _loginModel.ret_data = [_loginModel.ret_data stringByReplacingOccurrencesOfString:@"http://localhost:8080" withString:@"http://192.168.0.113:8080"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_loginModel.ret_data]]];
    
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.webView setScalesPageToFit:YES];
    
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:self.webView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    ZLLog(@"DidStartLoad%@",webView.request.URL);
    // http://39.108.186.130:18081/hzz/phoneController.do?home&token=HZZUSER-1475785447cd4df9a6f43ec68a117a5f-cas
    //http://39.108.186.130:18081/hzz/phoneController.do?home&token=HZZUSER-1475785447cd4df9a6f43ec68a117a5f-cas
    [SVProgressHUD showWithStatus:@"加载中"];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [SVProgressHUD dismiss];
    NSLog(@"%d",webView.isLoading);
    ZLLog(@"FinishLoad%@",webView.request.URL);
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    self.context.exceptionHandler = ^(JSContext* context, JSValue* exceptionValue) {
        context.exception = exceptionValue;
        ZLLog(@"异常信息: %@",exceptionValue);
    };
    
    self.context[@"river"] = self;
    
    
    if (_userInfo) {
        NSString *pushToURL = [NSString stringWithFormat:@"%@/hzz/phoneController.do?supervise",Base_URL];
        if ([[webView.request.URL absoluteString] isEqualToString:pushToURL]) {
            return;
        }else{
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:pushToURL]]];
            _userInfo = nil;
        }
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
    ZLLog(@"error == %@",error);
}

#pragma mark - JSExport Methods
-(void)unlogin
{
    ZLLog(@"callme");
    
    ZLLeftViewController *leftVC = [[ZLLeftViewController alloc]init];
    
    leftVC.loginModel = _loginModel;
    [self addChildViewController:leftVC];
    
    CGRect frame = leftVC.view.frame;
    frame.origin.x = - CGRectGetWidth(self.view.frame);
    leftVC.view.frame = frame;
    
    [self.view addSubview:leftVC.view];
    
    [leftVC showFromLeft];
    
    
}


- (void)location:(NSString *)SorEtype NSString:(NSString *)uuid NSString:(NSString *)type{
    
//    NSLog(@"%@",self.riverSourceArray);
//    
//    NSMutableArray *sourceArray = [NSMutableArray array];
//    
//    if (self.riverSourceArray.count > 0) {
//        
//        for (ZLRiverDemandModel *demandModel in self.riverSourceArray) {
//            [sourceArray addObject:demandModel.rivers_name];
//            
//        }
//        ZLAlertSelectionView *alert = [[ZLAlertSelectionView alloc]initWithFrame:CGRectZero sourceArray:sourceArray];
//        [alert show];
//        
//        alert.selectItem = ^(NSInteger index) {
//            ZLGaodeViewController *gaodeVC = [[ZLGaodeViewController alloc]init];
//            gaodeVC.demandModel = self.riverSourceArray[index];
//            gaodeVC.uid = _loginModel.userId;
//            gaodeVC.type = type;
//            gaodeVC.uuid = uuid;
////            [self.navigationController pushViewController:gaodeVC animated:YES];
//            [self presentViewController:gaodeVC animated:YES completion:^{
//            }];
//        };
//        
//    }else{
//    
//    }
    
    
    if ([type isEqualToString:@"1"]) {
        ZLBaiduTrackViewController *baiduVC = [[ZLBaiduTrackViewController alloc]init];
        baiduVC.uid = _loginModel.userId;
        baiduVC.type = type;
        baiduVC.uuid = uuid;
        [self.navigationController pushViewController:baiduVC animated:YES];
    }


    if ([type isEqualToString:@"2"]) {
        ZLBaiduiImportanceViewController *baiduImportVC = [[ZLBaiduiImportanceViewController alloc]init];
        baiduImportVC.uid = _loginModel.userId;
        baiduImportVC.type = type;
        baiduImportVC.uuid = uuid;

        [self.navigationController pushViewController:baiduImportVC animated:YES];
    }
}

// 事件和任务合并之后的接口
-(void)submit_affair{
    ZLEventReportAndSendDownController *eventVC = [[ZLEventReportAndSendDownController alloc]init];
    eventVC.uid = _loginModel.userId;

    ZLLog(@"%@",self.navigationController);

    [self.navigationController pushViewController:eventVC animated:YES];
    
//    ZLRiverRecordViewController *eventVC = [[ZLRiverRecordViewController alloc]init];
//
//    [self.navigationController pushViewController:eventVC animated:YES];
//
//    ZLEventManagerViewController *manager = [[ZLEventManagerViewController alloc]init];
//    [self.navigationController pushViewController:manager animated:YES];
//    
//    ZLRiverInfoManagerViewController *manager = [[ZLRiverInfoManagerViewController alloc]init];
//    [self.navigationController pushViewController:manager animated:YES];
    
}

///**
// 事件上报按钮触发方法
// */
//- (void)event_report{
//
////    ZLEventReportViewController *eventVC = [[ZLEventReportViewController alloc]init];
////    eventVC.uid = _loginModel.userId;
////
////    ZLLog(@"%@",self.navigationController);
////
////    [self.navigationController pushViewController:eventVC animated:YES];
//
//
//    ZLEventReportAndSendDownController *eventVC = [[ZLEventReportAndSendDownController alloc]init];
//    eventVC.uid = _loginModel.userId;
//
//    ZLLog(@"%@",self.navigationController);
//
//    [self.navigationController pushViewController:eventVC animated:YES];
//
//
//}

- (void)event_cont_report:(NSString *)eid{
    
    ZLContinueEventReportViewController *eventVC = [[ZLContinueEventReportViewController alloc]init];
    eventVC.uid = _loginModel.userId;
    eventVC.eid = eid;
    ZLLog(@"%@",self.navigationController);
    
    [self.navigationController pushViewController:eventVC animated:YES];
    
}

- (void)end_task:(NSString *)eid{
    ZLCompleteEventReportViewController *eventVC = [[ZLCompleteEventReportViewController alloc]init];
    eventVC.uid = _loginModel.userId;
    eventVC.eid = eid;
    ZLLog(@"%@",self.navigationController);
    
    [self.navigationController pushViewController:eventVC animated:YES];
}

///**
// 事件下发触发事件
// */
//- (void)go_task{
//    ZLEvent_SendDownViewController *eventVC = [[ZLEvent_SendDownViewController alloc]init];
//    eventVC.uid = _loginModel.userId;
//
//    [self.navigationController pushViewController:eventVC animated:YES];
//
//}
/**
 事件继续下发触发事件
 */
- (void)task_xf:(NSString *)tid{
    ZLContinueEventSendDownViewController *eventVC = [[ZLContinueEventSendDownViewController alloc]init];
    eventVC.uid = _loginModel.userId;
    eventVC.tid = tid;
    ZLLog(@"%@",self.navigationController);
    
    [self.navigationController pushViewController:eventVC animated:YES];
    
}

/**
 下发任务反馈
 */
- (void)task_fk:(NSString *)tid{
    ZLCompleteEventSendDownViewController *eventVC = [[ZLCompleteEventSendDownViewController alloc]init];
    eventVC.uid = _loginModel.userId;
    eventVC.tid = tid;
    ZLLog(@"%@",self.navigationController);
    
    [self.navigationController pushViewController:eventVC animated:YES];
    
}

-(void)call:(NSString *)phone{
    
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
    // ZLLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

-(void)clearTips{
    // 如果角标大于0
    if ([UIApplication sharedApplication].applicationIconBadgeNumber > 0) {
        
        ZLBadgeZeroService *zeroBadgeService = [[ZLBadgeZeroService alloc]initWithUid:_loginModel.userId];
        
        [zeroBadgeService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSDictionary *bageDic = request.responseJSONObject;
            
            if ([bageDic[@"code"] isEqualToString:@"0"]) {
                [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
            }
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    }
}

-(void)caculateButtonAction:(id)sender
{
    //    NSNumber *inputNumber = [NSNumber numberWithInteger:[textField.text integerValue]];
    //    JSValue *function = [self.context objectForKeyedSubscript:@"factorial"];
    //    JSValue *result = [function callWithArguments:@[inputNumber]];
    //
    //    resultL.text = [NSString stringWithFormat:@"%@",[result toNumber]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

