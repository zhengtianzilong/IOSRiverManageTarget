//
//  ZLMyventDealDetailVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyventDealDetailVC.h"
#import "ZLMyEventDealDetailCell.h"
#import "ZLMyEventAdviseVC.h"
#import "ZLMyAdviseBottomView.h"
#import "ZLNewContiEventReportVC.h"
#import "ZLMyEventAdviseVC.h"

@interface ZLMyventDealDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;


@end

@implementation ZLMyventDealDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    
    [self.view addSubview:self.mainTableView];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];

    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    
    
    
}




#pragma mark -- 列表的代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    return self.sourceData.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLMyEventDealDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyEventDealDetailCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)startButtonClick{
    
    ZLNewContiEventReportVC *vc = [[ZLNewContiEventReportVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

/**
 事件反馈
 */
- (void)endButtonClick{
    ZLMyEventAdviseVC *vc = [[ZLMyEventAdviseVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLMyEventDealDetailCell class] forCellReuseIdentifier:@"ZLMyEventDealDetailCell"];
        
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 100;
        
        UIView *headerView = [[UIView alloc] init];

        headerView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        ZLMyAdviseBottomView *bottomView = [[ZLMyAdviseBottomView alloc]initWithFrame:CGRectMake(0, 50, Main_Screen_Width, 50 * kScreenHeightRatio)withTitles:@[@"继续上报", @"事件反馈"]];
        
        [bottomView.startButton addTarget:self action:@selector(startButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        [bottomView.endButton addTarget:self action:@selector(endButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        [headerView addSubview:bottomView];
        headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, CGRectGetMaxY(bottomView.frame));
        _mainTableView.tableFooterView = headerView;
    }
    return _mainTableView;
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"事件处理" attributes:dic];
    return title;
    
    
}

@end
