//
//  ZLDayNotifactionVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLDayNotifactionVC.h"
#import "ZLDayNotifictionTableViewCell.h"
#import "ZLNewListService.h"
#import "ZLNewListModel.h"
#import "ZLNewsDetaiVC.h"
@interface ZLDayNotifactionVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) YTKKeyValueStore *store;

@property (nonatomic, strong) NSString *areaCode;

@property (nonatomic, strong) NSMutableArray *sourceArray;

// 最后一个cell的数据创建时间,便于分页
@property (nonatomic, strong) NSString *lastCreateTime;


@end

@implementation ZLDayNotifactionVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sourceArray = [NSMutableArray array];
    
    _lastCreateTime = @"";
    
    self.store = [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
    
    NSString *tableName = DBUserTable;
    
    [self.store createTableWithName:tableName];
    _areaCode = [self.store getStringById:DBUserAreaCode fromTable:DBUserTable];
    
    [self.view addSubview:self.mainTableView];
    
    //框架方法
    self.mainTableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"empty_jd"
                                                            titleStr:@"暂无数据，点击重新加载"
                                                           detailStr:@""];
    
    self.mainTableView.ly_emptyView.autoShowEmptyView = NO;
    //emptyView内容上的点击事件监听
    __weak typeof(self)weakSelf = self;
    [self.mainTableView.ly_emptyView setTapContentViewBlock:^{
//        [weakSelf getData];
        [weakSelf.mainTableView.mj_header beginRefreshing];
        
    }];
    
    [self getData];
    
}

- (void)getData {
    
    [self.mainTableView ly_hideEmptyView];
    
    ZLNewListService *newsService = [[ZLNewListService alloc]initWithpageSize:@"10" createTime:_lastCreateTime type:@"1" areaCode:_areaCode];
    
    [newsService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLNewListModel *newListModel = [[ZLNewListModel alloc]initWithString:request.responseString error:nil];

        if ([newListModel.code isEqualToString:@"0"]) {

            if ([_lastCreateTime isEqualToString: @""]) {
                
                [_sourceArray removeAllObjects];
                
            }

            for (ZLNewListDataModel *dataModel in newListModel.data) {
                [_sourceArray addObject:dataModel];
            }
        }
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        [self.mainTableView reloadData];
        
        [self setEmpty];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        
        [self.mainTableView ly_showEmptyView];
        
    }];
}

- (void)setEmpty{
    if (self.sourceArray.count > 0) {
        [self.mainTableView ly_hideEmptyView];
    }else{
        [self.mainTableView ly_showEmptyView];
    }
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];
    
}
#pragma mark -- 列表的代理

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLDayNotifictionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLDayNotifictionTableViewCell" forIndexPath:indexPath];
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ZLNewListDataModel *dataModel = _sourceArray[indexPath.row];
    
    cell.listDataModel = dataModel;
    
    if (indexPath.row == _sourceArray.count - 1) {
        ZLNewListDataModel *dataModel = _sourceArray[indexPath.row];
        _lastCreateTime = dataModel.CREATE_TIME;
        
    }
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLNewsDetaiVC *detailVC = [[ZLNewsDetaiVC alloc]init];
    
    ZLNewListDataModel *model = self.sourceArray[indexPath.row];
    
    if (model.url != nil) {
        
        NSString *urlString = [NSString stringWithFormat:@"%@%@",SERVER_NEWS_URL,model.url];
        
        detailVC.url = urlString;
        
    }
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLDayNotifictionTableViewCell class] forCellReuseIdentifier:@"ZLDayNotifictionTableViewCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.tableFooterView = [UIView new];
        
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _lastCreateTime = @"";
            [self getData];
            
        }];
        
        _mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self getData];
            
        }];
        
    }
    return _mainTableView;
}

@end
