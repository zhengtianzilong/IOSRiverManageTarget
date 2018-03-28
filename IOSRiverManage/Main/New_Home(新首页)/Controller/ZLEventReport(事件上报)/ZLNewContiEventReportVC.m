//
//  ZLNewContiEventReportVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/23.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewContiEventReportVC.h"
#import "ZLReportEventDesTableViewCell.h"
#import "ZLReportPeopleTableViewCell.h"
#import "ZLReprotEventBaseTableViewCell.h"
#import "ACMediaFrame.h"
#import "UIView+RoundedCorner.h"
#import "ZLMyAdviseBottomView.h"
@interface ZLNewContiEventReportVC ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSArray *sourceArray;

@property(nonatomic, strong) NSArray *placeHolderArray;

@property (nonatomic, strong) ACSelectMediaView *mediaView;

@end

@implementation ZLNewContiEventReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    return self.sourceArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    return self.sourceData.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.row == 0) {
        
        
        ZLReportPeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLReportPeopleTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        
        cell.imageV.image = [UIImage imageNamed:@"home_seletPeople"];
        
        cell.selectInfo = ^(UITextView *infoTextView) {
            
        };
        
        return cell;
    }
    
    if (indexPath.row == 1) {
        
        
        ZLReportPeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLReportPeopleTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        cell.imageV.image = [UIImage imageNamed:@"home_seletPeople"];
        cell.selectInfo = ^(UITextView *infoTextView) {
            
        };
        return cell;
    }
    if (indexPath.row == 2) {
        ZLReportEventDesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLReportEventDesTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        
        return cell;
    }
    
    
    return nil;
    
}

- (NSArray *)sourceArray{
    if (!_sourceArray) {
        _sourceArray = @[
                         @"接收人:",
                         @"接收部门:",
                         @"反馈:"];
        
        
    }
    return _sourceArray;
}

- (NSArray *)placeHolderArray{
    if (!_placeHolderArray) {
        _placeHolderArray = @[
                              @"请选择接收人",
                              @"请选择接收部门",
                              @"请输入描述内容(140字以内)"];
        
        
    }
    return _placeHolderArray;
}


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        [_mainTableView registerClass:[ZLReportPeopleTableViewCell class] forCellReuseIdentifier:@"ZLReportPeopleTableViewCell"];
        [_mainTableView registerClass:[ZLReportEventDesTableViewCell class] forCellReuseIdentifier:@"ZLReportEventDesTableViewCell"];
        
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.showsVerticalScrollIndicator = NO;
        
        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _mainTableView.estimatedRowHeight = 100;
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        
        UIView *headerView = [[UIView alloc] init];
        ACSelectMediaView *mediaView = [[ACSelectMediaView alloc] initWithFrame:CGRectMake(0,  0, self.view.frame.size.width, 1)];
        mediaView.showDelete = YES;
        mediaView.showAddButton = YES;
        //png、jpg、gif(本地和网络)
        
        //        //预展示视频
        //        ACMediaModel *md = [ACMediaModel new];
        //        md.mediaURL = [NSURL URLWithString:@"http://baobab.wdjcdn.com/1451897812703c.mp4"];
        //        md.isVideo = YES;
        //        //封面
        //        md.image = [UIImage imageNamed:@"memory"];
        
        mediaView.preShowMedias = @[@"http://c.hiphotos.baidu.com/image/h%3D200/sign=ad1c53cd0355b31983f9857573ab8286/279759ee3d6d55fbb02469ea64224f4a21a4dd1f.jpg", @"http://img15.3lian.com/2015/h1/280/d/5.jpg"];
        mediaView.allowMultipleSelection = NO;
        mediaView.allowPickingVideo = YES;
        mediaView.rootViewController = self;
        self.mediaView = mediaView;
        
        
        ZLMyAdviseBottomView *bottomView = [[ZLMyAdviseBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mediaView.frame) + 50, Main_Screen_Width, 50 * kScreenHeightRatio) withTitles:@[@"继续上报",@"取消上报"]];
        [bottomView.endButton setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
        bottomView.endButton.backgroundColor = [UIColor whiteColor];
        
        
        [mediaView observeViewHeight:^(CGFloat mediaHeight) {
            CGRect btnRect = bottomView.frame;
            btnRect.origin.y = CGRectGetMaxY(mediaView.frame) + 50;
            bottomView.frame = btnRect;
            CGRect rect = headerView.frame;
            rect.size.height = CGRectGetMaxY(bottomView.frame);
            headerView.frame = rect;
            
            [_mainTableView beginUpdates];
            [_mainTableView endUpdates];
        }];
        [mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel *> *list) {
            // do something
        }];
        [headerView addSubview:mediaView];
        
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
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"继续上报" attributes:dic];
    
    return title;
    
}

@end
