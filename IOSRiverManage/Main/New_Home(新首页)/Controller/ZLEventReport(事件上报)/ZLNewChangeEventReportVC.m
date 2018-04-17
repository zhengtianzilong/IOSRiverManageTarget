//
//  ZLNewChangeEventReportVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/23.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewChangeEventReportVC.h"
#import "ZLReportEventDesTableViewCell.h"
#import "ZLReportPeopleTableViewCell.h"
#import "ZLReprotEventBaseTableViewCell.h"
#import "ACMediaFrame.h"
#import "UIView+RoundedCorner.h"
#import "ZLNewReportBottomView.h"
#import "ZLEventManagerDetailService.h"
#import "ZLEventDetailModel.h"
#import "ZLAlertSelectionView.h"
#import "ZLNewFilesUpLoadService.h"
#import "ZLGetDepartModel.h"
#import "ZLGetEventUserListModel.h"
#import "ZLOnlyUpdateIncidentService.h"
#import "ZLUpdateAndSentIncidentService.h"
#import "ZLUploadImagesModel.h"
#import "ZLGetUserListByIncidentService.h"

#import "ZLReportDepartTableViewCell.h"

@interface ZLNewChangeEventReportVC ()<UITableViewDelegate, UITableViewDataSource>
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

@property (nonatomic, strong) NSString *eventName;

@property (nonatomic, strong) NSMutableArray *eventPeople;

@property (nonatomic, strong) NSString *eventPeopleString;

@property (nonatomic, strong) NSMutableArray *eventDepart;

@property (nonatomic, strong) NSString *eventDepartString;

@property (nonatomic, strong) NSString *eventDesc;

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

@property (nonatomic, strong) ZLEventDetailDataModel *detailDataModel;
@property (nonatomic, strong) NSString *receiverType;

@property (nonatomic, assign) BOOL isclear;


@end

@implementation ZLNewChangeEventReportVC

- (void)getData{
    
    ZLEventManagerDetailService *service = [[ZLEventManagerDetailService alloc]initWitheventId:_dataModel.ID];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLLog(@"%@",request.responseString);
        
        ZLEventDetailModel *detailModel = [[ZLEventDetailModel alloc]initWithString:request.responseString error:nil];
        
        if ([detailModel.code isEqualToString:@"0"]) {
            if (detailModel != nil) {
                self.detailDataModel = detailModel.data;
            }
            
            ZLRiverIncidentDetailListModel *model = detailModel.data.riverIncidentDetailList.lastObject;
            
            if (model) {
                if (model.groupName) {
                    self.detailDataModel.receiverDepartName = model.groupName;
                    self.detailDataModel.receiverDepartCode = model.groupCode;
                }else{
                    self.detailDataModel.receiverDepartName = @"";
                    self.detailDataModel.receiverDepartCode = @"";
                }
                
                if (model.userName) {
                    self.detailDataModel.receiverPersonName = model.userName;
                    self.detailDataModel.receiverPersonCode = model.userCode;
                }else{
                    self.detailDataModel.receiverPersonName = @"";
                    self.detailDataModel.receiverPersonCode = @"";
                }
                
                
            }
            self.detailDataModel.isFirst = @"NO";
        }
        [self.mainTableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
    }];
}

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
    
    self.eventDesc = @"";
    self.eventDepartString = @"";
    self.eventDepart = [NSMutableArray array];
    self.eventPeopleString = @"";
    self.eventPeople = [NSMutableArray array];
    self.eventName = @"";
    self.departCodeString = @"";
    self.departCode = [NSMutableArray array];
    self.peopleCodeString = @"";
    self.peopleCode = [NSMutableArray array];
    
    self.isclear = NO;
    
    self.store = [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
    
    NSString *tableName = DBUserTable;
    
    [self.store createTableWithName:tableName];
    NSString *departs = [self.store getStringById:DBEventDepartListRivers fromTable:DBUserTable];
    
    ZLGetDepartModel *departsModel = [[ZLGetDepartModel alloc]initWithString:departs error:nil];
    if (departsModel.data.count > 0) {
        
        for (ZLGetDepartDataModel *dataModel in departsModel.data ) {
            
            [self.departNameArray addObject:dataModel.departName];
            
            [self.departModelArray addObject:dataModel];
            
        }
        
    }
    
    if (_detailDataModel.riverCode.length > 0) {
        
        [self getuserListData];
        
    }else{
        [self getNoRiverUserListData];
    }
    
    

    
}

- (void)getNoRiverUserListData{
    NSString *users = [self.store getStringById:DBEventPeopleListRivers fromTable:DBUserTable];
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
    
    ZLGetUserListByIncidentService *service = [[ZLGetUserListByIncidentService alloc]initWithriverCode:_dataModel.riverCode];
    
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
            
        } title:@"提示" message:@"暂无接收对象" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
        return;
    }
    
    ZLAlertSelectionView *alert = [[ZLAlertSelectionView alloc]initWithFrame:CGRectZero sourceArray:self.peopleNameArray withTitle:@"选择接收人" sureTitle:@"确定" singleSelection:YES];
    
    alert.selectItem = ^(NSInteger index) {
        
        ZLLog(@"%ld",(long)index);
        
        textView.text = self.peopleNameArray[index];
        ZLGetEventUserListDataModel *model = self.peopleModelArray[index];
        ZLReportPeopleTableViewCell *cell = tableView.visibleCells[2];
        
        cell.infoTextView.text = @"";
        
        self.isclear = YES;
        
        self.eventPeopleString = model.realName;
        self.eventDepartString = @"";
        
        
        
        self.departCodeString = @"";
        self.peopleCodeString = model.userCode;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        
    };
    
    [alert show];
    
}

// 部门选择
- (void)departmentClick:(UITextView *)textView with:(UITableView *)tableView{
    
    if (self.departNameArray.count <= 0) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"暂无部门数据" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
        return;
    }
    
    ZLAlertSelectionView *alert = [[ZLAlertSelectionView alloc]initWithFrame:CGRectZero sourceArray:self.departNameArray withTitle:@"选择部门" sureTitle:@"确定" singleSelection:YES];
    
    alert.selectItem = ^(NSInteger index) {
        ZLLog(@"%ld",(long)index);
        
        textView.text = self.departNameArray[index];
        
        ZLReportPeopleTableViewCell *cell = tableView.visibleCells[1];
        
        cell.infoTextView.text = @"";
        self.isclear = YES;
        self.eventPeopleString = @"";
        self.eventDepartString = textView.text;
        ZLGetDepartDataModel *model = self.departModelArray[index];
        
        self.departCodeString = model.departCode;
        self.peopleCodeString = @"";
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        
    };
    
    [alert show];
}


/**
 检测文本框的内容
 */
- (BOOL)checkTextFieldContent{
    
    if ([self.eventDepartString isEqualToString:@""] && [self.eventPeopleString isEqualToString:@""]) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"请选择接收人或接收部门" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
        return NO;
    }
    
    if ([self.eventName isEqualToString:@""]) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"请填写任务名称" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return NO;
    }
    
    if ([self.eventDesc isEqualToString:@""]) {
        
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
        if (model.imageUrlString.length > 0) {
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
            
            dispatch_group_leave(group);
            
        }else{
            [SVProgressHUD showErrorWithStatus:imagesModel.detail];
            [SVProgressHUD dismissWithDelay:0.3];
        }
        
        
        ZLLog(@"%@", request.responseString);
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        [SVProgressHUD dismissWithDelay:0.3];
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        ZLLog(@"%@", self.imageNameArray);
        
        if ([_eventPeopleString isEqualToString:@""]) {
            
            self.receiverType = @"2";
        }else if ([_eventDepartString isEqualToString:@""]){
            _receiverType = @"1";
        }
        
        ZLOnlyUpdateIncidentService *service = [[ZLOnlyUpdateIncidentService alloc]initWithimgList:self.imageNameArray fileList:self.detailDataModel.fileList incidentName:self.eventName incidentContent:self.eventDesc receiverType:_receiverType receiverDepartCode:self.departCodeString receiverDepartName:self.eventDepartString receiverPersonName:self.eventPeopleString receiverPersonCode:self.peopleCodeString riverCode:@"" patrolCode:@"" longitude:nil latitude:nil positionDesc:nil incidentCode:_detailDataModel.incidentCode];
        
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
        if (model.imageUrlString.length > 0) {
            [self.imageNameArray addObject:model.imageListModel.toDictionary];
        }else{
            // 不是预加载的图片
            [tempArray addObject:model];
        }
    }
    [SVProgressHUD showWithStatus:@"上报中"];
    
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
        
        if ([_eventPeopleString isEqualToString:@""]) {
            
            self.receiverType = @"2";
        }else if ([_eventDepartString isEqualToString:@""]){
            _receiverType = @"1";
        }
        
        ZLUpdateAndSentIncidentService *service = [[ZLUpdateAndSentIncidentService alloc]initWithimgList:self.imageNameArray fileList:self.detailDataModel.fileList incidentName:self.eventName incidentContent:self.eventDesc receiverType:_receiverType receiverDepartCode:self.departCodeString receiverDepartName:self.eventDepartString receiverPersonName:self.eventPeopleString receiverPersonCode:self.peopleCodeString riverCode:_detailDataModel.riverCode patrolCode:@"" longitude:nil latitude:nil positionDesc:nil incidentCode:_detailDataModel.incidentCode];

        [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            ZLBaseModel *model = [[ZLBaseModel alloc]initWithString:request.responseString error:nil];
            
            if ([model.code isEqualToString:@"0"]) {
                
                [SVProgressHUD showSuccessWithStatus:@"上报成功"];
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] init];
    ACSelectMediaView *mediaView = [[ACSelectMediaView alloc] initWithFrame:CGRectMake(0,  0, self.view.frame.size.width, 1)];
    mediaView.showDelete = YES;
    mediaView.showAddButton = YES;
    //png、jpg、gif(本地和网络)
    if (self.detailDataModel) {
        if (self.detailDataModel.imgList.count > 0) {
            self.imageTempArray = [NSMutableArray array];
            [self.imageArray removeAllObjects];
            
            for (int i = 0; i < self.detailDataModel.imgList.count; i++) {
                ZLTaskInfoImageListModel *imageModel = self.detailDataModel.imgList[i];
                NSString *urlString = [NSString stringWithFormat:@"%@%@",BaseImage_URL, imageModel.fileAddr];
                [_imageTempArray addObject:urlString];
                
                ACMediaModel *mediaModel = [[ACMediaModel alloc]init];
                mediaModel.imageUrlString = urlString;
                
                mediaModel.imageListModel = imageModel;
                [self.imageArray addObject:mediaModel];
            }
            
            mediaView.preShowMedias = self.imageArray;
        }
    }
    mediaView.allowMultipleSelection = NO;
    mediaView.allowPickingVideo = NO;
    mediaView.rootViewController = self;
    mediaView.maxImageSelected = 8;
    self.mediaView = mediaView;
    
    ZLNewReportBottomView *bottomView = [[ZLNewReportBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mediaView.frame) + 50, Main_Screen_Width, 50 * kScreenHeightRatio) withTitles:@[@"保存",@"上报"]];
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
//
//    _mainTableView.contentInset =UIEdgeInsetsMake(-35,0,0,0);
//
//    _mainTableView.contentSize = CGSizeMake(Main_Screen_Width, 3* Main_Screen_Height);
    
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
//        static NSString *CellIdentifier = @"ZLReprotEventBaseTableViewCell";
//        ZLReprotEventBaseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
//        if (cell == nil) {
//            cell = [[ZLReprotEventBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
        
        ZLReprotEventBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLReprotEventBaseTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        
        if ([self.detailDataModel.isFirst isEqualToString:@"NO"]) {
            cell.infoTextView.text = self.detailDataModel.incidentName;
            self.eventName = self.detailDataModel.incidentName;
            
        }
        cell.infoTextView.tag = indexPath.row;
        
        cell.getText = ^(NSString *text, NSInteger tag) {
            
            switch (0) {
                case 0:
                    self.eventName = text;
//                    self.detailDataModel.incidentName = text;
                    break;
            }
            
        };
        
        return cell;
    }
    
    if (indexPath.row == 1) {
//        static NSString *CellIdentifier = @"ZLReportPeopleTableViewCell";
//        ZLReportPeopleTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
//        if (cell == nil) {
//            cell = [[ZLReportPeopleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
        
        ZLReportPeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLReportPeopleTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        
        cell.imageV.image = [UIImage imageNamed:@"home_seletPeople"];
        
        if ([self.detailDataModel.isFirst isEqualToString:@"NO"]) {
            
            cell.infoTextView.text = self.detailDataModel.receiverPersonName;
            self.peopleCodeString = _detailDataModel.receiverPersonCode;
            self.eventPeopleString = _detailDataModel.receiverPersonName;
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
                        self.eventPeopleString = @"";
                        
                    }
                    
//                    self.detailDataModel.receiverPersonName = text;
                }
                    break;
            }
        };
        
        return cell;
    }
    
    if (indexPath.row == 2) {
        
//        static NSString *CellIdentifier = @"ZLReportPeopleTableViewCell";
//        ZLReportPeopleTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
//        if (cell == nil) {
//            cell = [[ZLReportPeopleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
        
        
        ZLReportDepartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLReportDepartTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        cell.imageV.image = [UIImage imageNamed:@"departSelect"];
        
        if ([self.detailDataModel.isFirst isEqualToString:@"NO"]) {
            
            cell.infoTextView.text = self.detailDataModel.receiverDepartName;
            self.departCodeString = _detailDataModel.receiverDepartCode;
            self.eventDepartString = _detailDataModel.receiverDepartName;
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
                        self.eventDepartString = @"";
                    }
//                    self.detailDataModel.receiverDepartName = text;
//                    _detailDataModel.receiverDepartCode = self.departCodeString;
//                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
                }
                    break;
            }
        };
        return cell;
    }
    if (indexPath.row == 3) {
        
//        static NSString *CellIdentifier = @"ZLReportEventDesTableViewCell";
//        ZLReportEventDesTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
//        if (cell == nil) {
//            cell = [[ZLReportEventDesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
        
        
        ZLReportEventDesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLReportEventDesTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        
        if ([self.detailDataModel.isFirst isEqualToString:@"NO"]) {
            
            cell.infoTextView.text = self.detailDataModel.incidentContent;
            self.eventDesc = self.detailDataModel.incidentContent;
        }
        
        self.detailDataModel.isFirst = @"YES";
        
        return cell;
    }
    
    
    
    
    return nil;
    
}

- (NSArray *)sourceArray{
    if (!_sourceArray) {
        _sourceArray = @[@"事件名称：",
                         @"接收人：",
                         @"接收部门：",
                         @"事件描述："];
        
        
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


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLReportPeopleTableViewCell class] forCellReuseIdentifier:@"ZLReportPeopleTableViewCell"];
        [_mainTableView registerClass:[ZLReprotEventBaseTableViewCell class] forCellReuseIdentifier:@"ZLReprotEventBaseTableViewCell"];
        [_mainTableView registerClass:[ZLReportEventDesTableViewCell class] forCellReuseIdentifier:@"ZLReportEventDesTableViewCell"];
        
        [_mainTableView registerClass:[ZLReportDepartTableViewCell class]  forCellReuseIdentifier:@"ZLReportDepartTableViewCell"];
        
        
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.bounces = NO;
        _mainTableView.showsVerticalScrollIndicator = NO;
        
        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _mainTableView.estimatedRowHeight = 100;
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
//        _mainTableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
        
    }
    return _mainTableView;
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"事件修改" attributes:dic];
    
    return title;
    
}

@end
