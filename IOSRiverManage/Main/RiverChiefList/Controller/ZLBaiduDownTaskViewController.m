//
//  ZLBaiduDownTaskViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/26.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLBaiduDownTaskViewController.h"
#import "ZLBaiduDownTaskView.h"
#import "ZLBaiduReportBottomView.h"
#import "ACMediaFrame.h"
#import "UIView+Frame.h"
#import "ZLEventReportViewController.h"
#import "ZLBaiduRiverInfoView.h"
#import "ACMediaModel.h"
#import "ZLRiverDownTaskService.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "WJYAlertView.h"
#import "ZLLoginModel.h"
@interface ZLBaiduDownTaskViewController ()<BMKGeoCodeSearchDelegate,BMKGeoCodeSearchDelegate>
@property (nonatomic, strong) UIScrollView *mainScrollview;
@property (nonatomic ,assign) CGFloat height;

@property (nonatomic ,strong) ZLBaiduDownTaskView *reportView;

// 照片数组
@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation ZLBaiduDownTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    ZLBaiduReportBottomView *bottomView = [[ZLBaiduReportBottomView alloc]init];
    [bottomView.startReportButton setTitle:@"立即下发" forState:(UIControlStateNormal)];
    [bottomView.endReportButton setTitle:@"取消下发" forState:(UIControlStateNormal)];
    [bottomView.startReportButton addTarget:self action:@selector(startReportClick) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView.endReportButton addTarget:self action:@selector(endReportClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.width.mas_equalTo(App_Frame_Width);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(AdaptedHeight(115));
        
    }];
    
    
    
    self.mainScrollview = [[UIScrollView alloc]init];
    self.mainScrollview.backgroundColor = HEXCOLOR(0xf4f4f4);
    self.mainScrollview.showsVerticalScrollIndicator = NO;
    self.mainScrollview.scrollEnabled = YES;
    
    [self.view addSubview:self.mainScrollview];
    [self.mainScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.bottom.equalTo(bottomView.mas_top);
        make.width.mas_equalTo(App_Frame_Width);
        make.height.mas_equalTo(App_Frame_Height * 0.9 - AdaptedHeight(115) - AdaptedHeight(170));
    }];
    
    ZLBaiduRiverInfoView *infoView = [[ZLBaiduRiverInfoView alloc]init];
    infoView.demandModel = _demandModel;
    
    [self.mainScrollview addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo( self.mainScrollview);
        make.width.mas_equalTo(App_Frame_Width);
        make.height.mas_equalTo(AdaptedHeight(170));
        make.top.equalTo(self.mainScrollview);
        
    }];
    
    _reportView = [[ZLBaiduDownTaskView alloc]initWithFrame:CGRectZero riverId:_demandModel.riverId];
    _reportView.backgroundColor = [UIColor whiteColor];
    _reportView.reportObjectView.nameLabel.text = @"下发对象：";
    [self.mainScrollview addSubview:_reportView];
    [_reportView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mainScrollview);
        make.width.mas_equalTo(App_Frame_Width);
        make.top.equalTo(infoView.mas_bottom);
        make.height.mas_equalTo(AdaptedHeight(550));
        
    }];
    
    [_reportView.superview layoutSubviews];
    
    
    
    ACSelectMediaView *mediaView =[[ACSelectMediaView alloc]initWithFrame:CGRectMake(0, _reportView.bottom, App_Frame_Width, App_Frame_Width / 4)];
    mediaView.type = ACMediaTypePhotoAndCamera;
    mediaView.maxImageSelected = 8;
    mediaView.allowPickingVideo = NO;
    [self.mainScrollview addSubview:mediaView];
    self.height = App_Frame_Width / 4;
    mediaView.naviBarBgColor = HEXCOLOR(KNavBarBG_color_blue);
    [mediaView observeViewHeight:^(CGFloat mediaHeight) {
        
        ZLLog(@"%f",mediaHeight);
        
        CGFloat h = mediaHeight - self.height;
        
        self.mainScrollview.contentSize = CGSizeMake(Main_Screen_Width, mediaView.bottom + h);
    }];
    
    _imageArray = [NSArray array];
    [mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel *> *list) {
        
        _imageArray = list;
        
    }];
    
    
    self.mainScrollview.contentSize = CGSizeMake(App_Frame_Width,mediaView.bottom);
    
}



-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:ULoginModel];
//    ZLLoginModel *loginModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    YTKKeyValueStore *store = [[ZLDBStoreManager shareDbStoreManager] createDB];
    NSString *json = [store getStringById:DBLoginModel fromTable:DBUserTable];
    ZLLoginModel *loginModel = [[ZLLoginModel alloc]initWithString:json error:nil];
    
    NSString *riverPeople = loginModel.realName;
    if (riverPeople.length > 0) {
        
        _reportView.riverPeopleView.eventTextfiled.text = riverPeople;
        
    }
//    NSString *address = [[NSUserDefaults standardUserDefaults]objectForKey:@"address"];
//    
//    if (address.length > 4) {
//        _reportView.addressView.eventTextfiled.text = address;
//    }
}

- (void)startReportClick
{
    NSString *title = _reportView.titleView.eventTextfiled.text;
    //    NSString *riverPeople = _reportView.riverPeopleView.eventTextfiled.text;
    NSString *reportObject = _reportView.reportObjectView.eventTextfiled.text;
    NSString *address = _reportView.addressView.eventTextfiled.text;
    NSString *note = _reportView.noteTextView.text;
    
    NSMutableArray *imageArray = [NSMutableArray array];
    NSString *imageString = @"";
    if (_imageArray.count > 0) {
        
        for (ACMediaModel *model in _imageArray) {
            NSData *data = UIImageJPEGRepresentation(model.image, 0.5);
            NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            [imageArray addObject:encodedImageStr];
            ZLLog(@"encodedImageStr==%@",encodedImageStr);
        }
        
        imageString = [imageArray componentsJoinedByString:@","];
        
    }
    
    NSNumber *lgtNum = [NSNumber numberWithDouble: _location.coordinate.longitude];
    NSString *lgt = [lgtNum stringValue];
    
    NSNumber *latNum = [NSNumber numberWithDouble: _location.coordinate.latitude];
    NSString *lat = [latNum stringValue];
    
    
    if ([title isEqualToString:@""]) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"必须填写标题" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return;
    }
    if ([reportObject isEqualToString:@""]) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"必须选择下发对象" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return;
    }
    
    ZLRiverDownTaskService *service = [[ZLRiverDownTaskService alloc]initWithtaskName:title taskContent:note positionDesc:address uuid:_uuid type:_type lgt:lgt lat:lat liable_id:_reportView.liable_id uid:_uid dataImgBase:imageString];
    
                                       
//                                        eventName:title eventContent:note positionDesc:address uuid:_uuid type:_type lgt:lgt lat:lat riverid:_demandModel.riverId liable_id:_reportView.liable_id uid:_uid dataImgBase:imageString];
    [SVProgressHUD showWithStatus:@"事件下发中"];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSDictionary *dic = request.responseObject;
        
        if ([dic[@"code"] isEqualToString:@"0"]) {
            [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
            [SVProgressHUD dismissWithDelay:0.3 completion:^{
                if (self.callback) {
                    self.callback(@"确定");
                }
                [self dismissViewControllerAnimated:YES completion:nil];   //菜单消失
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"下发失败"];
            [SVProgressHUD dismissWithDelay:0.3];
        }
        ZLLog(@"%@",request);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZLLog(@"%@",request);
        [SVProgressHUD showErrorWithStatus:@"下发失败请检查网络"];
        [SVProgressHUD dismissWithDelay:0.3];
    }];
    

    
    
    
}


- (void)endReportClick
{
    if (self.callback) {
        self.callback(@"取消");
    }
    [self dismissViewControllerAnimated:YES completion:nil];   //菜单消失
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
