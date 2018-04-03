//
//  ZLStatisticsVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/30.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLStatisticsVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjectDelegate <JSExport>
-(NSString *)getAreaCode;
-(NSString *)getRiverCode;

-(NSString *)getIndex;

@end

@interface ZLStatisticsVC ()<UIWebViewDelegate, JSObjectDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *context;
@end

@implementation ZLStatisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, App_Frame_Width, App_Frame_Height)];
    self.webView.userInteractionEnabled = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:River_ComStatisticsUrl]]];
    self.webView.userInteractionEnabled = YES;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.webView setScalesPageToFit:YES];
    self.webView.delegate = self;

    self.webView.scrollView.bounces = NO;
    [self.view addSubview:self.webView];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.context.exceptionHandler = ^(JSContext* context, JSValue* exceptionValue) {
        context.exception = exceptionValue;
        ZLLog(@"异常信息: %@",exceptionValue);
    };
    self.context[@"appContext"] = self;
    
    return YES;
    
    
}



- (void)webViewDidFinishLoad:(UIWebView *)webView{
    ZLLog(@"FinishLoad%@",webView.request.URL);
    
    
}

-(NSString *)getAreaCode{
    
    return self.areaCode;
}

- (NSString *)getRiverCode{
    
    return @"10000";
    
}

- (NSString *)getIndex{
    return @"0";
}



- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"综合统计" attributes:dic];
    
    return title;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
