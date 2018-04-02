//
//  ZLRiverInfoFiveDetailVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/30.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverInfoFiveDetailVC.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "ZLGaodeCustomNavBar.h"
@protocol JSObjectDelegate <JSExport>

-(NSString *)getRiverCode;

-(NSString *)getIndex;

@end

@interface ZLRiverInfoFiveDetailVC ()<UIWebViewDelegate, JSObjectDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *context;
@end

@implementation ZLRiverInfoFiveDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZLGaodeCustomNavBar *navBar = [[ZLGaodeCustomNavBar alloc]initWithFrame:CGRectMake(0, 0, App_Frame_Height, TopBarHeight)];
//    navBar.titleLabel.text = @"";
    [navBar.backButton addTarget:self action:@selector(clickBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:navBar];
    
    navBar.backgroundColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, App_Frame_Height, App_Frame_Width)];
    self.webView.userInteractionEnabled = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:River_FiveAndTwoTableUrl]]];
    self.webView.userInteractionEnabled = YES;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.webView setScalesPageToFit:YES];
    self.webView.delegate = self;
    
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:self.webView];
    
//    UIButton *button = [[UIButton alloc]init];
//    button.backgroundColor = [UIColor redColor];
//    [self.view addSubview:button];
//    
//    [button addTarget:self action:@selector(clickBtn) forControlEvents:(UIControlEventTouchUpInside)];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(20);
//        make.top.equalTo(self.view).offset(20);
//        make.width.mas_equalTo(30);
//        make.height.mas_equalTo(30);
//        
//    }];
    
    
    
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.context.exceptionHandler = ^(JSContext* context, JSValue* exceptionValue) {
        context.exception = exceptionValue;
        ZLLog(@"异常信息: %@",exceptionValue);
    };
    self.context[@"AppContext"] = self;
    
    return YES;
    
    
}



- (void)webViewDidFinishLoad:(UIWebView *)webView{
    ZLLog(@"FinishLoad%@",webView.request.URL);
    
    
}

- (NSString *)getRiverCode{
    
    return self.riverCodeAndIndex.firstObject;
    
}

- (NSString *)getIndex{
    return self.riverCodeAndIndex.lastObject;
}

- (void)clickBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (BOOL)shouldAutorotate
{
    
    return NO;
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations

{
    
    return UIInterfaceOrientationMaskLandscape;
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation

{
    
    return UIInterfaceOrientationLandscapeRight;
    
}


- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"综合统计" attributes:dic];
    
    return title;
    
}

@end
