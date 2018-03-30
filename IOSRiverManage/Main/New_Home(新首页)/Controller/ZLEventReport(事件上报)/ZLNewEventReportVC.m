//
//  ZLNewEventReportVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/17.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewEventReportVC.h"
#import "ZLReportEventDesTableViewCell.h"
#import "ZLReportPeopleTableViewCell.h"
#import "ZLReprotEventBaseTableViewCell.h"
#import "ACMediaFrame.h"
#import "UIView+RoundedCorner.h"
#import "ZLNewReportBottomView.h"
#import "ZLOnlyAddIncidentService.h"
#import "ZLNewFilesUpLoadService.h"
#import "ZLUploadImagesModel.h"
#import "ZLGetDepartModel.h"
#import "ZLAlertSelectionView.h"
#import "ZLGetEventUserListModel.h"
#import "ZLAddAndSentIncidentService.h"

@interface ZLNewEventReportVC ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSArray *sourceArray;

@property(nonatomic, strong) NSArray *placeHolderArray;

@property (nonatomic, strong) ACSelectMediaView *mediaView;

@property (nonatomic, strong) NSArray<ACMediaModel *> *imageArray;

@property (nonatomic, strong) NSMutableArray *imageNameArray;

@property (nonatomic, strong) NSString *eventName;

@property (nonatomic, strong) NSString *eventPeople;
@property (nonatomic, strong) NSString *eventDepart;
@property (nonatomic, strong) NSString *eventDesc;

@property (nonatomic, strong) NSString *departCode;
@property (nonatomic, strong) NSString *peopleCode;
@property (nonatomic, strong) NSMutableArray *departNameArray;

@property (nonatomic, strong) NSMutableArray *departModelArray;

@property (nonatomic, strong) NSMutableArray *peopleNameArray;

@property (nonatomic, strong) NSMutableArray *peopleModelArray;

@property (nonatomic, strong) NSString *receiverType;

@property (nonatomic, strong) YTKKeyValueStore *store;

@end

@implementation ZLNewEventReportVC

/**
 得到数据
 */
- (void)getDepartsData{
    
    self.departNameArray = [NSMutableArray array];
    self.departModelArray = [NSMutableArray array];
    self.peopleNameArray = [NSMutableArray array];
    self.peopleModelArray = [NSMutableArray array];
    
    self.eventDesc = @"";
    self.eventDepart = @"";
    self.eventPeople = @"";
    self.eventName = @"";
    self.departCode = @"";
    self.peopleCode = @"";
    self.receiverType = 0;
    self.store = [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
    
    NSString *tableName = DBUserTable;
    
    [self.store createTableWithName:tableName];
    NSString *departs = [self.store getStringById:DBEventDepartListRivers fromTable:DBUserTable];
    
    ZLGetDepartModel *departsModel = [[ZLGetDepartModel alloc]initWithString:departs error:nil];
    
    NSString *users = [self.store getStringById:DBEventPeopleListRivers fromTable:DBUserTable];
    
    ZLGetEventUserListModel *eventUserListModel = [[ZLGetEventUserListModel alloc]initWithString:users error:nil];
    
    if (departsModel.data.count > 0) {
        
        for (ZLGetDepartDataModel *dataModel in departsModel.data ) {
            
            [self.departNameArray addObject:dataModel.departName];
            
            [self.departModelArray addObject:dataModel];
            
        }
        
    }

    if (eventUserListModel.data.count > 0) {
        
        for (ZLGetEventUserListDataModel *dataModel in eventUserListModel.data ) {
            
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
                    self.eventName = text;
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
                case 1:
                    self.eventPeople = text;
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
        cell.imageV.image = [UIImage imageNamed:@"home_seletPeople"];
        cell.selectInfo = ^(UITextView *infoTextView) {
            [self departmentClick:infoTextView with:tableView];
        };
        
        cell.infoTextView.tag = indexPath.row;
        
        cell.getText = ^(NSString *text, NSInteger tag) {
            
            switch (2) {
                case 2:
                    self.eventDepart = text;
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
        
        cell.infoTextView.tag = indexPath.row;
        
        cell.getText = ^(NSString *text, NSInteger tag) {
            
            switch (3) {
                case 3:
                    self.eventDesc = text;
                    break;
            }
            
        };
        
        return cell;
    }
    return nil;
    
}

// 接收人选择
- (void)peopleClick:(UITextView *)textView with:(UITableView *)tableView{
    
    ZLAlertSelectionView *alert = [[ZLAlertSelectionView alloc]initWithFrame:CGRectZero sourceArray:self.peopleNameArray withTitle:@"选择接收人" sureTitle:@"确定" singleSelection:YES];
    
    alert.selectItem = ^(NSInteger index) {
        
        ZLLog(@"%ld",(long)index);
        
        textView.text = self.peopleNameArray[index];
        
        ZLReportPeopleTableViewCell *cell = tableView.visibleCells[2];
        
        cell.infoTextView.text = @"";
        
        self.eventPeople = textView.text;
        self.eventDepart = @"";
        
         ZLGetEventUserListDataModel *model = self.peopleModelArray[index];
        
        self.departCode = @"";
        self.peopleCode = model.userCode;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        
    };
    
    [alert show];
    
    
    
}

// 部门选择
- (void)departmentClick:(UITextView *)textView with:(UITableView *)tableView{
    
    ZLAlertSelectionView *alert = [[ZLAlertSelectionView alloc]initWithFrame:CGRectZero sourceArray:self.departNameArray withTitle:@"选择部门" sureTitle:@"确定" singleSelection:YES];
    
    alert.selectItem = ^(NSInteger index) {
        ZLLog(@"%ld",(long)index);
        
        textView.text = self.departNameArray[index];
        
        ZLReportPeopleTableViewCell *cell = tableView.visibleCells[1];
        
        cell.infoTextView.text = @"";
        
        self.eventPeople = @"";
        self.eventDepart = textView.text;
        ZLGetDepartDataModel *model = self.departModelArray[index];
        
        self.departCode = model.departCode;
        self.peopleCode = @"";
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        
    };
    
    [alert show];
    
    
    
}
- (NSArray *)sourceArray{
    if (!_sourceArray) {
        _sourceArray = @[@"任务名称:",
                         @"接收人:",
                         @"接收部门:",
                         @"事件描述:"];
        
        
    }
    return _sourceArray;
}

- (NSArray *)placeHolderArray{
    if (!_placeHolderArray) {
        _placeHolderArray = @[@"请输入事件名称",
                         @"请选择接收人",
                         @"请选择接收部门",
                         @"请输入描述内容(140字以内)"];
        
        
    }
    return _placeHolderArray;
}

/**
 检测文本框的内容
 */
- (BOOL)checkTextFieldContent{
    
    if ([self.eventDepart isEqualToString:@""] && [self.eventPeople isEqualToString:@""]) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"必须选择接收部门或接收对象" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
        return NO;
    }
    
    if ([self.eventName isEqualToString:@""]) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"请填写事件名称" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return NO;
    }
    
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
- (void)saveButtonClick{
    
    if (![self checkTextFieldContent]) {
        return;
    }
    
    [SVProgressHUD showWithStatus:@"保存中"];
    
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
            
            if ([_eventPeople isEqualToString:@""]) {
                
                self.receiverType = @"2";
            }else if ([_eventDepart isEqualToString:@""]){
                _receiverType = @"1";
            }
            
            ZLOnlyAddIncidentService *service = [[ZLOnlyAddIncidentService alloc]initWithimgList:self.imageNameArray fileList:@[] incidentName:_eventName incidentContent:_eventDesc receiverType:_receiverType receiverDepartCode:_departCode receiverDepartName:_eventDepart receiverPersonName:_eventPeople receiverPersonCode:_peopleCode riverCode:@"" patrolCode:@"" longitude:nil latitude:nil positionDesc:@""];
            
            [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                 ZLLog(@"%@", request.responseString);
                
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                [SVProgressHUD showErrorWithStatus:@"网络错误"];
                [SVProgressHUD dismissWithDelay:0.3];
            }];
            
            
        });
}




- (void)reportButtonClick{
    if (![self checkTextFieldContent]) {
        return;
    }
    
    [SVProgressHUD showWithStatus:@"上报中"];
    
    dispatch_group_t group = dispatch_group_create();
    
    ZLNewFilesUpLoadService *filesService = [[ZLNewFilesUpLoadService alloc]initWithImage:_imageArray];
    
    dispatch_group_enter(group);
    
    [filesService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLUploadImagesModel *imagesModel = [[ZLUploadImagesModel alloc]initWithString:request.responseString error:nil];
        if ([imagesModel.code isEqualToString:@"0"]) {
            
            for (ZLTaskInfoImageListModel *model in imagesModel.data) {
                
                [self.imageNameArray addObject:model.toDictionary];
            }
        }
        
        ZLLog(@"%@", request.responseString);
        dispatch_group_leave(group);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        [SVProgressHUD dismissWithDelay:0.3];
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        ZLLog(@"%@", self.imageNameArray);
        
        
        
////        ZLAddAndSentIncidentService *service = [[ZLAddAndSentIncidentService alloc]initWithimgList:self.imageNameArray fileList:@[] incidentName:_eventName incidentContent:_eventDesc receiverType:_receiverType receiverDepartCode:_departCode receiverDepartName:_eventDepart receiverPersonName:_eventPeople receiverPersonCode:_peopleCode riverCode:@"" patrolCode:@"" longitude:@"" latitude:@"" positionDesc:@""];
//
//        [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request){
//
//             ZLLog(@"%@", request.responseString);
//
//        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//        }];
        
        
    });
    
}



- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLReportPeopleTableViewCell class] forCellReuseIdentifier:@"ZLReportPeopleTableViewCell"];
        [_mainTableView registerClass:[ZLReprotEventBaseTableViewCell class] forCellReuseIdentifier:@"ZLReprotEventBaseTableViewCell"];
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
        mediaView.allowMultipleSelection = NO;
        mediaView.allowPickingVideo = YES;
        mediaView.rootViewController = self;
        self.mediaView = mediaView;
        
        
        ZLNewReportBottomView *bottomView = [[ZLNewReportBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mediaView.frame) + 50, Main_Screen_Width, 50 * kScreenHeightRatio) withTitles:@[@"保存",@"上报"]];
        
        [bottomView.saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        [bottomView.reportButton addTarget:self action:@selector(reportButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        
//        [bottomView.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
//
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
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"事件上报" attributes:dic];
    
    return title;
    
}


@end
