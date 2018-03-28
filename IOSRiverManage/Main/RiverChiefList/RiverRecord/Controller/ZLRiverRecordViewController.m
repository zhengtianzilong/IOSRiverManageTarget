//
//  ZLRiverRecordViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/25.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLRiverRecordViewController.h"
#import "ZLRiverRecordView.h"
#import "ZLRiverRecordCell.h"
#import "ZLGaodeDetailViewController.h"
@interface ZLRiverRecordViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) ZLRiverRecordView *recordView;
@end

@implementation ZLRiverRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _recordView = [[ZLRiverRecordView alloc]init];
    
    [self.view addSubview:_recordView];
    
    [self.view addSubview:self.mainTableView];
    
    
    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [_recordView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(Main_Screen_Height * 0.38);
        
    }];
    
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_recordView.mas_bottom).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLRiverRecordCell *cell = (ZLRiverRecordCell *)[tableView dequeueReusableCellWithIdentifier:@"ZLRiverRecordCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.kilometres.text = @"10公里";
    cell.totalTime.text = @"60分钟";
    cell.startTime.text = @"2017-10-13 09:20";
    cell.titleLabel.text = @"莫愁湖河段";
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLGaodeDetailViewController *detailVC = [[ZLGaodeDetailViewController alloc]init];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}


- (UITableView *)mainTableView{
    
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        [_mainTableView registerClass:[ZLRiverRecordCell class] forCellReuseIdentifier:@"ZLRiverRecordCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor lightGrayColor];
    }
    return _mainTableView;
    
}


- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"巡河记录" attributes:dic];
    
    return title;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
