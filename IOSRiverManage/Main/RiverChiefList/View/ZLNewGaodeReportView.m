//
//  ZLNewGaodeReportView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/14.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewGaodeReportView.h"
#import "ZLRiverInfoBaseChangeTableViewCell.h"
#import "ZLRiverInfoBaseChangeAreaTableViewCell.h"
#import "ACMediaFrame.h"
#import "UIView+RoundedCorner.h"
#import "UIView+Frame.h"
@interface ZLNewGaodeReportView ()

@property (nonatomic, strong) NSArray *sourceArray;

@property (nonatomic, strong) ACSelectMediaView *mediaView;

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIView *bgView;
@end

@implementation ZLNewGaodeReportView

-(instancetype)initWithFrame:(CGRect)frame andHeight:(float)height;{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        //半透明view
        _view = [[UIView alloc] initWithFrame:self.bounds];
        _view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self addSubview:_view];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
        [_view addGestureRecognizer:tap];
        
        
        //白色底view
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, Main_Screen_Height, Main_Screen_Width, height)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.userInteractionEnabled = YES;
        [self addSubview:_bgView];
        
        [_bgView addSubview:self.mainTableView];
        [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bgView).offset(0);
            make.bottom.equalTo(_bgView.mas_bottom).offset(0);
            make.left.equalTo(_bgView);
            make.right.equalTo(_bgView.mas_right);
        }];
//        [self setUpView];
        
    }
    return self;
}

- (void)setUpView{
   

    
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
    
    if (indexPath.row == 1) {
        
        ZLRiverInfoBaseChangeAreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLRiverInfoBaseChangeAreaTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        
        ZLRiverInfoBaseChangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLRiverInfoBaseChangeTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        return cell;
        
    }
    return nil;
    
}

- (NSArray *)sourceArray{
    if (!_sourceArray) {
        _sourceArray = @[@"公示牌名：",
                         @"所在区县：",
                         @"位置："];
    }
    return _sourceArray;
}



- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLRiverInfoBaseChangeTableViewCell class] forCellReuseIdentifier:@"ZLRiverInfoBaseChangeTableViewCell"];
        [_mainTableView registerClass:[ZLRiverInfoBaseChangeAreaTableViewCell class] forCellReuseIdentifier:@"ZLRiverInfoBaseChangeAreaTableViewCell"];
        
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.showsVerticalScrollIndicator = NO;
        
        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _mainTableView.estimatedRowHeight = 100;
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        
        UIView *headerView = [[UIView alloc] init];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-10, 1)];
        lineView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        [headerView addSubview:lineView];
        
        UIView *labView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, self.frame.size.width, 50)];
        labView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:labView];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width, 30)];
        lab.text = @"公示牌照片:";
        lab.font = CHINESE_SYSTEM(15);
        [headerView addSubview:lab];
        
        
        ACSelectMediaView *mediaView = [[ACSelectMediaView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lab.frame) + 10, CGRectGetWidth(lab.frame), 1)];
        mediaView.showDelete = YES;
        mediaView.showAddButton = YES;
        mediaView.preShowMedias = @[@"http://c.hiphotos.baidu.com/image/h%3D200/sign=ad1c53cd0355b31983f9857573ab8286/279759ee3d6d55fbb02469ea64224f4a21a4dd1f.jpg", @"http://img15.3lian.com/2015/h1/280/d/5.jpg"];
        mediaView.allowMultipleSelection = NO;
        mediaView.allowPickingVideo = NO;
        mediaView.rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        self.mediaView = mediaView;
        
        
        UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(mediaView.frame) + 50, Main_Screen_Width - 20, 50)];
        
        [sureBtn setTitle:@"登录" forState:(UIControlStateNormal)];
        
        //        sureBtn.backgroundColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
        
        [mediaView observeViewHeight:^(CGFloat mediaHeight) {
            CGRect btnRect = sureBtn.frame;
            btnRect.origin.y = CGRectGetMaxY(mediaView.frame) + 50;
            sureBtn.frame = btnRect;
            
            
            CGRect rect = headerView.frame;
            rect.size.height = CGRectGetMaxY(sureBtn.frame);
            headerView.frame = rect;
            
            //            CGRect rect = headerView.frame;
            //            rect.size.height = CGRectGetMaxY(mediaView.frame);
            //            headerView.frame = rect;
        }];
        [mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel *> *list) {
            // do something
        }];
        [headerView addSubview:mediaView];
        
        [headerView addSubview:sureBtn];
        [sureBtn jm_setCornerRadius:6 withBackgroundColor:HEXCOLOR(CNAVGATIONBAR_COLOR)];
        headerView.frame = CGRectMake(0, 0, self.frame.size.width, CGRectGetMaxY(mediaView.frame));
        _mainTableView.tableFooterView = headerView;
        
    }
    return _mainTableView;
}

-(void)hideView
{
//    [self tfresignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^
     {
//         CGRect frame = self.bgView.frame;
//         frame.origin.y = frame.origin.y + CGRectGetHeight(self.frame);
//         self.bgView.frame = frame;
         
         self.bgView.centerY = self.bgView.centerY+CGRectGetHeight(self.bgView.frame);
         
         
     } completion:^(BOOL fin){
         [self removeFromSuperview];
         
     }];
    
}
-(void)showView{
    
    self.alpha = 1;
    [UIView animateWithDuration:0.25 animations:^
     {
//         CGRect frame = self.bgView.frame;
//         frame.origin.y = CGRectGetHeight(self.frame);
//         self.bgView.frame = frame;

         self.bgView.centerY = self.bgView.centerY-CGRectGetHeight(self.bgView.frame);
         
     } completion:^(BOOL fin){}];
    
}



@end
