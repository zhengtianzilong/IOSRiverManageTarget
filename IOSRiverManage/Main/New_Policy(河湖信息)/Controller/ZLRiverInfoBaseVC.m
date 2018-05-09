//
//  ZLRiverInfoBaseVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/1/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverInfoBaseVC.h"
//#import "ZLRiverBaseInfoView.h"
#import "ZLHomeLoopTopView.h"
#import "ZLRiverInfoBaseView.h"
#import "ZLBillboardInfoView.h"

#import "ZLRiverAddIntakeVC.h"
#import "ZLRiverBilidChangeVC.h"
#import "ZLRiverIntakeInfoTableViewCell.h"
#import "ZLRiverOutletInfoTableViewCell.h"

#import "ZLRiverBaseInfoService.h"

#import "ZLRiverBaseInfoModel.h"

#import "ZLPumpingPortDeleteService.h"
#import "ZLPublicBoardDeleteService.h"

#import "ZLOutletDeleteService.h"

#import "ZLRiverInfoMapVC.h"

@interface ZLRiverInfoBaseVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) ZLHomeLoopTopView *loopTopView;

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@end

@implementation ZLRiverInfoBaseVC

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//
//    [self.mainTableView.mj_header beginRefreshing];
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sourceArray = [NSMutableArray array];
    [self getData];
    [self.view addSubview:self.mainTableView];
    
    
    
}


/**
 得到数据
 */
- (void)getData{
    
    ZLRiverBaseInfoService *service = [[ZLRiverBaseInfoService alloc]initWithriverCode:self.riverCode];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self.sourceArray removeAllObjects];
        
        ZLRiverBaseInfoModel *infoModel = [[ZLRiverBaseInfoModel alloc]initWithString:request.responseString error:nil];
        
        if ([infoModel.code isEqualToString:@"0"]) {
            
            if (infoModel.data.riverInfo.count > 0) {
                
                for (ZLRiverInfoBaseModel *baseModel in infoModel.data.riverInfo) {
                    [self.sourceArray addObject:baseModel];
                }
            }
            
            if (infoModel.data.PublicityBrand.count > 0) {
                for (ZLPublicityBrandModel *publicModel in infoModel.data.PublicityBrand) {
                    
                    [self.sourceArray addObject:publicModel];
                    
                }
            }
            
            if (infoModel.data.PumpingPort.count > 0) {
                for (ZLPumpingPortModel *pumpingPortModel in infoModel.data.PumpingPort) {
                    [self.sourceArray addObject:pumpingPortModel];
                    
                }
            }
            
            if (infoModel.data.SewageOutlet.count > 0) {
                for (ZLSewageOutletModel *sewageOutletModel in infoModel.data.SewageOutlet) {
                    [self.sourceArray addObject:sewageOutletModel];
                }
            }

        }
        
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        [self.mainTableView reloadData];
        ZLLog(@"%@",request.responseString);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        
    }];
    
    
    
}


///**
// 跳到信息编辑页面
// */
//- (void)editBtnClick{
//
//    ZLRiverInfoBaseChangeVC *vc = [[ZLRiverInfoBaseChangeVC alloc]init];
//
//    [self presentViewController:vc animated:YES completion:nil];
//
//
//
//}
//
//
///**
// 公示牌点击
// */
//- (void)billboardClick{
//    ZLRiverBilidChangeVC *vc = [[ZLRiverBilidChangeVC alloc]init];
//     [self presentViewController:vc animated:YES completion:nil];
//}
//

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}

- (void)deletePubWithModel:(ZLPublicityBrandModel *)model{
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JSONModel *model = self.sourceArray[indexPath.section];
    if (indexPath.section == 0) {
        ZLRiverInfoBaseView *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLRiverInfoBaseView" forIndexPath:indexPath];
        cell.infoBaseModel = (ZLRiverInfoBaseModel *)model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.infoBaseView = ^(ZLRiverInfoBaseModel *infoBaseModel) {
            ZLRiverInfoMapVC *mapVC = [[ZLRiverInfoMapVC alloc]init];
            
            mapVC.riverInfoBaseModel = infoBaseModel;
            mapVC.publicityBrandModel = nil;
            mapVC.sewageOutletModel = nil;
            mapVC.pumpingPortModel = nil;
            
            [self.navigationController pushViewController:mapVC animated:YES];
        };
        
        return cell;
        
    }else{
        
        if ([model.class isEqual:[ZLPublicityBrandModel class]] ) {
            ZLBillboardInfoView *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLBillboardInfoView" forIndexPath:indexPath];
            
            cell.billboardInfoAddress = ^(ZLPublicityBrandModel *publicBrandModel) {
                ZLRiverInfoMapVC *mapVC = [[ZLRiverInfoMapVC alloc]init];
                
                mapVC.publicityBrandModel = publicBrandModel;
                mapVC.riverInfoBaseModel = nil;
                mapVC.sewageOutletModel = nil;
                mapVC.pumpingPortModel = nil;
                
                [self.navigationController pushViewController:mapVC animated:YES];
            };
            
            cell.deletePublic = ^(ZLPublicityBrandModel *model) {
                
                DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"提示" message:@"确定删除此公示牌吗?" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
                
                alert.otherButtonAction = ^{
                    ZLPublicBoardDeleteService *service = [[ZLPublicBoardDeleteService alloc]initWithidCode:model.PUBLICITY_BRAND_CODE];
                    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                        ZLBaseModel *baseModel =[[ZLBaseModel alloc]initWithString:request.responseString error:nil];
                        
                        if ([baseModel.code isEqualToString:@"0"]) {
                            
                            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                            
                            [SVProgressHUD dismissWithCompletion:^{
                                [self getData];
                            }];
                        }else{
                            [SVProgressHUD showErrorWithStatus:baseModel.detail];
                            [SVProgressHUD dismiss];
                        }
                    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                        
                        [SVProgressHUD showErrorWithStatus:@"删除失败"];
                        [SVProgressHUD dismiss];
                    }];
                };
                [alert show];
                
//                [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
//                    if (buttonIndex == 1) {
//
//                    }
//
//
//                } title:@"提示" message:@"确定删除此公示牌吗?" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
            };
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.publicBrandModel = (ZLPublicityBrandModel *)model;
            return cell;
        }
        // 取水口
        if ([model.class isEqual:[ZLPumpingPortModel class]] ) {
            
            ZLRiverIntakeInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLRiverIntakeInfoTableViewCell" forIndexPath:indexPath];
            
            cell.checkAddress = ^(ZLPumpingPortModel *pumpModel) {
                ZLRiverInfoMapVC *mapVC = [[ZLRiverInfoMapVC alloc]init];
                
                mapVC.publicityBrandModel = nil;
                mapVC.riverInfoBaseModel = nil;
                mapVC.sewageOutletModel = nil;
                mapVC.pumpingPortModel = pumpModel;
                
                [self.navigationController pushViewController:mapVC animated:YES];
                
                
            };
            
            cell.deletepump = ^(ZLPumpingPortModel *pumpModel) {
              
                DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"提示" message:@"确定删除此取水口吗?" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
                
                alert.otherButtonAction = ^{
                    [SVProgressHUD showWithStatus:@"删除中"];
                    ZLPumpingPortDeleteService *service = [[ZLPumpingPortDeleteService alloc]initWithidCode:pumpModel.ID];
                    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                        
                        ZLBaseModel *baseModel =[[ZLBaseModel alloc]initWithString:request.responseString error:nil];
                        
                        if ([baseModel.code isEqualToString:@"0"]) {
                            
                            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                            
                            [SVProgressHUD dismissWithCompletion:^{
                                [self getData];
                            }];
                        }else{
                            [SVProgressHUD showErrorWithStatus:baseModel.detail];
                            [SVProgressHUD dismiss];
                            
                        }
                    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                        
                        [SVProgressHUD showErrorWithStatus:@"网络出错"];
                        [SVProgressHUD dismiss];
                    }];
                };
                [alert show];

//                [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
//                    if (buttonIndex == 1) {
//
//
//
//                    }
//
//
//                } title:@"提示" message:@"确定删除此取水口吗?" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
                
                

            };
            
            cell.pumpingPortModel = (ZLPumpingPortModel *)model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
        
        // 排污口
        if ([model.class isEqual:[ZLSewageOutletModel class]] ) {
            ZLRiverOutletInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLRiverOutletInfoTableViewCell" forIndexPath:indexPath];
            cell.outletModel = (ZLSewageOutletModel *)model;
            
            cell.sewageOutletAddress = ^(ZLSewageOutletModel *outletModel) {
                ZLRiverInfoMapVC *mapVC = [[ZLRiverInfoMapVC alloc]init];
                
                mapVC.publicityBrandModel = nil;
                mapVC.riverInfoBaseModel = nil;
                mapVC.sewageOutletModel = outletModel;
                mapVC.pumpingPortModel = nil;
                
                [self.navigationController pushViewController:mapVC animated:YES];
                
                
            };
            
            cell.outletDelete = ^(ZLSewageOutletModel *model) {
              
                DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"提示" message:@"确定删除此排污口吗?" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
                
                alert.otherButtonAction = ^{
                    [SVProgressHUD showWithStatus:@"删除中"];
                    
                    ZLOutletDeleteService *service = [[ZLOutletDeleteService alloc]initWithidCode:model.ID];
                    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                        
                        ZLBaseModel *baseModel =[[ZLBaseModel alloc]initWithString:request.responseString error:nil];
                        
                        if ([baseModel.code isEqualToString:@"0"]) {
                            
                            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                            
                            [SVProgressHUD dismissWithCompletion:^{
                                [self getData];
                            }];
                        }else{
                            [SVProgressHUD showErrorWithStatus:baseModel.detail];
                            [SVProgressHUD dismiss];
                            
                        }
                    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                        
                        [SVProgressHUD showErrorWithStatus:@"网络出错"];
                        [SVProgressHUD dismiss];
                    }];
                };
                [alert show];
                
                
                
//                [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
//                    if (buttonIndex == 1) {
//
//
//
//
//                    }
//
//
//                } title:@"提示" message:@"确定删除此排污口吗?" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
                
                
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            return cell;
            
        }
        
       
    }
    return nil;
}

- (ZLHomeLoopTopView *)loopTopView{
    
    if (!_loopTopView) {
        
        _loopTopView = [[ZLHomeLoopTopView alloc]init];
        
        
    }
    return _loopTopView;
    
}


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        
        [_mainTableView registerClass:[ZLRiverInfoBaseView class] forCellReuseIdentifier:@"ZLRiverInfoBaseView"];
        [_mainTableView registerClass:[ZLBillboardInfoView class] forCellReuseIdentifier:@"ZLBillboardInfoView"];
        
        [_mainTableView registerClass:[ZLRiverIntakeInfoTableViewCell class] forCellReuseIdentifier:@"ZLRiverIntakeInfoTableViewCell"];
        
        [_mainTableView registerClass:[ZLRiverOutletInfoTableViewCell class] forCellReuseIdentifier:@"ZLRiverOutletInfoTableViewCell"];
        
        _mainTableView.delegate = self;
        
        _mainTableView.dataSource = self;
        
        _mainTableView.tableHeaderView = [[ZLHomeLoopTopView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width / 2.0 - 15)];
        
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 150;
        
        _mainTableView.sectionFooterHeight = 20;
        _mainTableView.sectionHeaderHeight = 0;
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self getData];
            
        }];
        
    }
    return _mainTableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
