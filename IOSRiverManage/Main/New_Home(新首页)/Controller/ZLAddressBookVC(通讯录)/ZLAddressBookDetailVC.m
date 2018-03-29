//
//  ZLAddressBookDetailVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/4.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLAddressBookDetailVC.h"
#import "ZLAddressBookDetailTableViewCell.h"
#import "ZLNewAddressBookGetRiversService.h"
#import "ZLNewRiversByUserCodeModel.h"
@interface ZLAddressBookDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *sourceArray;
@end

@implementation ZLAddressBookDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    
    [self.view addSubview:self.mainTableView];
    
    //框架方法
    self.mainTableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"empty_jd"
                                                            titleStr:@"暂无数据，点击重新加载"
                                                           detailStr:@""];
    //emptyView内容上的点击事件监听
    __weak typeof(self)weakSelf = self;
    [self.mainTableView.ly_emptyView setTapContentViewBlock:^{
        [weakSelf getData];
    }];
    
    [self getData];
    
  
    
    
}

#pragma mark - -------
- (void)getData {
    
    [SVProgressHUD show];
    ZLNewAddressBookGetRiversService *riversService = [[ZLNewAddressBookGetRiversService alloc]initWithUserCode:_addressModelDataModel.userCode];
//    _dataSource = [NSMutableArray array];
    [riversService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLNewRiversByUserCodeModel *userRiversModel = [[ZLNewRiversByUserCodeModel alloc]initWithString:request.responseString error:nil];

        if ([userRiversModel.code isEqualToString:@"0"]) {
            _dataArray = @[
                           @"河长职务",
                           @"行政职务",
                           @"电话",
                           @"座机",
                           @"所管河道"
                           ];
            
            if (_addressModelDataModel.dutyName == nil) {
                _addressModelDataModel.dutyName = @"";
            }
            if (_addressModelDataModel.job == nil) {
                _addressModelDataModel.job = @"";
            }
            if (_addressModelDataModel.phone == nil) {
                _addressModelDataModel.phone = @"";
            }
            if (_addressModelDataModel.telephone == nil) {
                _addressModelDataModel.telephone = @"";
            }
            if (_addressModelDataModel.rivers == nil) {
                _addressModelDataModel.rivers = @"";
            }
            _sourceArray = @[
                             _addressModelDataModel.dutyName,
                             _addressModelDataModel.job,
                             _addressModelDataModel.phone,
                             _addressModelDataModel.telephone,
                             userRiversModel.data
                             ];
            
        }

        
        [self.mainTableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [SVProgressHUD dismiss];
    }];
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
//        make.height.mas_equalTo(Main_Screen_Height);
    }];
    
}
#pragma mark -- 列表的代理

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 55;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLAddressBookDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLAddressBookDetailTableViewCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = _dataArray[indexPath.row];
    cell.detailLabel.text = _sourceArray[indexPath.row];
    return cell;
    
}
- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLAddressBookDetailTableViewCell class] forCellReuseIdentifier:@"ZLAddressBookDetailTableViewCell"];
        
        _mainTableView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.bounces = NO;
        _mainTableView.userInteractionEnabled = NO;
        
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 55;
        _mainTableView.tableFooterView = [UIView new];
    }
    return _mainTableView;
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:_addressModelDataModel.realName attributes:dic];
    
    return title;
    
}


@end
