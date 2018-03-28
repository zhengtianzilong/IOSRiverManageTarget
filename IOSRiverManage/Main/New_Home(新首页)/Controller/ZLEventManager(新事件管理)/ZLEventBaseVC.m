//
//  ZLEventBaseVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/5.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventBaseVC.h"

@interface ZLEventBaseVC ()
@end

@implementation ZLEventBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    [self.view addSubview:self.mainTableView];
    
    [self setTabViewHeadView];
}
- (void)setTabViewHeadView{
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];
    [self.mainTableView setNeedsLayout];
    [self.mainTableView layoutIfNeeded];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 1)];
    
    self.queryView = [[ZLQueryEventManageView alloc] init];
    //        con.backgroundColor = [UIColor blackColor];
    [headView addSubview:self.queryView];
    
    [self.queryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headView);
    }];
    CGFloat height = [headView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = headView.frame;
    frame.size.height = height;
    
    headView.frame = frame;
    
    _mainTableView.tableHeaderView = headView;
    
}
- (NSInteger)setSectionsCount{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self setSectionsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    ZLMyEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyEventCell" forIndexPath:indexPath];
//
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    ZLFlotillaReportModel *model = self.sourceData[indexPath.section];
    //
    //    cell.flotillaModel = model;
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLMyEventDetailVC *vc = [[ZLMyEventDetailVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 查询按钮
 */
- (void)queryButtonClick{
    
    //    if ([self.queryView.selectInfoView.startTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
    //        self.startTime = @"";
    //    }else{
    //        NSString *time = self.queryView.selectInfoView.startTimeView.selectTimeLabel.text;
    //
    //        time = [time substringToIndex:time.length - 3];
    //
    //        self.startTime = time;
    //    }
    //
    //    if ([self.queryView.selectInfoView.endTimeView.selectTimeLabel.text isEqualToString:@"请选择时间"]) {
    //        self.endTime = @"";
    //    }else{
    //        NSString *time = self.queryView.selectInfoView.endTimeView.selectTimeLabel.text;
    //
    //        time = [time substringToIndex:time.length - 3];
    //
    //        self.endTime = time;
    //    }
    //    self.boatName = self.queryView.selectInfoView.shipName.infoTextField.text;
    //
    //    if ([self.startTime isEqualToString:@""] && [self.endTime isEqualToString:@""] && [self.boatName isEqualToString:@""] ) {
    //        self.type = @"1";
    //    }else{
    //        self.type = @"2";
    //    }
    //    //    [self listData];
    //    [self.mainTableView.mj_header beginRefreshing];
}



/**
 设置cell
 */
- (void)setCell {
    [_mainTableView registerClass:[ZLMyEventCell class] forCellReuseIdentifier:@"ZLMyEventCell"];
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        
        [self setCell];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.sectionFooterHeight = 20;
        _mainTableView.sectionHeaderHeight = 0;
        _mainTableView.contentInset = UIEdgeInsetsMake(20 - 35, 0, 0, 0);
        
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight = 180;
        
        //        _mainTableView.tableHeaderView = self.queryView;
        
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
@end
