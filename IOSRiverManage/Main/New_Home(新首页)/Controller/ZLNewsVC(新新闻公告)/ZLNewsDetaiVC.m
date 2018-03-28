//
//  ZLNewsDetaiVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/15.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewsDetaiVC.h"

@interface ZLNewsDetaiVC ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation ZLNewsDetaiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[UIWebView alloc]init];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.scrollView.bounces = NO;
     [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(Main_Screen_Width);
        
    }];
    NSURL *url = [NSURL URLWithString:self.url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
