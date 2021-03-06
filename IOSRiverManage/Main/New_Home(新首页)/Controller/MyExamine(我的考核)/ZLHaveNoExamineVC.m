//
//  ZLHaveNoExamineVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/15.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLHaveNoExamineVC.h"
#import "ZLMyExamineBaseTableViewCell.h"
#import "ZLScoreDetailVC.h"
#import "ZLHaveNoExamineArrayModel.h"
#import "ZLHaveNoExamineService.h"
#import "ZLCommitMyScoreService.h"
#import "ZLScoreDeatilsVC.h"
@interface ZLHaveNoExamineVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, strong) UITableView *mainTableView;

@end
@implementation ZLHaveNoExamineVC

- (void)getData {
    ZLHaveNoExamineService *service = [[ZLHaveNoExamineService alloc]init];

    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {

        ZLLog(@"%@",request.responseString);

        ZLHaveNoExamineArrayModel *model = [[ZLHaveNoExamineArrayModel alloc]initWithString:request.responseString error:nil];

        if ([model.code isEqualToString:@"0"]) {

            [_sourceArray removeAllObjects];

            for (ZLHaveNoExamineModel *dataModel in model.data) {
                [_sourceArray addObject:dataModel];
            }
        }

        [self.mainTableView reloadData];
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.mainTableView.mj_header beginRefreshing];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sourceArray = [NSMutableArray array];
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    [self.view addSubview:self.mainTableView];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    
//    [self getData];
    
}





#pragma mark -- 列表的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLMyExamineBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyExamineBaseTableViewCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ZLHaveNoExamineModel *noModel = self.sourceArray[indexPath.section];
    
    cell.noExamineModel = noModel;
    
    cell.commitClick = ^(ZLHaveNoExamineModel *model) {
      
        DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"提示" message:@"确认提交吗?" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
        
        alert.otherButtonAction = ^{
            ZLCommitMyScoreService *commitService = [[ZLCommitMyScoreService alloc]initWithArray:nil managerDetailCode:model.managerDetailCode modelCode:model.managerCode flag:@"sub"];
            [SVProgressHUD showWithStatus:@"提交中"];
            [commitService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                
                ZLBaseModel *model = [[ZLBaseModel alloc]initWithString:request.responseString error:nil];
                
                if ([model.code isEqualToString:@"0"]) {
                    
                    [SVProgressHUD showSuccessWithStatus:@"成功"];
                    
                    [SVProgressHUD dismissWithDelay:0.4 completion:^{
                        [self getData];
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
        
        };
        [alert show];
    };
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
//    ZLScoreDetailVC *vc = [[ZLScoreDetailVC alloc]init];
    
    ZLScoreDeatilsVC *vc = [[ZLScoreDeatilsVC alloc]init];
    
    ZLHaveNoExamineModel *noModel = self.sourceArray[indexPath.section];
    
    vc.noModel = noModel;
    
    vc.isShowBottomView = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}




- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        
        [_mainTableView registerClass:[ZLMyExamineBaseTableViewCell class] forCellReuseIdentifier:@"ZLMyExamineBaseTableViewCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.sectionFooterHeight = 20;
        _mainTableView.sectionHeaderHeight = 0;
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 180;
        
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self getData];

        }];
//
//        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            //            _requestStart += 1;
//            [self getData];
//
//        }];
        
    }
    return _mainTableView;
}

@end
