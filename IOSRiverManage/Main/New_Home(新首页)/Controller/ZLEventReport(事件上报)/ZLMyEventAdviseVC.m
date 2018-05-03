//
//  ZLMyEventAdviseVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyEventAdviseVC.h"
#import "ZLReportEventDesTableViewCell.h"
#import "ZLNewFilesUpLoadService.h"
#import "ZLUploadImagesModel.h"
#import "ACMediaFrame.h"
#import "ZLFeedbackIncidentForApp.h"
#import "ZLMyAdviseBottomView.h"
#import "ZLEventManagerVC.h"
@interface  ZLMyEventAdviseVC()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) ACSelectMediaView *mediaView;
@property (nonatomic, strong) NSArray *sourceArray;

@property(nonatomic, strong) NSArray *placeHolderArray;
@property (nonatomic, strong) NSArray<ACMediaModel *> *imageArray;

@property (nonatomic, strong) NSMutableArray *imageNameArray;
@property (nonatomic, strong) NSString *eventDesc;
@end

@implementation ZLMyEventAdviseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = HEXCOLOR(0xf4f4f4);
    
    self.imageArray = [NSArray array];
    self.imageNameArray = [NSMutableArray array];
    
    [self.view addSubview:self.mainTableView];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    return self.sourceData.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ZLReportEventDesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLReportEventDesTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        
        cell.infoTextView.tag = indexPath.row;
        
        cell.getText = ^(NSString *text, NSInteger tag) {
            switch (0) {
                case 0:
                    self.eventDesc = text;
                    break;
            }
        };
        return cell;
    }
    return nil;
}

- (NSArray *)sourceArray{
    if (!_sourceArray) {
        _sourceArray = @[
                         @"反馈:"];
        
        
    }
    return _sourceArray;
}

- (NSArray *)placeHolderArray{
    if (!_placeHolderArray) {
        _placeHolderArray = @[@"请输入描述内容(140字以内)"];
        
        
    }
    return _placeHolderArray;
}

/**
 检测文本框的内容
 */
- (BOOL)checkTextFieldContent{
    if ([self.eventDesc isEqualToString:@""]) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"请填写描述内容" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return NO;
    }
    return YES;
}


/**
 保存按钮
 */
- (void)reportClick{
    if (![self checkTextFieldContent]) {
        return;
    }
    [SVProgressHUD showWithStatus:@"反馈中"];
    
    dispatch_group_t group = dispatch_group_create();
    
    ZLNewFilesUpLoadService *filesService = [[ZLNewFilesUpLoadService alloc]initWithImage:_imageArray];
    
    dispatch_group_enter(group);
    
    [filesService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLUploadImagesModel *imagesModel = [[ZLUploadImagesModel alloc]initWithString:request.responseString error:nil];
        if ([imagesModel.code isEqualToString:@"0"]) {
            
            for (ZLTaskInfoImageListModel *model in imagesModel.data) {
                [self.imageNameArray addObject:model.toDictionary];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:imagesModel.detail];
            [SVProgressHUD dismissWithDelay:0.3];
        }
        ZLLog(@"%@", request.responseString);
        dispatch_group_leave(group);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        [SVProgressHUD dismissWithDelay:0.3];
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        ZLLog(@"%@", self.imageNameArray);
        
        
        ZLFeedbackIncidentForApp *service = [[ZLFeedbackIncidentForApp alloc]initWithimgList:self.imageNameArray fileListDetail:@[]  eventDetailId:_eventDetailId feedbackContent:_eventDesc];
        
        [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            ZLLog(@"%@", request.responseString);
            ZLBaseModel *model = [[ZLBaseModel alloc]initWithString:request.responseString error:nil];
            if ([model.code isEqualToString:@"0"]) {
                [SVProgressHUD showSuccessWithStatus:@"反馈成功"];
                [SVProgressHUD dismissWithDelay:0.3 completion:^{
                    for (UIViewController *vc in self.navigationController.childViewControllers) {
                        if ([vc isKindOfClass:[ZLEventManagerVC class]]) {
                            ZLEventManagerVC *mainVC = (ZLEventManagerVC *)vc;
                            [self.navigationController popToViewController:mainVC animated:NO];
                        }
                    }
                }];
            }else{
                [SVProgressHUD showErrorWithStatus:model.detail];
                [SVProgressHUD dismissWithDelay:0.3];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
            [SVProgressHUD dismissWithDelay:0.3];
        }];
    });
}




- (void)endClick{
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 1) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        
    } title:@"提示" message:@"确定取反馈吗?" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
    
}



- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        [_mainTableView registerClass:[ZLReportEventDesTableViewCell class] forCellReuseIdentifier:@"ZLReportEventDesTableViewCell"];
        
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.bounces = NO;
        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _mainTableView.estimatedRowHeight = 100;
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        
        UIView *headerView = [[UIView alloc] init];
        ACSelectMediaView *mediaView = [[ACSelectMediaView alloc] initWithFrame:CGRectMake(0,  0, self.view.frame.size.width, 1)];
        mediaView.showDelete = YES;
        mediaView.showAddButton = YES;
        mediaView.allowMultipleSelection = NO;
        mediaView.allowPickingVideo = NO;
        mediaView.rootViewController = self;
        self.mediaView = mediaView;
        
        
        ZLMyAdviseBottomView *bottomView = [[ZLMyAdviseBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mediaView.frame) + 50, Main_Screen_Width, 50 * kScreenHeightRatio) withTitles:@[@"事件反馈",@"取消反馈"]];
        bottomView.startButton.backgroundColor = HEXCOLOR(0xf29503);
        
        [bottomView.endButton setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
        bottomView.endButton.backgroundColor = [UIColor whiteColor];
        
        [bottomView.startButton addTarget:self action:@selector(reportClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        [bottomView.endButton addTarget:self action:@selector(endClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        [mediaView observeViewHeight:^(CGFloat mediaHeight) {
            CGRect btnRect = bottomView.frame;
            btnRect.origin.y = CGRectGetMaxY(mediaView.frame) + 50;
            bottomView.frame = btnRect;
            CGRect rect = headerView.frame;
            rect.size.height = CGRectGetMaxY(bottomView.frame);
            headerView.frame = rect;
            _mainTableView.sectionFooterHeight = headerView.frame.size.height;
            [_mainTableView beginUpdates];
            [_mainTableView endUpdates];
        }];
        [mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel *> *list) {
            
            self.imageArray = list;
            
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
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"事件反馈" attributes:dic];
    
    return title;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
