//
//  ZLRiverInfoBaseChangeVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/8.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverAddIntakeVC.h"
#import "ZLGaodeCustomNavBar.h"
#import "ZLRiverInfoBaseChangeTableViewCell.h"
#import "ZLSureBtnFooterView.h"
#import "ZLRiverInfoBaseChangeNoteTableViewCell.h"
#import "ZLNewAddIntakeService.h"
#import "ZLBaseModel.h"
#import "ACSelectMediaView.h"
#import "ZLNewFilesUpLoadService.h"
#import "ZLUploadImagesModel.h"
@interface ZLRiverAddIntakeVC ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSArray *sourceArray;
@property(nonatomic, strong) NSArray *placeHolderArray;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *code;

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *contactPeople;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *note;

@property (nonatomic, strong) ACSelectMediaView *mediaView;
@property (nonatomic, strong) NSArray<ACMediaModel *> *imageArray;
@property (nonatomic, strong) NSMutableArray *imageNameArray;
@end

@implementation ZLRiverAddIntakeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.name = @"";
    self.code = @"";
    self.contactPeople = @"";
    self.phone = @"";
    self.note = @"";
    self.imageArray = [NSArray array];
    self.imageNameArray = [NSMutableArray array];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ZLGaodeCustomNavBar *navBar = [[ZLGaodeCustomNavBar alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, TopBarHeight)];
    navBar.titleLabel.text = @"新增取水口";
    [navBar.backButton addTarget:self action:@selector(backClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:navBar];
    
    navBar.backgroundColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    [self.view addSubview:navBar];
    
    [self.view addSubview:self.mainTableView];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(TopBarHeight);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];
    
    
}

- (void)backClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/**
 检测文本框的内容
 */
- (BOOL)checkTextFieldContent{
    
    if ([self.name isEqualToString:@""]) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"请填写取水口名称" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
        return NO;
    }
    
    if ([self.code isEqualToString:@""]) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"请填写取水口编码" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return NO;
    }
    
    if ([self.address isEqualToString:@""]) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"请填写位置信息" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return NO;
    }
    
    if ([self.contactPeople isEqualToString:@""]) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"请填写联系人" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return NO;
    }
    
    if ([self.phone isEqualToString:@""]) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"请填写联系人电话" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return NO;
    }
    
    if ([self.note  isEqualToString:@""]) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"请填写取水用途" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return NO;
    }
    
    return YES;
}


/**
 确定按钮
 */
- (void)sureButtonClick{
    
    if (self.address == nil) {
        
        self.address = self.locationModel.addressDetail;
        
    }
    
    if (![self checkTextFieldContent]) {
        return;
    }
    
    DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"提示" message:@"确认提交吗?" cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    
    alert.otherButtonAction = ^{
         [self.imageNameArray removeAllObjects];
        [SVProgressHUD showWithStatus:@"正在添加"];
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
            
            ZLNewAddIntakeService *service = [[ZLNewAddIntakeService alloc]initWithriverCode:_riverDataModel.riverCode code:self.code name:self.name longitude:self.locationModel.longitude latitude:self.locationModel.latitude contant:self.note contactperson:self.contactPeople phone:self.phone address:self.address imgList:self.imageNameArray];
            
            [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                
                ZLBaseModel *baseModel =[[ZLBaseModel alloc]initWithString:request.responseString error:nil];
                
                if ([baseModel.code isEqualToString:@"0"]) {
                    
                    [SVProgressHUD showSuccessWithStatus:@"添加成功"];
                    
                    [SVProgressHUD dismissWithDelay:0.4 completion:^{
                        
                        [self backClick];
                        
                    }];
                }else{
                    [SVProgressHUD showErrorWithStatus:baseModel.detail];
                    [SVProgressHUD dismissWithDelay:0.6];
                    
                }
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                
                [SVProgressHUD showErrorWithStatus:@"添加失败"];
                [SVProgressHUD dismiss];
            }];
        });
    };
    [alert show];
    
    
    
    
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
    
    if (indexPath.row == 2) {
        ZLRiverInfoBaseChangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLRiverInfoBaseChangeTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        cell.infoTextView.text = cell.infoTextView.text = self.locationModel.addressDetail;
        
        cell.infoTextView.tag = indexPath.row;
        
        cell.getText = ^(NSString *text, NSInteger tag) {
            
            switch (tag) {
                case 2:
                    self.address = text;
                    break;
            }
            
        };

        
        return cell;
    }else if (indexPath.row == 5) {
        ZLRiverInfoBaseChangeNoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLRiverInfoBaseChangeNoteTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        
        cell.infoTextView.tag = indexPath.row;
        
        cell.getText = ^(NSString *text, NSInteger tag) {
            
            switch (tag) {
                case 5:
                    self.note = text;
                    break;
            }
            
        };
        
        return cell;
    }else{
        
        ZLRiverInfoBaseChangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLRiverInfoBaseChangeTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.infoTextView.tag = indexPath.row;
        
        cell.getText = ^(NSString *text, NSInteger tag) {
            
            switch (tag) {
                case 0:
                    self.name = text;
                    break;
                case 1:
                    self.code = text;
                    break;
                case 3:
                    self.contactPeople = text;
                    break;
                case 4:
                    self.phone = text;
                    break;
            }
            
        };
        
        
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        return cell;
        
    }
    return nil;
    
}

- (NSArray *)sourceArray{
    if (!_sourceArray) {
        _sourceArray = @[@"取水口名称：",
                         @"取水口编码：",
                         @"位置：",
                         @"联系人：",
                         @"联系电话：",
                         @"取水用途："];
    }
    return _sourceArray;
}
- (NSArray *)placeHolderArray{
    if (!_placeHolderArray) {
        _placeHolderArray = @[@"请输入名称",
                              @"请输入编码",
                              @"请输入位置",
                              @"请输入联系人",
                              @"请输入电话",
                              @"请输入用途",];
        
        
    }
    return _placeHolderArray;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLRiverInfoBaseChangeTableViewCell class] forCellReuseIdentifier:@"ZLRiverInfoBaseChangeTableViewCell"];
        [_mainTableView registerClass:[ZLRiverInfoBaseChangeNoteTableViewCell class] forCellReuseIdentifier:@"ZLRiverInfoBaseChangeNoteTableViewCell"];
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
        mediaView.maxImageSelected = 4;
        self.mediaView = mediaView;
        
        
        ZLSureBtnFooterView *bottomView = [[ZLSureBtnFooterView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
        
        [bottomView.sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        
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

@end
