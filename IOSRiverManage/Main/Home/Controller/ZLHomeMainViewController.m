//
//  ZLHomeMainViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/14.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLHomeMainViewController.h"
#import "ZLHomeCollectionViewLayout.h"
#import "ZLEventReportViewController.h"
#import "ZLHomeTaskTableViewCell.h"
#import "ZLHomeAddButtonMaskView.h"
#import "ZLNewsAndNotifactionViewController.h"
#import "ZLHomeLoopTopView.h"
#import "ZLHomeCenterEventView.h"
@interface ZLHomeMainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

// 河道水质信息表
//@property (nonatomic, strong) UICollectionView *mainCollectionView;

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIScrollView *mainScrollView;
@end

@implementation ZLHomeMainViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [_mainTableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpUI];

}

- (void)setUpUI{
    
    _mainScrollView = [[UIScrollView alloc]init];
    [self.view addSubview:_mainScrollView];
    [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    self.view.backgroundColor = HEXCOLOR(0xf2f0f3);
    ZLHomeLoopTopView *homeLoopImageView = [[ZLHomeLoopTopView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width,  AdaptedHeight(313) + 20)];
    
    [_mainScrollView addSubview:homeLoopImageView];
    [homeLoopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.top.mas_equalTo(64);
        make.width.mas_equalTo(Main_Screen_Width);
        make.height.mas_equalTo(AdaptedHeight(225));
        
    }];
    ZLHomeCenterEventView *centerEventView = [[ZLHomeCenterEventView alloc]init];
    [_mainScrollView addSubview:centerEventView];
//    centerEventView.clickCellBlock = ^(NSString * title) {
//        //        ZLNewsAndNotifactionViewController *vc = [[ZLNewsAndNotifactionViewController alloc]init];
//        //
//        //        [self.navigationController pushViewController:vc animated:YES];
//
//        ZLGaoDeViewController *gaode = [[ZLGaoDeViewController alloc]init];
//        [self.navigationController pushViewController:gaode animated:YES];
//
//
//        ZLLog(@"%@",title);
//
//    };
    
    //    [centerEventView.eventReportButton addTarget:self action:@selector(eventReportClick) forControlEvents:(UIControlEventTouchUpInside)];
    [centerEventView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.top.equalTo(homeLoopImageView.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(AdaptedHeight(308));
        
    }];
    
    _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    [_mainTableView registerClass:[ZLHomeTaskTableViewCell class] forCellReuseIdentifier:@"ZLHomeTaskTableViewCell"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.scrollEnabled = NO;
    [_mainScrollView addSubview:_mainTableView];
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(centerEventView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right).offset(-10);
        
    }];
    
    UIButton *button = [[UIButton alloc] init];
    button.layer.cornerRadius = 21.5;
    [button addTarget:self action:@selector(clickAddButton) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"left_touxiang"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view.mas_right).offset(-AdaptedWidth(52));
        make.bottom.equalTo(self.view.mas_bottom).offset(-AdaptedHeight(143));
        make.width.mas_equalTo(AdaptedWidth(86));
        make.height.mas_equalTo(AdaptedHeight(86));
    }];
    
    
    
    
    
//    ZLHomeLoopTopView *homeLoopImageView = [[ZLHomeLoopTopView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width,  AdaptedHeight(313) + 20)];
//
//    [_mainScrollView addSubview:homeLoopImageView];
//    [homeLoopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.view);
//        make.top.mas_equalTo(64);
//        make.width.mas_equalTo(Main_Screen_Width);
//        make.height.mas_equalTo(AdaptedHeight(225));
//
//    }];
//    ZLHomeCenterEventView *centerEventView = [[ZLHomeCenterEventView alloc]init];
//    [_mainScrollView addSubview:centerEventView];
//    centerEventView.clickCellBlock = ^(NSString * title) {
//        ZLNewsAndNotifactionViewController *vc = [[ZLNewsAndNotifactionViewController alloc]init];
//
//        [self.navigationController pushViewController:vc animated:YES];
//
//
//        ZLLog(@"%@",title);
//
//    };
//
//    [centerEventView.eventReportButton addTarget:self action:@selector(eventReportClick) forControlEvents:(UIControlEventTouchUpInside)];
//    [centerEventView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.view);
//        make.top.equalTo(homeLoopImageView.mas_bottom);
//        make.right.equalTo(self.view.mas_right);
//        make.height.mas_equalTo(AdaptedHeight(308));
//
//    }];
//
//    ZLHomeWaterQualityView *waterQulityView = [[ZLHomeWaterQualityView alloc]init];
//    [self.view addSubview:waterQulityView];
//    [waterQulityView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.view);
//        make.top.equalTo(centerEventView.mas_bottom);
//        make.width.mas_equalTo(Main_Screen_Width);
//        make.height.mas_equalTo(AdaptedHeight(105));
//        
//    }];
//    
//    ZLHomeRiverInfoTitleView *infoView = [[ZLHomeRiverInfoTitleView alloc]init];
//    [self.view addSubview:infoView];
//    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(waterQulityView.mas_bottom);
//        make.width.mas_equalTo(Main_Screen_Width);
//        make.left.equalTo(self.view);
//        make.height.mas_equalTo(AdaptedHeight(72));
//
//    }];
//    
//    ZLHomeCollectionViewLayout *layout = [[ZLHomeCollectionViewLayout alloc]init];
//    
//    NSInteger numPreRow = 2;
//    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 1*(numPreRow +1)) /numPreRow;
//
//    layout.itemSize = CGSizeMake(App_Frame_Width / 2, AdaptedHeight(88));
//    layout.minimumInteritemSpacing = 0;
//    layout.minimumLineSpacing = 0;
//    _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
//    
//    _mainCollectionView.delegate = self;
//    _mainCollectionView.dataSource = self;
//    _mainCollectionView.bounces = NO;
//    _mainCollectionView.backgroundColor = [UIColor whiteColor];
//    [_mainCollectionView registerClass:[ZLHomeWaterInfoCollectionViewCell class] forCellWithReuseIdentifier:@"ZLHomeWaterInfoCollectionViewCell"];
//    [self.view addSubview:_mainCollectionView];
//    [_mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(infoView.mas_bottom);
//        make.width.mas_equalTo(Main_Screen_Width);
//        make.left.equalTo(self.view);
//        make.height.mas_equalTo(AdaptedHeight(356));
//        
//    }];
//
//    _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
//    [_mainTableView registerClass:[ZLHomeTaskTableViewCell class] forCellReuseIdentifier:@"ZLHomeTaskTableViewCell"];
//    _mainTableView.delegate = self;
//    _mainTableView.dataSource = self;
//    _mainTableView.showsVerticalScrollIndicator = NO;
//    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _mainTableView.scrollEnabled = NO;
//    [_mainScrollView addSubview:_mainTableView];
//    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.view).offset(10);
//        make.top.equalTo(centerEventView.mas_bottom);
//        make.bottom.equalTo(self.view.mas_bottom);
//        make.right.equalTo(self.view.mas_right).offset(-10);
//
//    }];
//
//    UIButton *button = [[UIButton alloc] init];
//    button.layer.cornerRadius = 21.5;
//    [button addTarget:self action:@selector(clickAddButton) forControlEvents:UIControlEventTouchUpInside];
//    [button setImage:[UIImage imageNamed:@"left_touxiang"] forState:UIControlStateNormal];
//    [self.view addSubview:button];
//
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(self.view.mas_right).offset(-AdaptedWidth(52));
//        make.bottom.equalTo(self.view.mas_bottom).offset(-AdaptedHeight(143));
//        make.width.mas_equalTo(AdaptedWidth(86));
//        make.height.mas_equalTo(AdaptedHeight(86));
//    }];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _mainScrollView.contentSize = CGSizeMake(0, _mainTableView.frame.origin.y + _mainTableView.contentSize.height);
    
}

- (void)clickAddButton{
    ZLLog(@"点击了加号");
    ZLHomeAddButtonMaskView *maskView = [[ZLHomeAddButtonMaskView alloc]initWithFrame:CGRectMake(0, 0, App_Frame_Width, self.view.bounds.size.height)];
    
    [[UIApplication sharedApplication].keyWindow addSubview:maskView];

}

- (void)eventReportClick{
    ZLEventReportViewController *reportVC = [[ZLEventReportViewController alloc]init];
    
    [self.navigationController pushViewController:reportVC animated:YES];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(313);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 2;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return -10;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLHomeTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLHomeTaskTableViewCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    _mainScrollView.contentSize = CGSizeMake(0, tableView.frame.origin.y + tableView.contentSize.height);
//    ZLLog(@"%f", _mainScrollView.contentSize.height);
//    ZLLog(@"%ld",(long)indexPath.section);
    
}











- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return 6;
    
    
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    ZLHomeWaterInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZLHomeWaterInfoCollectionViewCell" forIndexPath:indexPath];
////    cell.backgroundColor = [UIColor redColor];
//
//    cell.layer.borderColor=HEXCOLOR(0xe3e3e3).CGColor;
//    cell.layer.borderWidth = 0.8;
    
    
    return nil;
    
    
    
}






- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"河长制移动办公" attributes:dic];
    
    return title;
    
}

- (UIButton *)set_leftButton{
    return  nil;
}





@end
