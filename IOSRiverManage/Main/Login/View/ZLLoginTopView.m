//
//  ZLLoginTopView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/12.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLLoginTopView.h"
#import "ZLAlertSelectionView.h"
#define kProduct @"http://192.168.0.83:1011"
#define kcomStatisticsProduct @"http://183.207.103.139:86"
#define kfileProduct @"http://183.207.103.139:86/file/"

#define kDebug @"http://112.4.10.185:86/api/"
#define kcomStatisticsDebug @"http://112.4.10.185:86"
#define kfileDebug @"http://112.4.10.185:86/file/"

#define kPre @"http://112.4.10.187:86/api/"
#define kcomStatisticsPre @"http://112.4.10.187:86"
#define kfilePre @"http://112.4.10.187:86/file/"


@interface ZLLoginTopView()

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *addressArray;

@end

@implementation ZLLoginTopView
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
#if WanApp
        [[NSUserDefaults standardUserDefaults] setObject:@"http://112.33.250.183:86/api/" forKey:@"Server"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"http://112.33.250.183:86" forKey:@"ComStatistics"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"http://112.33.250.183:86/file/" forKey:@"File"];
#else
        [[NSUserDefaults standardUserDefaults] setObject:kProduct forKey:@"Server"];
        
        [[NSUserDefaults standardUserDefaults] setObject:kcomStatisticsProduct forKey:@"ComStatistics"];
        
        [[NSUserDefaults standardUserDefaults] setObject:kfileProduct forKey:@"File"];
#endif
        
        
       
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    [self addSubview:self.titleImageV];
    [self addSubview:self.logoImageV];
    
    [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(85);
    }];
    
    [self.titleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(self.logoImageV.mas_bottom).offset(15);
//        make.height.mas_equalTo(35);
        make.bottom.equalTo(self.mas_bottom) ;
        
    }];
    
}

- (void)longPressClick{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"选择接口环境" preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"生产环境" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setObject:kProduct forKey:@"Server"];
        
        [[NSUserDefaults standardUserDefaults] setObject:kcomStatisticsProduct forKey:@"ComStatistics"];
       
        [[NSUserDefaults standardUserDefaults] setObject:kfileProduct forKey:@"File"];
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"测试环境" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setObject:kDebug forKey:@"Server"];
        
        [[NSUserDefaults standardUserDefaults] setObject:kcomStatisticsDebug forKey:@"ComStatistics"];
        [[NSUserDefaults standardUserDefaults] setObject:kfileDebug forKey:@"File"];
        
        
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"预生产环境" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setObject:kPre forKey:@"Server"];
        
        [[NSUserDefaults standardUserDefaults] setObject:kcomStatisticsPre forKey:@"ComStatistics"];
        [[NSUserDefaults standardUserDefaults] setObject:kfilePre forKey:@"File"];
        
        
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [alertController dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:cancelAction];
    
    [self.viewController presentViewController:alertController animated:YES completion:nil];
    

}



- (UIImageView *)logoImageV{
    
    if (!_logoImageV) {
        
        
#if WanApp
        _logoImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wan_login_logo"]];
#else
        _logoImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"new_login_logo"]];
#endif
        
        
        
        
        
        
        _logoImageV.userInteractionEnabled = YES;
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick)];
        
        [_logoImageV addGestureRecognizer:longPress];
    }
    return _logoImageV;
    
}

- (UIImageView *)titleImageV{
    
    if (!_titleImageV) {
        
        
        
#if WanApp
       _titleImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wan_login_title"]];
#else
        _titleImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"new_login_title"]];
#endif
        
        
        
    }
    return _titleImageV;
    
}


@end
