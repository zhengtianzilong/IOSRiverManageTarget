//
//  ZLContinueEventSendDownViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/10/13.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLContinueEventSendDownViewController.h"
#import "ZLEvent_SendDownView.h"
#import "ACMediaFrame.h"
#import "ZLContinueEventSendDownService.h"
#import "ZLNomalEventModel.h"
@interface ZLContinueEventSendDownViewController ()
@property (nonatomic, strong) UIScrollView *mainScrollview;

// 提交按钮
@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic ,assign) CGFloat height;

@property (nonatomic, strong) ZLEvent_SendDownView *sendDownView;

// 照片数组
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation ZLContinueEventSendDownViewController

- (UIScrollView *)mainScrollview{
    if (!_mainScrollview) {
        
        _mainScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
        _mainScrollview.backgroundColor = HEXCOLOR(0xf4f4f4);
        _mainScrollview.showsVerticalScrollIndicator = NO;
    }
    return _mainScrollview;
}

- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [[UIButton alloc]init];
        [_commitBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        [_commitBtn setBackgroundColor:HEXCOLOR(KNavBarBG_color_blue)];
        _commitBtn.layer.cornerRadius = 3;
        _commitBtn.clipsToBounds = YES;
        [_commitBtn addTarget:self action:@selector(commitClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.mainScrollview addSubview:_commitBtn];
        
    }
    return _commitBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = HEXCOLOR(0xf4f4f4);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    self.mainScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    //    self.mainScrollview.backgroundColor = HEXCOLOR(0xf4f4f4);
    //    self.mainScrollview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.mainScrollview];
    
    _sendDownView = [[ZLEvent_SendDownView alloc]initWithFrame:CGRectMake(0, 10, App_Frame_Width, AdaptedHeight(345)) andHasEventNameObject:NO hasLeader:YES];
    [self.mainScrollview addSubview:_sendDownView];
    
    ACSelectMediaView *mediaView =[[ACSelectMediaView alloc]initWithFrame:CGRectMake(0, AdaptedHeight(345) + 10, App_Frame_Width, App_Frame_Width / 4)];
    mediaView.type = ACMediaTypePhotoAndCamera;
    mediaView.maxImageSelected = 8;
    mediaView.allowPickingVideo = NO;
    [self.mainScrollview addSubview:mediaView];
    self.height = App_Frame_Width / 4;
    [mediaView observeViewHeight:^(CGFloat mediaHeight) {
        
        ZLLog(@"%f",mediaHeight);
        
        CGFloat h = mediaHeight - self.height;
        
        ZLLog(@"%f",CGRectGetMaxY(self.commitBtn.frame));
        
        self.mainScrollview.contentSize = CGSizeMake(Main_Screen_Width, self.mainScrollview.frame.size.height + h);
        
        
    }];
    
    [mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel *> *list) {
        _imageArray = list;
    }];
    
    
    
    // 提交按钮
    //    self.commitBtn = [[UIButton alloc]init];
    //    [self.commitBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    //    [self.commitBtn setBackgroundColor:HEXCOLOR(KNavBarBG_color_blue)];
    //    self.commitBtn.layer.cornerRadius = 3;
    //    self.commitBtn.clipsToBounds = YES;
    //    [self.mainScrollview addSubview:self.commitBtn];
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mainScrollview);
        make.top.equalTo(mediaView.mas_bottom).offset(50);
        make.height.mas_equalTo(40);
        make.left.equalTo(_mainScrollview.mas_left).offset(AdaptedWidth(30));
        make.right.equalTo(_mainScrollview.mas_right).offset(-AdaptedWidth(30));
    }];
    
    //    [self.commitBtn addTarget:self action:@selector(commitClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
}

- (void)commitClick:(UIButton *)button{
    
    ZLLog(@"name:%@",_sendDownView.firstView.eventTextfiled.text);
    ZLLog(@"object:%@",_sendDownView.secondView.eventTextfiled.text);
    ZLLog(@"des:%@",_sendDownView.noteTextView.text);
    
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
    if ([_sendDownView.secondView.eventTextfiled.text isEqualToString:@""]) {
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"必须选择下发对象" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return NO;
    }
    
    
    if ([_sendDownView.firstView.eventTextfiled.text isEqualToString:@""]) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
        } title:@"提示" message:@"必须填写任务名称" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
        return NO;
    }
    return YES;
}


/**
 上传网络数据
 
 @param imageString 图片base64字符串
 */
- (void)startServiceWithImageString:(NSString *)imageString {
    ZLContinueEventSendDownService *continuDownService = [[ZLContinueEventSendDownService alloc]initWitheventContent:_sendDownView.noteTextView.text uid:_uid tid:_tid userIds:_sendDownView.liable_id dataImgBase:imageString];
    
    [SVProgressHUD showWithStatus:@"事件下发中"];
    
    [continuDownService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSDictionary *dic = request.responseObject;
        
        if ([dic[@"code"] isEqualToString:@"0"]) {
            [SVProgressHUD showSuccessWithStatus:@"下发成功"];
            
            [SVProgressHUD dismissWithDelay:0.3 completion:^{
                [self.navigationController popViewControllerAnimated:YES ];
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"下发失败"];
            [SVProgressHUD dismissWithDelay:0.3];
        }
        
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        ZLLog(@"%@",request);
        [SVProgressHUD showErrorWithStatus:@"下发失败 请检查网络"];
        [SVProgressHUD dismissWithDelay:0.3];
    }];
    
}


- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"继续下发" attributes:dic];
    
    return title;
    
}

@end
