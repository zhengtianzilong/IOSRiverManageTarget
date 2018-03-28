//
//  ZLMySetupTableViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMySetupTableViewController.h"
#import "ZLLoginVC.h"
#import "ZLLoginOutService.h"
#import "ZLBaseModel.h"
#import "ZLClearCacheTool.h"
@interface ZLMySetupTableViewController ()

@end

@implementation ZLMySetupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            
            [SVProgressHUD show];
            
            if ([ZLClearCacheTool clearCaches]) {
                [SVProgressHUD showSuccessWithStatus:@"清除成功"];
                [SVProgressHUD dismissWithDelay:0.3];
            }else{
                [SVProgressHUD showErrorWithStatus:@"清除失败"];
                [SVProgressHUD dismissWithDelay:0.3];
            }
        }
            
//            [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
//
//                if (buttonIndex == 1) {
//
//
//
//            } title:@"确定清除缓存吗?" message:[NSString stringWithFormat:@"%@%@",@"缓存大小",[ZLClearCacheTool getCacheSize]]cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
//
//        }
//
    }
    
    
    if (indexPath.section == 2) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                ZLLoginVC * login =[[ZLLoginVC alloc]init];
                
                [self presentViewController:login animated:YES completion:^{
                    //                    [self removeFromParentViewController];
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
