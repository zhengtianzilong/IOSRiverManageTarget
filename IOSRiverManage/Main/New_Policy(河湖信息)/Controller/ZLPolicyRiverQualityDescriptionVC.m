//
//  ZLPolicyRiverQualityDescriptionVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLPolicyRiverQualityDescriptionVC.h"

@interface ZLPolicyRiverQualityDescriptionVC ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation ZLPolicyRiverQualityDescriptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, App_Frame_Width, Main_Screen_Height - (TopBarHeight-20))];
    
    _webView.scrollView.bounces = NO;
    
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_webView];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"quality_info" ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
     [_webView loadHTMLString:htmlCont baseURL:baseURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"水质类别说明" attributes:dic];
    
    return title;
    
}


@end
