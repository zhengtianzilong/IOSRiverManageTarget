//
//  ZLHomeRiverRunningView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/7.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLHomeRiverRunningView.h"
#import "AppDelegate.h"
#import "ZLGaodeViewController.h"
@interface ZLHomeRiverRunningView ()



@end

@implementation ZLHomeRiverRunningView

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.imageView];
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.peopleLabel];
        
        [self addSubview:self.checkLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.stateLabel];
        
        [self setUI];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(runningClick)];
        
        [self addGestureRecognizer:tap];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTimeLabel:) name:@"RunningTime" object:nil];
        
        
    }
    return self;
    
    
}

- (void)changeTimeLabel:(NSNotification *)notification{
    
//    self.timeLabel.text = [NSString stringWithFormat:@"%@%@",notification.userInfo[@"time"], @"分钟"];
    self.titleLabel.text = notification.userInfo[@"riverTitle"];
}


- (void)setUI{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10);
//        make.width.mas_equalTo(90);
//        make.top.equalTo(self);
//        make.height.mas_equalTo(90);
        make.centerY.equalTo(self);
//        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.imageView.mas_right).offset(10);
        make.top.equalTo(self.imageView);
        make.width.mas_equalTo((Main_Screen_Width - 100) / 2);
        
    }];
    [self.peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.imageView.mas_right).offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.width.mas_equalTo((Main_Screen_Width - 100) / 2);
        
    }];
    
    [self.checkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.imageView);
//        make.width.mas_equalTo((Main_Screen_Width - 100) / 2);
        make.height.mas_equalTo(20);
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.imageView.mas_bottom);
        //        make.width.mas_equalTo((Main_Screen_Width - 100) / 2);
        make.height.mas_equalTo(20);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.stateLabel.mas_top);
        //        make.width.mas_equalTo((Main_Screen_Width - 100) / 2);
        make.height.mas_equalTo(20);
    }];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
   
    
}

- (UIImageView *)imageView{
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_runningRiver"]];
        _imageView.userInteractionEnabled = YES;
//        [_imageView addTarget:self action:@selector(runningClick) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _imageView;
}

- (UILabel *)titleLabel{

    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = CHINESE_SYSTEM(16);
        _titleLabel.text = @"莫愁湖河段";
    }
    return _titleLabel;
    
}

- (UILabel *)peopleLabel{
    
    if (!_peopleLabel) {
        _peopleLabel = [[UILabel alloc]init];
        _peopleLabel.font = CHINESE_SYSTEM(14);
        _peopleLabel.text = @"李乐乐";
    }
    return _peopleLabel;
    
}

- (UILabel *)checkLabel{
    
    if (!_checkLabel) {
        _checkLabel = [[UILabel alloc]init];
        _checkLabel.font = CHINESE_SYSTEM(14);
        _checkLabel.text = @"巡河中请查看";
        _checkLabel.textColor = [UIColor orangeColor];
    }
    return _checkLabel;
    
}

- (UILabel *)timeLabel{
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = CHINESE_SYSTEM(14);
        _timeLabel.text = @"0分钟";
        _timeLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _timeLabel;
    
}

- (UILabel *)stateLabel{
    
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.text = @"已经巡河";
        _stateLabel.font = CHINESE_SYSTEM(14);
    }
    return _stateLabel;
    
}


- (void)runningClick{
    AppDelegate *deleage = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (deleage.floatWindow.presentView != nil) {
         [deleage.floatWindow click:nil];
        
        
    }else{
        
        ZLGaodeViewController *vc = [[ZLGaodeViewController alloc]init];
        
        
        vc.riverDataModel = self.riverDataModel;
        
        
        [self.viewController presentViewController:vc animated:YES completion:nil];
        
    }
    
    
   
    
}


@end
