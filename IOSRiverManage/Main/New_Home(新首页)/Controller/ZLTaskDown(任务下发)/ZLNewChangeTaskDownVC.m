//
//  ZLNewChangeTaskDownVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewChangeTaskDownVC.h"
#import "ZLReportEventDesTableViewCell.h"
#import "ZLReportPeopleTableViewCell.h"
#import "ZLReprotEventBaseTableViewCell.h"
#import "ACMediaFrame.h"
#import "UIView+RoundedCorner.h"
#import "ZLNewReportBottomView.h"
#import "ZLGetDepartModel.h"
#import "ZLGetEventUserListModel.h"
#import "ZLAlertSelectionView.h"
#import "ZLNewFilesUpLoadService.h"
#import "ZLUploadImagesModel.h"
#import "ZLSaveTaskService.h"
#import "ZLSaveAndSentTaskService.h"
#import "ZLTaskDetailByIdService.h"
#import "ZLTaskInfoDetailModel.h"
#import "ZLUpdateTaskService.h"
#import "ZLUpdateAndSentTaskService.h"
#import "ZLGetUserListByTaskNormalService.h"
#import "ZLGetVideoFirstImage.h"
@interface ZLNewChangeTaskDownVC ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSArray *sourceArray;

@property(nonatomic, strong) NSArray *placeHolderArray;

@property (nonatomic, strong) ACSelectMediaView *mediaView;


@property (nonatomic, strong) NSMutableArray<ACMediaModel *> *imageArray;

@property (nonatomic, strong) NSMutableArray *imageNameArray;
/**
 图片预览url存放的临时数组
 */
@property (nonatomic, strong) NSMutableArray *imageTempArray;

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
// 只存放人名字
@property (nonatomic, strong) NSMutableArray *peopleRealNameArray;
@property (nonatomic, strong) NSMutableArray *peopleModelArray;

@property (nonatomic, strong) YTKKeyValueStore *store;

@property (nonatomic, strong) ZLAlertSelectionView *alert;

@property (nonatomic, strong) ZLTaskInfoDetailDataModel *detailDataModel;

@end

@implementation ZLNewChangeTaskDownVC


- (void)getData{
    
    ZLTaskDetailByIdService *service = [[ZLTaskDetailByIdService alloc]initWithtaskId:_dataModel.taskId];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLTaskInfoDetailModel *detailModel = [[ZLTaskInfoDetailModel alloc]initWithString:request.responseString error:nil];
        
        if ([detailModel.code isEqualToString:@"0"]) {
            
            if (detailModel != nil) {
                 self.detailDataModel = detailModel.data;
            }
            
        }
        [self.mainTableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
    }];
}



- (void)initData {
    self.departNameArray = [NSMutableArray array];
    self.departModelArray = [NSMutableArray array];
    self.peopleNameArray = [NSMutableArray array];
    self.peopleModelArray = [NSMutableArray array];
    self.peopleNameTempArray = [NSMutableArray array];
    self.departNameTempArray = [NSMutableArray array];
    self.peopleRealNameArray = [NSMutableArray array];
    
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
    
    if (departsModel.data.count > 0) {
        
        for (ZLGetDepartDataModel *dataModel in departsModel.data ) {
            
            [self.departNameArray addObject:dataModel.departName];
            
            [self.departModelArray addObject:dataModel];
            
        }
        
    }
    
}

/**
 得到数据
 */
- (void)getDepartsData{
    
    [self initData];
    // 等待以后修复
    [self getNomalUserList];
    
}

- (void)getNomalUserList {
    NSString *users = [self.store getStringById:DBTaskPeopleListRivers fromTable:DBUserTable];
    
    ZLGetEventUserListModel *taskUserListModel = [[ZLGetEventUserListModel alloc]initWithString:users error:nil];
    
    if (taskUserListModel.data.count > 0) {
        
        for (ZLGetEventUserListDataModel *dataModel in taskUserListModel.data ) {
            
            NSString *riverNames = @"";
            NSString *areaName = @"";
            if (dataModel.riverNames.length > 0) {
                
                riverNames = [NSString stringWithFormat:@"(%@)",dataModel.riverNames];
                
            }
            
            if (dataModel.areaName.length > 0) {
                
                areaName = [NSString stringWithFormat:@"%@-",dataModel.areaName];
                
            }
            
            NSString *peopleName = [NSString stringWithFormat:@"%@%@%@",areaName,dataModel.realName,riverNames];
            
            [self.peopleNameArray addObject:peopleName];
            
            
            [self.peopleModelArray addObject:dataModel];
            
        }
        
    }
}


- (void)getuserListData{
    
    self.peopleModelArray = [NSMutableArray array];
    self.peopleNameArray = [NSMutableArray array];
    
    ZLGetUserListByTaskNormalService *service = [[ZLGetUserListByTaskNormalService alloc]initWithriverCode:@""];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLGetEventUserListModel *taskUserList = [[ZLGetEventUserListModel alloc]initWithString:request.responseString error:nil];
        
        if ([taskUserList.code isEqualToString:@"0"]) {
            
            for (ZLGetEventUserListDataModel *dataModel in taskUserList.data) {
                
                NSString *riverNames = @"";
                NSString *areaName = @"";
                if (dataModel.riverNames.length > 0) {
                    
                    riverNames = [NSString stringWithFormat:@"(%@)",dataModel.riverNames];
                    
                }
                
                if (dataModel.areaName.length > 0) {
                    
                    areaName = [NSString stringWithFormat:@"%@-",dataModel.areaName];
                    
                }
                
                NSString *peopleName = [NSString stringWithFormat:@"%@%@%@",areaName,dataModel.realName,riverNames];
                
                [self.peopleNameArray addObject:peopleName];
                
                [self.peopleModelArray addObject:dataModel];
                
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}






- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArray = [NSMutableArray array];
    self.imageNameArray = [NSMutableArray array];
    
    [self getData];
    
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

// 接收人选择
- (void)peopleClick:(UITextView *)textView with:(UITableView *)tableView{
    
    if (self.peopleNameArray.count <= 0) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"暂无下发对象" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
        return;
    }
    
    
    _alert = [[ZLAlertSelectionView alloc]initWithFrame:CGRectZero sourceArray:self.peopleNameArray withTitle:@"选择接收人" sureTitle:@"确定" singleSelection:NO];
    __weak typeof(self) weakSelf = self;
    _alert.selectItemsMuti = ^(NSArray *options) {
        
        ZLLog(@"%ld",(long)index);
        
        [weakSelf.peopleNameTempArray removeAllObjects];
        [weakSelf.peopleRealNameArray removeAllObjects];
        [weakSelf.peopleCode removeAllObjects];
        
        for (int i = 0; i < options.count; i++) {
            
            NSNumber *number = options[i] ;
            
            NSInteger index = [number integerValue];
            
            ZLGetEventUserListDataModel *model = weakSelf.peopleModelArray[index];
            
            [weakSelf.peopleCode addObject:model.userCode];
            
            NSString *areaName = @"";
            if (model.areaName.length > 0) {
                
                areaName = [NSString stringWithFormat:@"%@-",model.areaName];
                
            }
            
            NSString *peopleName = [NSString stringWithFormat:@"%@%@",areaName,model.realName];
            [weakSelf.peopleNameTempArray addObject:peopleName];
             [weakSelf.peopleRealNameArray addObject:model.realName];
        }
        
        textView.text = [weakSelf.peopleNameTempArray componentsJoinedByString:@","];
        
         weakSelf.taskPeopleString = [weakSelf.peopleRealNameArray componentsJoinedByString:@","];
        weakSelf.peopleCodeString = [weakSelf.peopleCode componentsJoinedByString:@","];
        
    };
    
    [_alert show];
}

// 部门选择
- (void)departmentClick:(UITextView *)textView with:(UITableView *)tableView{
    
    if (self.departNameArray.count <= 0) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"暂无部门数据" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
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
            
        } title:@"提示" message:@"请选择下发对象或部门" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
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


- (void)saveButtonClick{
    
    if (![self checkTextFieldContent]) {
        return;
    }
    
    [self.imageNameArray removeAllObjects];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < _imageArray.count; i++) {
        
        ACMediaModel *model = _imageArray[i];
        
        // 说明是预加载的图片
        if (model.imageUrlString.length > 0 || model.mediaURL) {
            [self.imageNameArray addObject:model.imageListModel.toDictionary];
        }else{
            // 不是预加载的图片
            [tempArray addObject:model];
        }
        
    }

    [SVProgressHUD showWithStatus:@"保存中"];
    
    dispatch_group_t group = dispatch_group_create();
    
    ZLNewFilesUpLoadService *filesService = [[ZLNewFilesUpLoadService alloc]initWithImage:tempArray];
    
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
        ZLUpdateTaskService *service = [[ZLUpdateTaskService alloc]initWithimgList:self.imageNameArray taskName:self.taskName taskContent:self.taskDesc receiverDepartmentNames:self.taskDepartString receiverDepartmentCodes:self.departCodeString receiverPersonIds:self.peopleCodeString receiverPersonNames:self.taskPeopleString ID:_detailDataModel.ID taskCode:_detailDataModel.taskCode fileList:_detailDataModel.fileList];
        
        [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            ZLBaseModel *model = [[ZLBaseModel alloc]initWithString:request.responseString error:nil];
            
            if ([model.code isEqualToString:@"0"]) {
                
                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
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


- (void)reportButtonClick{
    if (![self checkTextFieldContent]) {
        return;
    }
    [self.imageNameArray removeAllObjects];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < _imageArray.count; i++) {
        ACMediaModel *model = _imageArray[i];
        // 说明是预加载的图片
        if (model.imageUrlString.length > 0 || model.mediaURL) {
            [self.imageNameArray addObject:model.imageListModel.toDictionary];
        }else{
            // 不是预加载的图片
            [tempArray addObject:model];
        }
    }
    [SVProgressHUD showWithStatus:@"下发中"];
    
    dispatch_group_t group = dispatch_group_create();
    
    ZLNewFilesUpLoadService *filesService = [[ZLNewFilesUpLoadService alloc]initWithImage:tempArray];
    
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
        ZLUpdateAndSentTaskService *service = [[ZLUpdateAndSentTaskService alloc]initWithimgList:self.imageNameArray taskName:self.taskName taskContent:self.taskDesc receiverDepartmentNames:self.taskDepartString receiverDepartmentCodes:self.departCodeString receiverPersonIds:self.peopleCodeString receiverPersonNames:self.taskPeopleString ID:_detailDataModel.ID taskCode:_detailDataModel.taskCode fileList:_detailDataModel.fileList];
        
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


#pragma mark -- 列表的代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    return self.sourceData.count;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] init];
    ACSelectMediaView *mediaView = [[ACSelectMediaView alloc] initWithFrame:CGRectMake(0,  0, self.view.frame.size.width, 1)];
    mediaView.showDelete = YES;
    mediaView.showAddButton = YES;
    mediaView.allowMultipleSelection = NO;
    mediaView.allowPickingVideo = YES;
    mediaView.videoMaximumDuration = 15;
    mediaView.type = ACMediaTypeAll;
    //png、jpg、gif(本地和网络)
    if (self.detailDataModel) {
        if (self.detailDataModel.imgList.count > 0) {
            self.imageTempArray = [NSMutableArray array];
            [self.imageArray removeAllObjects];
            
            for (int i = 0; i < self.detailDataModel.imgList.count; i++) {
                ZLTaskInfoImageListModel *imageModel = self.detailDataModel.imgList[i];
                NSString *urlString = [NSString stringWithFormat:@"%@%@",BaseImage_URL, imageModel.fileAddr];
                NSString *suffix = [urlString pathExtension];
                [_imageTempArray addObject:urlString];
                ACMediaModel *mediaModel = [[ACMediaModel alloc]init];
                
                if ([suffix isEqualToString:@"mp4"]) {
                    mediaModel.isVideo = YES;
                    mediaModel.mediaURL = [NSURL URLWithString:urlString];
                    
                    //                    mediaModel.image = [ACMediaModel thumbnailImageForVideo:mediaModel.mediaURL atTime:1];
                    
//                    mediaModel.image = [UIImage imageNamed:@"event_placeImage"];
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        UIImage *image =  [[ZLGetVideoFirstImage sharedManager]thumbnailImageForVideo:mediaModel.mediaURL atTime:1];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            mediaModel.image = image;
                        });
                        
                    });
                    
                    
                    
//                    mediaModel.image = [[ZLGetVideoFirstImage sharedManager]thumbnailImageForVideo:mediaModel.mediaURL atTime:1];
                    
                    //                    mediaModel.imageUrlString = urlString;
                }else{
                    mediaModel.imageUrlString = urlString;
                }
                mediaModel.imageListModel = imageModel;
                [self.imageArray addObject:mediaModel];
            }
            mediaView.preShowMedias = self.imageArray;
        }
    }
    mediaView.allowMultipleSelection = NO;
    mediaView.rootViewController = self;
    self.mediaView = mediaView;

    ZLNewReportBottomView *bottomView = [[ZLNewReportBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mediaView.frame) + 50, Main_Screen_Width, 50 * kScreenHeightRatio) withTitles:@[@"保存",@"下发"]];
    [bottomView.saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [bottomView.reportButton addTarget:self action:@selector(reportButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [mediaView observeViewHeight:^(CGFloat mediaHeight) {
        CGRect btnRect = bottomView.frame;
        btnRect.origin.y = CGRectGetMaxY(mediaView.frame) + 50;
        bottomView.frame = btnRect;
        CGRect rect = headerView.frame;
        rect.size.height = CGRectGetMaxY(bottomView.frame);
        headerView.frame = rect;
//        _mainTableView.sectionFooterHeight = headerView.frame.size.height;
        [_mainTableView beginUpdates];
        [_mainTableView endUpdates];
    }];
    [mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel *> *list) {
        
        [self.imageArray removeAllObjects];
        
        self.imageArray = [NSMutableArray arrayWithArray:list];
        
    }];
    [headerView addSubview:mediaView];
    
    [headerView addSubview:bottomView];
    headerView.frame = CGRectMake(0, 0, Main_Screen_Width, CGRectGetMaxY(bottomView.frame));
    _mainTableView.tableFooterView = headerView;
    
//    _mainTableView.sectionFooterHeight = headerView.frame.size.height;
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        ZLReprotEventBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLReprotEventBaseTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        
        if (self.detailDataModel) {
            
            cell.infoTextView.text = self.detailDataModel.taskName;
            self.taskName = self.detailDataModel.taskName;
        }
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
        
        if (self.detailDataModel) {
            
            cell.infoTextView.text = self.detailDataModel.receiverPersonNames;
            self.peopleCodeString = _detailDataModel.receiverPersonIds;
            self.taskPeopleString = _detailDataModel.receiverPersonNames;
        }
        
        
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
        
        if (self.detailDataModel) {
            
            cell.infoTextView.text = self.detailDataModel.receiverDepartmentNames;
            self.departCodeString = _detailDataModel.receiverDepartmentCodes;
            self.taskDepartString = _detailDataModel.receiverDepartmentNames;
        }
        
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
        
        if (self.detailDataModel) {
            
            cell.infoTextView.text = self.detailDataModel.taskContent;
            self.taskDesc = self.detailDataModel.taskContent;
        }
        
        return cell;
    }
    
    
    return nil;
    
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
        _mainTableView.bounces = NO;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.showsVerticalScrollIndicator = NO;
        
        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _mainTableView.estimatedRowHeight = 180;
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        
        _mainTableView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
//        _mainTableView.estimatedSectionFooterHeight = 180;
//        _mainTableView.sectionFooterHeight = UITableViewAutomaticDimension;

//        _mainTableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
        

    }
    return _mainTableView;
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"任务修改" attributes:dic];
    
    return title;
    
}

@end
