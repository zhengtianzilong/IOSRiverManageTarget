//
//  ZLScoreDetailVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLScoreDetailVC.h"
#import "ZLScoreDetailView.h"
#import "ZLScoreBottomView.h"
#import "ZLGetScoreDataModel.h"
#import "ZLCommitMyScoreService.h"
@interface ZLScoreDetailVC ()
@property (nonatomic, strong) ZLScoreDetailView *detailView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@end

@implementation ZLScoreDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainScrollView];
    
    [self.mainScrollView addSubview:self.detailView];
    
//    _detailView.noModel = self.noModel;
    
    ZLScoreBottomView *bottomView = [[ZLScoreBottomView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 60 * kScreenHeightRatio - TopBarHeight, Main_Screen_Width, 60 * kScreenHeightRatio) withTitles:@[@"保存",@"提交"]];
    
    [bottomView.saveButton addTarget:self action:@selector(saveClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [bottomView.reportButton addTarget:self action:@selector(commitClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    [self.view addSubview:bottomView];
    
    bottomView.hidden = !_isShowBottomView;
    
}


- (void)reporeServiceWithflag:(NSString *)flag withStatus:(NSString *)status{
    BOOL isCommit = YES;
    
    for (ZLGetScoreDetailArrayModel *rowModel in _detailView.sourceArray) {
        // 判断是不是输入完全部分值了
        for (ZLGetScoreDetailModel *detailModel in rowModel.list) {
            
            if (!([detailModel.type isEqualToString:@"2"] || [detailModel.type isEqualToString:@"3"])) {
                if ( detailModel.selfComment == nil || [detailModel.selfComment isEqualToString:@""]) {
                    isCommit = NO;
                }
            }
        }
    }
    
    if (isCommit) {
        
        ZLCommitMyScoreService *commitService = [[ZLCommitMyScoreService alloc]initWithArray:_detailView.sourceArray managerDetailCode:self.noModel.managerDetailCode modelCode:self.noModel.managerCode flag:flag];
        [SVProgressHUD showWithStatus:status];
        [commitService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            ZLBaseModel *model = [[ZLBaseModel alloc]initWithString:request.responseString error:nil];
            
            if ([model.code isEqualToString:@"0"]) {
                
                [SVProgressHUD showSuccessWithStatus:@"成功"];
                
                [SVProgressHUD dismissWithDelay:0.4 completion:^{
                    
                    [self backClick];
                    
                }];
            }else{
                
                [SVProgressHUD showErrorWithStatus:model.detail];
                [SVProgressHUD dismissWithDelay:0.6];
                
            }
            ZLLog(@"%@", request.responseString);
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
            [SVProgressHUD dismissWithDelay:0.3];
        }];
        
    }else{
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 0) {
                return ;
                
            }
            
        } title:@"提示" message:@"还有未输入的分值" cancelButtonName:@"取消" otherButtonTitles:nil, nil];
        
    }
}

- (void)commitClick{
    
    [self reporeServiceWithflag:@"saveAndSub" withStatus:@"提交中"];
    ZLLog(@"%@", _detailView.sourceArray);
    
    
    
}
- (void)saveClick{
    [self reporeServiceWithflag:@"save" withStatus:@"保存中"];
}


- (void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.equalTo(self.view);
        
        make.left.right.top.bottom.equalTo(self.view);
        
    }];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        //设置边距相对于scrollView的约束
        //（自己的见解：contentView的edges相对scrollView的edges的约束  contentView实际上被拉伸的宽高是相对于scrollView的contentSize的）
        make.edges.equalTo(self.mainScrollView);
        
        //        make.top.equalTo(self.mainScrollView);
        //
        //        make.bottom.equalTo(self.mainScrollView.mas_bottom);
        //        //因为上面的宽高是相对于contentSize的  所以为0  这里需要设置contentView的宽度约束后  scrollView的contentSize.width就会拉伸
        make.width.equalTo(self.mainScrollView);
        
        //        make.left.equalTo(self.view);
        //        make.right.equalTo(self.view.mas_right);
        //        make.top.equalTo(self.view);
        ////        make.bottom.equalTo(self.mainScrollView.mas_bottom);
        //
        //        make.height.mas_equalTo(Main_Screen_Height);
        
        
        
    }];
    
    
    // 设置过渡视图的底边距（此设置将影响到scrollView的contentSize）
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.detailView.mas_bottom);
    }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"评分" attributes:dic];
    
    return title;
    
}

- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]init];
        _mainScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _mainScrollView;
}

- (ZLScoreDetailView *)detailView{
    if (!_detailView) {
        _detailView = [[ZLScoreDetailView alloc]initWithModel:self.noModel];
        
    }
    return _detailView;
}



@end
