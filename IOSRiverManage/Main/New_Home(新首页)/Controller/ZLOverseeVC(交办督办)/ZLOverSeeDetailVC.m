//
//  ZLOverSeeDetailVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/6.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLOverSeeDetailVC.h"
#import "ZLOverSeeDetailTableViewCell.h"
#import "ZLAssignTaskDetailService.h"
#import "ZLMyEventAdviseVC.h"
#import "ZLAssignTaskDetailModel.h"
@interface ZLOverSeeDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *sourceArray;



@end

@implementation ZLOverSeeDetailVC

- (void)getData {
    [_mainTableView ly_hideEmptyView];
    ZLAssignTaskDetailService *service = [[ZLAssignTaskDetailService alloc]initWithCode:self.code];;
    
    [self.mainTableView ly_startLoading];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLAssignTaskDetailModel *model = [[ZLAssignTaskDetailModel alloc]initWithString:request.responseString error:nil];

        if ([model.code isEqualToString:@"0"]) {
            
            [self.sourceArray addObject:model.data];
        }
        
        [self.mainTableView reloadData];
        
        [self.mainTableView ly_endLoading];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.mainTableView reloadData];
        [self.mainTableView ly_endLoading];
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
    
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    
    [self.view addSubview:self.mainTableView];
    
   [self setEmpty];
    
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
    ZLOverSeeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLOverSeeDetailTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZLAssignTaskDetailDataModel *dataModel = self.sourceArray[indexPath.row];
    
    cell.detailModel = dataModel;
    
    if ([self.status isEqualToString:@"1"]) {
        
        cell.state.text = @"超时";
        
    }else{
        if ([dataModel.assignStatus isEqualToString:@"2"]) {
            
            cell.state.text = @"已反馈";
            
        }
        if ([dataModel.assignStatus isEqualToString:@"9"]) {
            
            cell.state.text = @"已完成";
            
        }
        if ([dataModel.assignStatus isEqualToString:@"3"]) {
            
            cell.state.text = @"督办中";
            
        }
        if ([dataModel.assignStatus isEqualToString:@"0"]) {
            
            cell.state.text = @"未交办";
            
        }
        if ([dataModel.assignStatus isEqualToString:@"1"]) {
            
            cell.state.text = @"交办中";
            
        }
    }
    
    
    
    return cell;
    
    
}



- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLOverSeeDetailTableViewCell class] forCellReuseIdentifier:@"ZLOverSeeDetailTableViewCell"];
    
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 60;
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
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"交办详情" attributes:dic];
    
    return title;
    
}


@end
