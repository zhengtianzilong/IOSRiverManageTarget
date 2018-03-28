//
//  ZLLeftViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/19.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLLeftViewController.h"
#import "ZLBaiduTrackViewController.h"
#import "UIViewController+LeftSlide.h"
#import "ZLLeftHeadView.h"
#import "ZLLeftTableViewCell.h"
#import "ZLLeftAboutViewController.h"
#import "ZLLoginViewController.h"
#import "ZLAppChangeVersionService.h"
@interface ZLLeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic,strong) NSArray *contentArr;

@property(nonatomic,strong)ZLLeftHeadView *headsView;

@end

@implementation ZLLeftViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.headsView.nameLabel.text= _loginModel.realName;
//    self.headsView.identityLabel.text=_loginModel.levelName;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    [self initSlideFoundation];
    
    //头部view的加入和设置
    self.headsView=[[ZLLeftHeadView alloc]init];
    self.headsView.backgroundColor= HEXCOLOR(KNavBarBG_color_blue);
    [self.view addSubview:self.headsView];
    
    [self.headsView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view);
        make.height.mas_equalTo(AdaptedHeight(294));
        make.width.mas_equalTo(0.7 * App_Frame_Width);
        make.top.equalTo(self.view);
        
    }];
//
//    if (![_loginModel.type isEqualToString:@"3"]) {
//        self.contentArr = @[@{@"content":@"关于系统",@"image":@"left_about"},@{@"content":@"注销登录",@"image":@"left_cancel"}];
//    }else{
//        self.contentArr = @[@{@"content":@"关于系统",@"image":@"left_about"},@{@"content":@"版本切换",@"image":@"versionChange"},@{@"content":@"注销登录",@"image":@"left_cancel"}];
//    }

    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.width.mas_equalTo(0.7 * App_Frame_Width);
        make.top.equalTo(self.headsView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
    _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, AdaptedWidth(550), App_Frame_Height+20) style:(UITableViewStylePlain)];
    
    [_mainTableView registerClass:[ZLLeftTableViewCell class] forCellReuseIdentifier:@"ZLLeftTableViewCell"];
    _mainTableView.bounces = NO;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    
    [bgView addSubview:_mainTableView];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.height.mas_equalTo(self.contentArr.count * 44);
        make.width.mas_equalTo(0.7 * App_Frame_Width);
        make.top.equalTo(self.headsView.mas_bottom);
    }];
    
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideLeftView)]];
    
}

- (void)hideLeftView{
    [self hide];
}

#pragma mark -- show or hide
- (void)showFromLeft
{
    [self show];
}




#pragma mark -- TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contentArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.contentArr[indexPath.row];
    static NSString *CellIdentifier = @"ZLLeftTableViewCell";
    ZLLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.icon.image = [UIImage imageNamed:dic[@"image"]];
    cell.contentLabel.text = dic[@"content"];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZLLog(@"%@",self.contentArr[indexPath.row][@"content"]);
    
    if ([self.contentArr[indexPath.row][@"content"] isEqualToString:@"关于系统"]) {
        ZLLeftAboutViewController *vc=[[ZLLeftAboutViewController alloc]init];
        [self.parentViewController.navigationController pushViewController:vc animated:YES];
        

    }
    
    if ([self.contentArr[indexPath.row][@"content"] isEqualToString:@"版本切换"]) {
        NSString *message = @"";
        NSString *version = @"";
//        if ([_loginModel.version isEqualToString:@"1"]) {
//            message = @"当前为基础版,确认切换为专业版?";
//            version = @"2";
//        }else{
//            message = @"当前为专业版,确认切换为基础版?";
//            version = @"1";
//        }
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
//                ZLAppChangeVersionService *changeService = [[ZLAppChangeVersionService alloc]initWithversion:version uid:_loginModel.userId];
//                [changeService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//                    NSDictionary *dic = request.responseObject;
//
//                    if ([dic[@"success"] isEqualToString:@"true"]) {
//
//                            NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//                            for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
//                                [cookieStorage deleteCookie:cookie];
//                            }
//
//                            ZLLoginViewController * login =[[ZLLoginViewController alloc]init];
//                            [UIApplication sharedApplication].keyWindow.rootViewController = login;
//                            [self.parentViewController presentViewController:login animated:YES completion:^{
//                                //                    [self removeFromParentViewController];
//                                //                    [UIApplication sharedApplication].keyWindow.rootViewController = login;
//                            }];
//                    }else{
//                        [SVProgressHUD showErrorWithStatus:@"切换失败"];
//                        [SVProgressHUD dismissWithDelay:0.5];
//                    }
//
//                } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//                    [SVProgressHUD showErrorWithStatus:@"切换失败,网络错误"];
//                    [SVProgressHUD dismissWithDelay:0.5];
//                }];
            }
            
        } title:@"提示" message:message cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
        
        
    }
    
    if ([self.contentArr[indexPath.row][@"content"] isEqualToString:@"注销登录"]) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:UDownEventObject];
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:UEventObject];
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:ULoginModel];
//                [[NSUserDefaults standardUserDefaults] synchronize];
                
                // 先将其转化为字典，然后用forin遍历删除即可
                NSUserDefaults *defatluts = [NSUserDefaults standardUserDefaults];
                NSDictionary *dictionary = [defatluts dictionaryRepresentation];
                for(NSString *key in [dictionary allKeys]){
                    [defatluts removeObjectForKey:key];
                    [defatluts synchronize];
                }
                YTKKeyValueStore *store = [[ZLDBStoreManager shareDbStoreManager]createDB];
                [store deleteObjectById:DBUserName fromTable:DBUserTable];
                [store deleteObjectById:DBPassword fromTable:DBUserTable];
                
                NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
                    [cookieStorage deleteCookie:cookie];
                }
                
                ZLLoginViewController * login =[[ZLLoginViewController alloc]init];
                [UIApplication sharedApplication].keyWindow.rootViewController = login;
                [self.parentViewController presentViewController:login animated:YES completion:^{
//                    [self removeFromParentViewController];
//                    [UIApplication sharedApplication].keyWindow.rootViewController = login;
                }];
            }
            
        } title:@"提示" message:@"确定退出登录?" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];


    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
