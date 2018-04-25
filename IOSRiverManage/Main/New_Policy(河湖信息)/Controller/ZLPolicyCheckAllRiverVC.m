//
//  ZLPolicyCheckAllRiverVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLPolicyCheckAllRiverVC.h"
#import "ZLPolicyAllRiverHeadView.h"
#import "ZLPolicyRiverInfoTableViewCell.h"
#import "ZLNewUserRiversModel.h"
#import "ZLGetNowAreaRiverListService.h"
#import "ZLRiverInfoManagerVC.h"
@interface ZLPolicyCheckAllRiverVC ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;

// 最后一个cell的数据创建时间,便于分页
@property (nonatomic, strong) NSString *lastCreateTime;

@property (nonatomic, strong) NSMutableArray *riversModelArray;

@end

@implementation ZLPolicyCheckAllRiverVC

- (void)getData{
    ZLGetNowAreaRiverListService *service = [[ZLGetNowAreaRiverListService alloc]initWithpageSize:10 appPageCreateTime:_lastCreateTime];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLNewUserRiversModel *riversModel = [[ZLNewUserRiversModel alloc]initWithString:request.responseString error:nil];
        if ([riversModel.code isEqualToString:@"0"]) {
            
            if ([self.lastCreateTime isEqualToString:@""]) {
                [self.riversModelArray removeAllObjects];
            }
            
            for (ZLNewUserRiversDataModel *riverDataModel in riversModel.data ) {
                [self.riversModelArray addObject:riverDataModel];
                
            }
            
            [self.mainTableView reloadData];
            
        }
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lastCreateTime = @"";
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    self.riversModelArray = [NSMutableArray array];
    
    [self getData];
    

    [self.view addSubview:self.mainTableView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(Main_Screen_Width);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    ZLLog(@"点击了搜索");
    return YES;
}



//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 50;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.riversModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLPolicyRiverInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLPolicyRiverInfoTableViewCell" forIndexPath:indexPath];
    ZLNewUserRiversDataModel *model = self.riversModelArray[indexPath.row];
    
    cell.detailModel = model;
    
    if (indexPath.row == self.riversModelArray.count - 1) {
        
        self.lastCreateTime = model.createTime;
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLRiverInfoManagerVC *vc = [[ZLRiverInfoManagerVC alloc]init];
    ZLNewUserRiversDataModel *model = self.riversModelArray[indexPath.row];
    vc.titleString = model.riverName;
    vc.riverCodeString = model.riverCode;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLPolicyRiverInfoTableViewCell class] forCellReuseIdentifier:@"ZLPolicyRiverInfoTableViewCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.lastCreateTime = @"";
            [self getData];
            
        }];
        
        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self getData];
            
        }];
        
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 450.0f;
        
        _mainTableView.tableFooterView = [UIView new];
        
        
//        ZLPolicyAllRiverHeadView *headView = [[ZLPolicyAllRiverHeadView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 220)];
//
//        headView.searchBar.delegate = self;
//
//        _mainTableView.tableHeaderView = headView;
        
    }
    return _mainTableView;
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"全部河道" attributes:dic];
    
    return title;
    
}
@end
