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
//#import "ZLRiverInfoBaseChangeAreaTableViewCell.h"
#import "ZLNewAddIntakeService.h"
#import "ZLBaseModel.h"
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

@end

@implementation ZLRiverAddIntakeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
}


- (void)backClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


/**
 确定按钮
 */
- (void)sureButtonClick{
    
    if (self.address == nil) {
        
        self.address = self.locationModel.addressDetail;
        
    }
    
    ZLNewAddIntakeService *service = [[ZLNewAddIntakeService alloc]initWithriverCode:_riverDataModel.riverCode code:self.code name:self.name longitude:self.locationModel.longitude latitude:self.locationModel.latitude contant:self.note contactperson:self.contactPeople phone:self.phone address:self.address];
    [SVProgressHUD showWithStatus:@"正在添加"];
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
        _sourceArray = @[@"取水口名称:",
                         @"取水口编码:",
                         @"位置:",
                         @"联系人:",
                         @"联系电话:",
                         @"取水用途:"];
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
        
        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _mainTableView.estimatedRowHeight = 100;
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        ZLSureBtnFooterView *footerView = [[ZLSureBtnFooterView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
        
        [footerView.sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        _mainTableView.tableFooterView = footerView;
    }
    return _mainTableView;
}

@end
