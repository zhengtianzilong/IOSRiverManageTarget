//
//  ZLMyEventAdviseVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyEventAdviseVC.h"
#import "ZLEvent_ReportView.h"
#import "ACMediaFrame.h"
#import "ZLContinueEventReportService.h"
#import "ZLNomalEventModel.h"
#import "ZLMyAdviseBottomView.h"
#import "ZLAlertSelectionView.h"
@interface  ZLMyEventAdviseVC()
@property (nonatomic, strong) UIScrollView *mainScrollview;
// 提交按钮
//@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) ZLMyAdviseBottomView *advisebottomView;

@property (nonatomic ,assign) CGFloat height;

@property (nonatomic, strong) ZLEvent_ReportView *reportView;

// 照片数组
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation ZLMyEventAdviseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = HEXCOLOR(0xf4f4f4);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.mainScrollview];
    
    _reportView = [[ZLEvent_ReportView alloc]initWithFrame:CGRectMake(0, 10, App_Frame_Width, AdaptedHeight(345)) andHasEventNameObject:NO hasLeader:NO];
    
    _reportView.thirdView.nameLabel.text = @"我的意见";
    _reportView.noteTextView.placeholderText = @"请输入意见内容(140字以内)";
    [self.mainScrollview addSubview:_reportView];
    
    ACSelectMediaView *mediaView =[[ACSelectMediaView alloc]initWithFrame:CGRectMake(0, AdaptedHeight(345) + 10, App_Frame_Width, App_Frame_Width / 4)];
    mediaView.type = ACMediaTypePhotoAndCamera;
    mediaView.maxImageSelected = 8;
    mediaView.allowPickingVideo = NO;
    [self.mainScrollview addSubview:mediaView];
    self.height = App_Frame_Width / 4;
    [mediaView observeViewHeight:^(CGFloat mediaHeight) {
        
        ZLLog(@"%f",mediaHeight);
        
        CGFloat h = mediaHeight - self.height;
//        ZLLog(@"%f",CGRectGetMaxY(self.commitBtn.frame));
        self.mainScrollview.contentSize = CGSizeMake(Main_Screen_Width, self.mainScrollview.frame.size.height + h);
    }];
    
    [mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel *> *list) {
        _imageArray = list;
    }];

    
    [self.mainScrollview addSubview:self.advisebottomView];
    
    [self.advisebottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mainScrollview);
        make.top.equalTo(mediaView.mas_bottom).offset(50);
        make.height.mas_equalTo(60);
        make.left.equalTo(_mainScrollview.mas_left).offset(AdaptedWidth(0));
        make.right.equalTo(_mainScrollview.mas_right).offset(-AdaptedWidth(0));
    }];
    
}


/**
 点击确定按钮
 
 @param button 确定按钮
 */
- (void)commitClick:(UIButton *)button{
    
    ZLLog(@"name:%@",self.reportView.firstView.eventTextfiled.text);
    ZLLog(@"object:%@",self.reportView.secondView.eventTextfiled.text);
    ZLLog(@"des:%@",self.reportView.noteTextView.text);
    
    NSString *imageString = [self getImageBase64String];
    if ([self checkTextFieldContent]) {
        [self startServiceWithImageString:imageString];
    }
    
    
}


/**
 得到图片base64字符串
 
 @return 图片base64字符串
 */
- (NSString *)getImageBase64String{
    NSMutableArray *imageArray = [NSMutableArray array];
    NSString *imageString = @"";
    if (_imageArray.count > 0) {
        
        for (ACMediaModel *model in _imageArray) {
            NSData *data = UIImageJPEGRepresentation(model.image, 0.5);
            NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            [imageArray addObject:encodedImageStr];
        }
        imageString = [imageArray componentsJoinedByString:@","];
        
    }
    return imageString;
    
}

/**
 检测文本框的内容
 */
- (BOOL)checkTextFieldContent{
    if ([_reportView.secondView.eventTextfiled.text isEqualToString:@""]) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"必须选择上报对象" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        
        return NO;
    }
    
    return YES;
}

/**
 上传网络数据
 
 @param imageString 图片base64字符串
 */
- (void)startServiceWithImageString:(NSString *)imageString {
//    ZLContinueEventReportService *continueService = [[ZLContinueEventReportService alloc]
//                                                     initWitheventContent:self.reportView.noteTextView.text uid:_uid eid:_eid leaderIds:_reportView.liable_id dataImgBase:imageString];
//    
//    [SVProgressHUD showWithStatus:@"事件上报中"];
//    
//    [continueService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        
//        NSDictionary *dic = request.responseObject;
//        
//        if ([dic[@"code"] isEqualToString:@"0"]) {
//            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
//            
//            [SVProgressHUD dismissWithDelay:0.3 completion:^{
//                [self.navigationController popViewControllerAnimated:YES ];
//            }];
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"上报失败"];
//            [SVProgressHUD dismissWithDelay:0.3];
//        }
//        
//        
//        
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        ZLLog(@"%@",request);
//        [SVProgressHUD showErrorWithStatus:@"上传失败"];
//        [SVProgressHUD dismissWithDelay:0.3];
//    }];
    
}


/**
 继续上报
 */
- (void)reportClick{
    
    NSMutableArray *sourceArray = [NSMutableArray arrayWithObjects:@"李伟",
                                   @"李青",
                                   @"张友善",
                                   @"刘霞",
                                   @"刘霞",
                                   @"刘霞",
                                   @"刘霞",
                                   @"刘霞",
                                   @"刘霞",
                                   @"刘霞",
                                   @"刘霞",nil];
    
    ZLAlertSelectionView *alert = [[ZLAlertSelectionView alloc]initWithFrame:CGRectZero sourceArray:sourceArray withTitle:@"上报对象" sureTitle:@"上报" singleSelection:NO];
    [alert show];
    
    alert.selectItem = ^(NSInteger index) {

    };

}


/**
 办结事件
 */
- (void)endClick{
    
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 1) {
            
            
            
        }
        
    } title:@"提醒" message:@"是否办结事件" cancelButtonName:@"取消" otherButtonTitles:@"办结", nil];
    
    
    
}

- (UIScrollView *)mainScrollview{
    if (!_mainScrollview) {
        
        _mainScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - TopBarHeight) ];
        _mainScrollview.backgroundColor = HEXCOLOR(0xf4f4f4);
        _mainScrollview.showsVerticalScrollIndicator = NO;
    }
    return _mainScrollview;
}

- (ZLMyAdviseBottomView *)advisebottomView{
    
    if (!_advisebottomView) {
        
        _advisebottomView = [[ZLMyAdviseBottomView alloc]initWithFrame:CGRectZero withTitles:@[@"事件反馈",@"取消反馈"]];
        
        [_advisebottomView.endButton setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
        _advisebottomView.endButton.backgroundColor = [UIColor whiteColor];
        
        [_advisebottomView.startButton addTarget:self action:@selector(reportClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        [_advisebottomView.endButton addTarget:self action:@selector(endClick) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _advisebottomView;
    
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
