//
//  ZLNewContiTaskDownVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewContiTaskDownVC.h"
#import "ZLReportEventDesTableViewCell.h"
#import "ZLReportPeopleTableViewCell.h"
#import "ZLReprotEventBaseTableViewCell.h"
#import "ACMediaFrame.h"
#import "UIView+RoundedCorner.h"
#import "ZLMyAdviseBottomView.h"
#import "ZLReSentTaskService.h"
#import "ZLNewFilesUpLoadService.h"
#import "ZLUploadImagesModel.h"
#import "ZLGetDepartModel.h"
#import "ZLGetEventUserListModel.h"
#import "ZLAlertSelectionView.h"
@interface ZLNewContiTaskDownVC ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSArray *sourceArray;

@property(nonatomic, strong) NSArray *placeHolderArray;

@property (nonatomic, strong) ACSelectMediaView *mediaView;

@property (nonatomic, strong) NSArray<ACMediaModel *> *imageArray;

@property (nonatomic, strong) NSMutableArray *imageNameArray;

@property (nonatomic, strong) NSString *taskName;

@property (nonatomic, strong) NSMutableArray *taskPeople;

@property (nonatomic, strong) NSString *taskPeopleString;

@property (nonatomic, strong) NSMutableArray *taskDepart;

@property (nonatomic, strong) NSString *taskDepartString;

@property (nonatomic, strong) NSString *taskDesc;

@property (nonatomic, strong) NSMutableArray *departCode;

@property (nonatomic, strong) NSString *departCodeString;

@property (nonatomic, strong) NSMutableArray *peopleCode;
@property (nonatomic, strong) NSString *peopleCodeString;

@property (nonatomic, strong) NSMutableArray *departNameArray;
@property (nonatomic, strong) NSMutableArray *departNameTempArray;
@property (nonatomic, strong) NSMutableArray *departModelArray;

@property (nonatomic, strong) NSMutableArray *peopleNameArray;
@property (nonatomic, strong) NSMutableArray *peopleNameTempArray;
@property (nonatomic, strong) NSMutableArray *peopleModelArray;


@property (nonatomic, strong) YTKKeyValueStore *store;

@property (nonatomic, strong) ZLAlertSelectionView *alert;


@end

@implementation ZLNewContiTaskDownVC

/**
 得到数据
 */
- (void)getDepartsData{
    
    self.departNameArray = [NSMutableArray array];
    self.departModelArray = [NSMutableArray array];
    self.peopleNameArray = [NSMutableArray array];
    self.peopleModelArray = [NSMutableArray array];
    self.peopleNameTempArray = [NSMutableArray array];
    self.departNameTempArray = [NSMutableArray array];
    
    self.taskDesc = @"";
    self.taskDepartString = @"";
    self.taskDepart = [NSMutableArray array];
    self.taskPeopleString = @"";
    self.taskPeople = [NSMutableArray array];
    self.taskName = @"";
    self.departCodeString = @"";
    self.departCode = [NSMutableArray array];
    self.peopleCodeString = @"";
    self.peopleCode = [NSMutableArray array];
    
    self.store = [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
    
    NSString *tableName = DBUserTable;
    
    [self.store createTableWithName:tableName];
    NSString *departs = [self.store getStringById:DBTaskDepartListRivers fromTable:DBUserTable];
    
    ZLGetDepartModel *departsModel = [[ZLGetDepartModel alloc]initWithString:departs error:nil];
    
    NSString *users = [self.store getStringById:DBTaskPeopleListRivers fromTable:DBUserTable];
    
    ZLGetEventUserListModel *taskUserListModel = [[ZLGetEventUserListModel alloc]initWithString:users error:nil];
    
    if (departsModel.data.count > 0) {
        
        for (ZLGetDepartDataModel *dataModel in departsModel.data ) {
            
            [self.departNameArray addObject:dataModel.departName];
            
            [self.departModelArray addObject:dataModel];
            
        }
        
    }
    
    if (taskUserListModel.data.count > 0) {
        
        for (ZLGetEventUserListDataModel *dataModel in taskUserListModel.data ) {
            
            [self.peopleNameArray addObject:dataModel.realName];
            
            [self.peopleModelArray addObject:dataModel];
            
        }
        
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArray = [NSArray array];
    self.imageNameArray = [NSMutableArray array];
    
    [self getDepartsData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainTableView];
    
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
    if (indexPath.row == 0) {
        
        ZLReprotEventBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLReprotEventBaseTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        
        cell.infoTextView.tag = indexPath.row;
        
        cell.getText = ^(NSString *text, NSInteger tag) {
            
            switch (0) {
                case 0:
                    self.taskName = text;
                    break;
            }
            
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
            [self peopleClick:infoTextView with:tableView];
        };
        cell.infoTextView.tag = indexPath.row;
        cell.getText = ^(NSString *text, NSInteger tag) {
            switch (1) {
                case 1:{
                    if ([text isEqualToString:@""]) {
                        self.peopleCodeString = @"";
                        self.taskPeopleString = @"";
                    }
                }
                    break;
            }
        };
        
        return cell;
    }
    
    if (indexPath.row == 2) {
        
        
        ZLReportPeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLReportPeopleTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        cell.imageV.image = [UIImage imageNamed:@"departSelect"];
        cell.selectInfo = ^(UITextView *infoTextView) {
            [self departmentClick:infoTextView with:tableView];
        };
        
        cell.infoTextView.tag = indexPath.row;
        cell.getText = ^(NSString *text, NSInteger tag) {
            switch (2) {
                case 2:{
                    if ([text isEqualToString:@""]) {
                        self.departCodeString = @"";
                        self.taskDepartString = @"";
                    }
                }
                    break;
            }
        };
        
        return cell;
    }
    if (indexPath.row == 3) {
        
        
        ZLReportEventDesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLReportEventDesTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        
        cell.getText = ^(NSString *text, NSInteger tag) {
            
            switch (3) {
                case 3:
                    self.taskDesc = text;
                    break;
            }
            
        };
        
        
        return cell;
    }
    
    
    return nil;
    
}

// 接收人选择
- (void)peopleClick:(UITextView *)textView with:(UITableView *)tableView{
    
    if (self.peopleNameArray.count <= 0) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"暂无接收对象" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
        return;
    }
    
    
    _alert = [[ZLAlertSelectionView alloc]initWithFrame:CGRectZero sourceArray:self.peopleNameArray withTitle:@"选择接收人" sureTitle:@"确定" singleSelection:NO];
    __weak typeof(self) weakSelf = self;
    _alert.selectItemsMuti = ^(NSArray *options) {
        
        ZLLog(@"%ld",(long)index);
        
        [weakSelf.peopleNameTempArray removeAllObjects];
        [weakSelf.peopleCode removeAllObjects];
        
        for (int i = 0; i < options.count; i++) {
            
            NSNumber *number = options[i] ;
            
            NSInteger index = [number integerValue];
            
            ZLGetEventUserListDataModel *model = weakSelf.peopleModelArray[index];
            
            [weakSelf.peopleCode addObject:model.userCode];
            [weakSelf.peopleNameTempArray addObject:model.realName];
        }
        
        textView.text = [weakSelf.peopleNameTempArray componentsJoinedByString:@","];
        
        weakSelf.taskPeopleString = textView.text;
        weakSelf.peopleCodeString = [weakSelf.peopleCode componentsJoinedByString:@","];
        
    };
    
    [_alert show];
    
    
    
}

// 部门选择
- (void)departmentClick:(UITextView *)textView with:(UITableView *)tableView{
    
    if (self.departNameArray.count <= 0) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"暂无部门对象" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
        return;
    }
    
    _alert = [[ZLAlertSelectionView alloc]initWithFrame:CGRectZero sourceArray:self.departNameArray withTitle:@"选择部门" sureTitle:@"确定" singleSelection:NO];
    
    __weak typeof(self) weakSelf = self;
    _alert.selectItemsMuti = ^(NSArray *options) {
        ZLLog(@"%@",options);
        [weakSelf.departCode removeAllObjects];
        [weakSelf.departNameTempArray removeAllObjects];
        
        for (int i = 0; i < options.count; i++) {
            
            NSNumber *number = options[i] ;
            
            NSInteger index = [number integerValue];
            
            ZLGetDepartDataModel *model = weakSelf.departModelArray[index];
            
            [weakSelf.departCode addObject:model.departCode];
            
            [weakSelf.departNameTempArray addObject:model.departName];
            
            
        }
        textView.text = [weakSelf.departNameTempArray componentsJoinedByString:@","];
        
        weakSelf.taskDepartString = textView.text;
        
        
        weakSelf.departCodeString = [weakSelf.departCode componentsJoinedByString:@","];
        
    };
    
    [_alert show];
    
    
    
}

/**
 检测文本框的内容
 */
- (BOOL)checkTextFieldContent{
    
    if ([self.taskDepartString isEqualToString:@""] && [self.taskPeopleString isEqualToString:@""]) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"必须选择接收部门或接收对象" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
        return NO;
    }
    
    if ([self.taskName isEqualToString:@""]) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"请填写任务名称" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return NO;
    }
    
    if ([self.taskDesc isEqualToString:@""]) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"请填写描述内容" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return NO;
    }
    
    
    return YES;
}



- (void)cancelClick{
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
    
        if (buttonIndex == 1) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        
    } title:@"提示" message:@"确定取消下发吗?" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
}

- (void)contiClick{
    if (![self checkTextFieldContent]) {
        return;
    }
    
    [self.imageNameArray removeAllObjects];
    
    
    [SVProgressHUD showWithStatus:@"下发中"];
    
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
        
        ZLReSentTaskService *service = [[ZLReSentTaskService alloc]initWithimgList:self.imageNameArray taskName:self.taskName taskContent:self.taskDesc receiverDepartmentNames:self.taskDepartString receiverDepartmentCodes:self.departCodeString receiverPersonIds:self.peopleCodeString receiverPersonNames:self.taskPeopleString riverTaskDetailId:_taskDetailId];
        [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            ZLBaseModel *model = [[ZLBaseModel alloc]initWithString:request.responseString error:nil];
            
            if ([model.code isEqualToString:@"0"]) {
                [SVProgressHUD showSuccessWithStatus:@"下发成功"];
                [SVProgressHUD dismissWithDelay:0.3 completion:^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }];
            }else{
                [SVProgressHUD showErrorWithStatus:model.detail];
                [SVProgressHUD dismissWithDelay:0.3];
            }
            ZLLog(@"%@",request.responseString);
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
            [SVProgressHUD dismissWithDelay:0.3];
        }];
    });
    
}





- (NSArray *)sourceArray{
    if (!_sourceArray) {
        _sourceArray = @[@"任务名称：",
                         @"接收人：",
                         @"接收部门：",
                         @"任务描述："];
        
        
    }
    return _sourceArray;
}

- (NSArray *)placeHolderArray{
    if (!_placeHolderArray) {
        _placeHolderArray = @[@"请输入任务名称",
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
        [_mainTableView registerClass:[ZLReprotEventBaseTableViewCell class] forCellReuseIdentifier:@"ZLReprotEventBaseTableViewCell"];
        [_mainTableView registerClass:[ZLReportEventDesTableViewCell class] forCellReuseIdentifier:@"ZLReportEventDesTableViewCell"];
        
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.bounces = NO;
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
        

        mediaView.allowMultipleSelection = NO;
        mediaView.allowPickingVideo = YES;
        mediaView.rootViewController = self;
        self.mediaView = mediaView;
        
        
        ZLMyAdviseBottomView *bottomView = [[ZLMyAdviseBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mediaView.frame) + 50, Main_Screen_Width, 50 * kScreenHeightRatio) withTitles:@[@"继续下发",@"取消下发"]];
        [bottomView.endButton setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
        bottomView.endButton.backgroundColor = [UIColor whiteColor];
        
        [bottomView.startButton addTarget:self action:@selector(contiClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        [bottomView.endButton addTarget:self action:@selector(cancelClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        
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
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"继续下发" attributes:dic];
    
    return title;
    
}

@end
