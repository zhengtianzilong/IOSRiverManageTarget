//
//  ZLPolicyVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLPolicyVC.h"
#import "ZLPolicyRiverHeadView.h"
#import "ZLPolicyRiverInfoTableViewCell.h"
#import "ZLPolicyRiverQualityDescriptionVC.h"
#import "ZLPolicyCheckAllRiverVC.h"
#import "ZLRiverInfoManagerVC.h"

#import "ZLNewUserRiversModel.h"

@interface ZLPolicyVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) ZLPolicyRiverHeadView *headView;

@property (nonatomic, strong) YTKKeyValueStore *store;

@property (nonatomic, strong) NSMutableArray *riversTitleArray;

@property (nonatomic, strong) NSMutableArray *riversModelArray;

@end

@implementation ZLPolicyVC

/**
 得到河道数据
 */
- (void)getRiversData{
    self.riversModelArray = [NSMutableArray array];
    
    self.store = [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
    
    NSString *tableName = DBUserTable;
    
    [self.store createTableWithName:tableName];
    NSString *rivers = [self.store getStringById:DBUserRivers fromTable:DBUserTable];
    
    ZLNewUserRiversModel *riversModel = [[ZLNewUserRiversModel alloc]initWithString:rivers error:nil];
    
    if (riversModel.data.count > 0) {
        
        for (ZLNewUserRiversDataModel *riverDataModel in riversModel.data ) {
            [self.riversModelArray addObject:riverDataModel];
            
        }
        
        [self.mainTableView reloadData];
        
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.mainTableView];
    
    [self getRiversData];
    
    
    
    [self setTabViewHeadView];
    [_headView.riverInfoView.watchAllButton addTarget:self action:@selector(checkAllRiver) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_headView.riverCategoryView.riverInfoButton addTarget:self action:@selector(riverQualityDescriptionClick) forControlEvents:(UIControlEventTouchUpInside)];

}


- (void)setTabViewHeadView{
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];
    [self.mainTableView setNeedsLayout];
    [self.mainTableView layoutIfNeeded];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 1)];
    
    self.headView = [[ZLPolicyRiverHeadView alloc] init];
    [headView addSubview:self.headView];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headView);
    }];
    CGFloat height = [headView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = headView.frame;
    frame.size.height = height;
    
    headView.frame = frame;
    
    _mainTableView.tableHeaderView = headView;
    
}



/**
 水质类别说明
 */
- (void)riverQualityDescriptionClick{
    
    ZLPolicyRiverQualityDescriptionVC *vc = [[ZLPolicyRiverQualityDescriptionVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

/**
 查看所有河道
 */
- (void)checkAllRiver{
    ZLPolicyCheckAllRiverVC *vc = [[ZLPolicyCheckAllRiverVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.riversModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLPolicyRiverInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLPolicyRiverInfoTableViewCell" forIndexPath:indexPath];
    
    ZLNewUserRiversDataModel *model = self.riversModelArray[indexPath.row];

    cell.detailModel = model;
    
//    cell.detailModel = model;
    
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
        
        _mainTableView.tableHeaderView = self.headView;
        
        _mainTableView.tableFooterView = [UIView new];
        
//        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//            _requestStart = 1;
//            [self listData];
//
//        }];
//
//        _mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            _requestStart += 1;
//            [self listData];
//
//        }];
        
        
    }
    return _mainTableView;
}

//- (ZLPolicyRiverHeadView *)headView{
//    if (!_headView) {
//
//        _headView = [[ZLPolicyRiverHeadView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 230)];
//
//        [_headView.riverInfoView.watchAllButton addTarget:self action:@selector(checkAllRiver) forControlEvents:(UIControlEventTouchUpInside)];
//
//        [_headView.riverCategoryView.riverInfoButton addTarget:self action:@selector(riverQualityDescriptionClick) forControlEvents:(UIControlEventTouchUpInside)];
//
//    }
//    return _headView;
//
//}


- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"河湖信息" attributes:dic];
    
    return title;
    
}
- (UIButton *)set_leftButton{
    return  nil;
}


@end
