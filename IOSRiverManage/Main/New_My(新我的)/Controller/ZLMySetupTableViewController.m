//
//  ZLMySetupTableViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMySetupTableViewController.h"
#import "ZLLoginVC.h"
#import "ZLLoginOutService.h"
#import "ZLBaseModel.h"
#import "ZLClearCacheTool.h"
#import "ZLNewLoginModel.h"
@interface ZLMySetupTableViewController ()
@property (nonatomic, strong) YTKKeyValueStore *store;

@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;

@end

@implementation ZLMySetupTableViewController


- (IBAction)switchClick:(UISwitch *)sender {
    
    if (sender.on) {
        [GeTuiSdk setPushModeForOff:NO];
        
    }else{
        [GeTuiSdk setPushModeForOff:YES];
//        [GeTuiSdk destroy];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 1) {
            
            [SVProgressHUD show];
            
            if ([ZLClearCacheTool clearCaches]) {
                [SVProgressHUD showSuccessWithStatus:@"清除成功"];
                [SVProgressHUD dismissWithDelay:0.3];
            }else{
                [SVProgressHUD showErrorWithStatus:@"无需清理"];
                [SVProgressHUD dismissWithDelay:0.3];
            }
        }
    }
    
    
    if (indexPath.section == 1) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                ZLLoginVC * login =[[ZLLoginVC alloc]init];
                
                self.store = [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
                
                NSString *userModel = [self.store getStringById:DBLoginModel fromTable:DBUserTable];
                
                ZLNewLoginModel *loginModel = [[ZLNewLoginModel alloc]initWithString:userModel error:nil];

                [GeTuiSdk unbindAlias:loginModel.data.userId andSequenceNum:@"river" andIsSelf:false];
                
                [self.store clearTable:DBUserTable];
                [self.store clearTable:DBMapTable];
                
                [self presentViewController:login animated:YES completion:^{
                    [self removeFromParentViewController];
                    [UIApplication sharedApplication].keyWindow.rootViewController = login;
                }];
                
                
                //                ZLLoginOutService *loginOut = [[ZLLoginOutService alloc]init];
                //                [SVProgressHUD show];
                //                [loginOut startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                //
                //                    ZLLog(@"%@",request.responseString);
                //
                //                    ZLBaseModel *model = [[ZLBaseModel alloc]initWithString:request.responseString error:nil];
                //
                //                    if ([model.code isEqualToString:@"0"]) {
                //
                //                        [SVProgressHUD dismissWithCompletion:^{
                //                            [self presentViewController:login animated:YES completion:^{
                //                                //                    [self removeFromParentViewController];
                //                                [UIApplication sharedApplication].keyWindow.rootViewController = login;
                //                            }];
                //                        }];
                //                    }else{
                //                        [SVProgressHUD showErrorWithStatus:model.detail];
                //                        [SVProgressHUD dismiss];
                //                    }
                //                } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                //
                //                    [SVProgressHUD showErrorWithStatus:@"网路错误"];
                //                    [SVProgressHUD dismiss];
                //                }];
            }
            
        } title:@"提示" message:@"确定要退出登录" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
        
    }
    
    
    
}

@end
