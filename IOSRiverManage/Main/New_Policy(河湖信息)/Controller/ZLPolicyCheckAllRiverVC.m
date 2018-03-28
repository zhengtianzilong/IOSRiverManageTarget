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
@interface ZLPolicyCheckAllRiverVC ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>



@property (nonatomic, strong) UITableView *mainTableView;
@end

@implementation ZLPolicyCheckAllRiverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    

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



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLPolicyRiverInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLPolicyRiverInfoTableViewCell" forIndexPath:indexPath];
    
    //    ZLHsNotifyListDetailModel *model = self.sourceData[indexPath.row];
    //
    //    cell.detailModel = model;
    
    return cell;
    
}





- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLPolicyRiverInfoTableViewCell class] forCellReuseIdentifier:@"ZLPolicyRiverInfoTableViewCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
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
        
        
        ZLPolicyAllRiverHeadView *headView = [[ZLPolicyAllRiverHeadView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 220)];
        
        headView.searchBar.delegate = self;
        
        _mainTableView.tableHeaderView = headView;
        
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
