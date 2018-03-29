//
//  ZLRiverBilidChangeVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/13.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverBilidChangeVC.h"
#import "ZLGaodeCustomNavBar.h"
#import "ZLRiverInfoBaseChangeTableViewCell.h"
#import "ZLRiverInfoBaseChangeAreaTableViewCell.h"
#import "ACMediaFrame.h"
#import "UIView+RoundedCorner.h"
#import "ZLNewAddPublicBrandService.h"
#import "ZLBaseModel.h"
#import "ZLNewFilesUpLoadService.h"
#import "ZLUploadImagesModel.h"
@interface ZLRiverBilidChangeVC ()<UITableViewDelegate, UITableViewDataSource, YTKChainRequestDelegate>


@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSArray *sourceArray;

@property (nonatomic, strong) ACSelectMediaView *mediaView;
@property(nonatomic, strong) NSArray *placeHolderArray;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSArray<ACMediaModel *> *imageArray;

@end

@implementation ZLRiverBilidChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageArray = [NSArray array];
    
    ZLGaodeCustomNavBar *navBar = [[ZLGaodeCustomNavBar alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, TopBarHeight)];
    navBar.titleLabel.text = @"新增公示牌";
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

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
}


- (void)backClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


/**
 点击确定按钮
 */
- (void)sureBtnClick{
    if (self.address == nil) {
        self.address = self.locationModel.addressDetail;
    }

    YTKChainRequest *chain = [[YTKChainRequest alloc]init];
    ZLNewFilesUpLoadService *fileService = [[ZLNewFilesUpLoadService alloc]initWithImage:self.imageArray];
    
    [chain addRequest:fileService callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
        
        ZLNewFilesUpLoadService *fileService = (ZLNewFilesUpLoadService *)baseRequest;
        
        ZLLog(@"%@",fileService.responseString);
        
        ZLUploadImagesModel *model = [[ZLUploadImagesModel alloc]initWithString:fileService.responseString error:nil];
        
        if ([model.code isEqualToString:@"0"]) {
            
            ZLTaskInfoImageListModel *imageModel = model.data.firstObject;
            
             ZLNewAddPublicBrandService *service = [[ZLNewAddPublicBrandService alloc]initWithriverCode:_riverDataModel.riverCode imgUrl:imageModel.fileAddr name:self.name longitude:self.locationModel.longitude latitude:self.locationModel.latitude detail:self.address];

            [chainRequest addRequest:service callback:nil];

        }else{
            [SVProgressHUD showErrorWithStatus:model.detail];
            [SVProgressHUD dismissWithDelay:0.3];
        }
        
        
    }];
    
    chain.delegate = self;
    [chain start];
}
- (void)chainRequestFinished:(YTKChainRequest *)chainRequest{
    
    ZLNewFilesUpLoadService *request = (ZLNewFilesUpLoadService *)chainRequest.requestArray[0];
    
    ZLUploadImagesModel *model = [[ZLUploadImagesModel alloc]initWithString:request.responseString error:nil];
    
    if ([model.code isEqualToString:@"0"]) {
        
        ZLNewAddPublicBrandService *getObject = (ZLNewAddPublicBrandService *)chainRequest.requestArray[1];
        
        ZLBaseModel *baseModel =[[ZLBaseModel alloc]initWithString:getObject.responseString error:nil];
        
        if ([baseModel.code isEqualToString:@"0"]) {
            
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            
            [SVProgressHUD dismissWithDelay:0.4 completion:^{
                
                [self backClick];
                
            }];
        
        }else{
            
            [SVProgressHUD showInfoWithStatus:baseModel.detail];
            [SVProgressHUD dismissWithDelay:0.3];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:model.detail];
        [SVProgressHUD dismissWithDelay:0.3];
    }
}



- (void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(YTKBaseRequest *)request{
    
    ZLLog(@"%@",request.response);
//    [SVProgressHUD dismiss];
    [SVProgressHUD showInfoWithStatus:@"网络错误"];
    [SVProgressHUD dismissWithDelay:0.3];
    
    
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

//        ZLRiverInfoBaseChangeAreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLRiverInfoBaseChangeAreaTableViewCell" forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;

        ZLRiverInfoBaseChangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLRiverInfoBaseChangeTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        
        cell.infoTextView.text = self.locationModel.addressDetail;
        
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        cell.infoTextView.text = cell.infoTextView.text = self.locationModel.addressDetail;
        cell.infoTextView.tag = indexPath.row;
        
        cell.getText = ^(NSString *text, NSInteger tag) {
            
            switch (1) {
                case 1:
                    self.address = text;
                    break;
            }
            
        };
        
        return cell;
    
    }else{
    
        ZLRiverInfoBaseChangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLRiverInfoBaseChangeTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.infoTextView.zw_placeHolder = self.placeHolderArray[indexPath.row];
        cell.titleLabel.text = self.sourceArray[indexPath.row];
        cell.infoTextView.tag = indexPath.row;
        cell.getText = ^(NSString *text, NSInteger tag) {
            
            switch (0) {
                case 0:
                    self.name = text;
                    break;
            }
            
        };
        
        return cell;
        
    }
    return nil;
    
}

- (NSArray *)sourceArray{
    if (!_sourceArray) {
        _sourceArray = @[@"公示牌名:",
                         @"位置:"];
    }
    return _sourceArray;
}

- (NSArray *)placeHolderArray{
    if (!_placeHolderArray) {
        _placeHolderArray = @[@"请输入名称",
                              @"请输入位置"];
        
        
    }
    return _placeHolderArray;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLRiverInfoBaseChangeTableViewCell class] forCellReuseIdentifier:@"ZLRiverInfoBaseChangeTableViewCell"];
//        [_mainTableView registerClass:[ZLRiverInfoBaseChangeAreaTableViewCell class] forCellReuseIdentifier:@"ZLRiverInfoBaseChangeAreaTableViewCell"];
        
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        _mainTableView.showsVerticalScrollIndicator = NO;
        
        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _mainTableView.estimatedRowHeight = 100;
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        
        UIView *headerView = [[UIView alloc] init];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-10, 1)];
        lineView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        [headerView addSubview:lineView];
        
        UIView *labView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, 50)];
        labView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:labView];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width, 30)];
        lab.text = @"公示牌照片:";
        lab.font = CHINESE_SYSTEM(17);
        [headerView addSubview:lab];
        
        
        ACSelectMediaView *mediaView = [[ACSelectMediaView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lab.frame) + 10, CGRectGetWidth(lab.frame), 1)];
        mediaView.showDelete = YES;
        mediaView.showAddButton = YES;
        mediaView.allowMultipleSelection = NO;
        mediaView.maxImageSelected = 1;
        mediaView.allowPickingVideo = NO;
        mediaView.rootViewController = self;
        self.mediaView = mediaView;
        
        
        UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(mediaView.frame) + 50, Main_Screen_Width - 20, 50)];
        
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        [sureBtn setTitle:@"登录" forState:(UIControlStateNormal)];
        
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
            
            self.imageArray = list;
            
//            [self.imageArray removeAllObjects];
//
//            for (ACMediaModel *model in list) {
//
//                [self.imageArray addObject:model];
//
//            }
        }];
        [headerView addSubview:mediaView];
        
        [headerView addSubview:sureBtn];
         [sureBtn jm_setCornerRadius:6 withBackgroundColor:HEXCOLOR(CNAVGATIONBAR_COLOR)];
        headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, CGRectGetMaxY(mediaView.frame));
        _mainTableView.tableFooterView = headerView;
   
    }
    return _mainTableView;
}
@end
