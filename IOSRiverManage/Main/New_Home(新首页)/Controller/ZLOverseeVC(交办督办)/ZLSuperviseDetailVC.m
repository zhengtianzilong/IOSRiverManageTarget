//
//  ZLSuperviseDetailVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLSuperviseDetailVC.h"
#import "ZLSuperviseHeadView.h"
#import "ZLSuperviseFooterView.h"
#import "ZLSuperViseDetailTableViewCell.h"
#import "ZLSuperviseDetailService.h"
#import "ZLMyEventAdviseVC.h"
#import "ZLSuperviseDetailModel.h"
@interface ZLSuperviseDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, strong) NSMutableArray *headAndFooterArray;


@end

@implementation ZLSuperviseDetailVC

- (void)getData {
    
    ZLSuperviseDetailService *service = [[ZLSuperviseDetailService alloc]initWithCode:self.code];;
    
//    [self.mainTableView ly_startLoading];
     [_mainTableView ly_hideEmptyView];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLSuperviseDetailModel *model = [[ZLSuperviseDetailModel alloc]initWithString:request.responseString error:nil];
        
        if ([model.code isEqualToString:@"0"]) {
            
            [self.sourceArray addObject:model.data.superviseTask];
            
            for (ZLAssignTaskDetailDataModel *dataModel in model.data.assignTaskList) {
                
                [self.sourceArray addObject:dataModel];
                
            }
            
            [self.sourceArray addObject:model.data.superviseTask];
        }
        
        [self.mainTableView reloadData];
        
        [self setEmpty];
        
//        [self.mainTableView ly_endLoading];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.mainTableView reloadData];
//        [self.mainTableView ly_endLoading];
         [_mainTableView ly_showEmptyView];
    }];
}

- (void)setEmpty{
    if (self.sourceArray.count > 0) {
        [self.mainTableView ly_hideEmptyView];
    }else{
        [self.mainTableView ly_showEmptyView];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sourceArray = [NSMutableArray array];
    self.headAndFooterArray = [NSMutableArray array];
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    
    [self setEmpty];
    
    [self.view addSubview:self.mainTableView];
    
    [self getData];
    
    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];
    
    
    
}






#pragma mark -- 列表的代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    return self.sourceData.count;
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
    
        ZLSuperviseHeadView *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLSuperviseHeadView" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ZLSuperviseDetailDataModel *dataModel = self.sourceArray[indexPath.row];
        
        cell.detailModel = dataModel;
        
        return cell;
        
    }else if(indexPath.row == self.sourceArray.count - 1) {
        
        ZLSuperviseFooterView *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLSuperviseFooterView" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ZLSuperviseDetailDataModel *dataModel = self.sourceArray[indexPath.row];
        
        cell.detailModel = dataModel;
        
        return cell;
        
        
    }else{
        ZLSuperViseDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLSuperViseDetailTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ZLAssignTaskDetailDataModel *dataModel = self.sourceArray[indexPath.row];
        cell.detailModel = dataModel;
        
        return cell;
        
        
    }
    
    return nil;
    
    
}



- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLSuperviseHeadView class] forCellReuseIdentifier:@"ZLSuperviseHeadView"];
        [_mainTableView registerClass:[ZLSuperviseFooterView class] forCellReuseIdentifier:@"ZLSuperviseFooterView"];
        [_mainTableView registerClass:[ZLSuperViseDetailTableViewCell class] forCellReuseIdentifier:@"ZLSuperViseDetailTableViewCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 200;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.bounces = NO;
        //框架方法
        _mainTableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"empty_jd"
                                                                titleStr:@"暂无数据，点击重新加载"
                                                               detailStr:@""];
        _mainTableView.ly_emptyView.autoShowEmptyView = NO;
        
        //emptyView内容上的点击事件监听
        __weak typeof(self)weakSelf = self;
        [_mainTableView.ly_emptyView setTapContentViewBlock:^{
            [weakSelf getData];
        }];
        
        
    }
    return _mainTableView;
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"督办详情" attributes:dic];
    
    return title;
    
}


@end
