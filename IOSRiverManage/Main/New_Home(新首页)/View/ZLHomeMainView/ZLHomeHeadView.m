//
//  ZLHomeHeadView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/5.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLHomeHeadView.h"
#import "ZLHomeRiverRunningModel.h"
#import "ZLNewUserRiversDataModel.h"

@interface ZLHomeHeadView()

@property (nonatomic, assign) BOOL isExit;
@property (nonatomic, strong) YTKKeyValueStore *store;


@end

@implementation ZLHomeHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        _isHideRunningView = YES;
        _isExit = NO;
        [self setUpViews];
        
        
    }
    return self;
    
}
- (void)setUpViews{
    
    [self addSubview:self.homeLoopImageView];
    [self addSubview:self.homeCenterView];
    
    
    
    [self.homeLoopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(0);
        make.width.mas_equalTo(Main_Screen_Width);
        make.height.mas_equalTo(Main_Screen_Width / 2.0 - 10);
    }];
    
    if (_isHideRunningView) {
        [self.homeCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.homeLoopImageView.mas_bottom).offset(10);
            make.centerX.equalTo(self);
            make.width.mas_equalTo(Main_Screen_Width);
            make.height.mas_equalTo(Main_Screen_Width / 2);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
    }
//    [self.runningView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self.homeCenterView.mas_bottom).offset(10);
//        make.centerX.equalTo(self);
//        make.width.mas_equalTo(Main_Screen_Width);
//        make.height.mas_equalTo(160);
//        make.bottom.equalTo(self.mas_bottom).offset(-10);
//
//    }];
    
    
}

- (void)setIsHideRunningView:(BOOL)isHideRunningView{
    _isHideRunningView = isHideRunningView;
    if (isHideRunningView == YES) {
        [self.homeCenterView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.homeLoopImageView.mas_bottom).offset(10);
            make.centerX.equalTo(self);
            make.width.mas_equalTo(Main_Screen_Width);
            make.height.mas_equalTo(Main_Screen_Width / 2);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
        if (self.runningView) {
            [self.runningView removeFromSuperview];
        }
        
    }else{
        [self addSubview:self.runningView];
        
        [self.homeCenterView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.homeLoopImageView.mas_bottom).offset(10);
            make.centerX.equalTo(self);
            make.width.mas_equalTo(Main_Screen_Width);
            make.height.mas_equalTo(Main_Screen_Width / 2);
//            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
        if (!_isExit) {
            _isExit = YES;
            
            self.store = [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
            
            NSString *tableName = DBMapTable;
            
            [self.store createTableWithName:tableName];
            
            NSString *runningString = [self.store getStringById:DBRunningModel fromTable:DBMapTable];
            
            if (runningString.length > 0) {
                ZLHomeRiverRunningModel *runningModel = [[ZLHomeRiverRunningModel alloc]initWithString:runningString error:nil];
                
                
                NSString *timeString = [ZLUtility getDateByTimestamp:[runningModel.time longLongValue] / 1000 type:4];
                
                self.runningView.timeLabel.text = timeString;
                
                self.runningView.titleLabel.text = runningModel.riverTitle;
                self.runningView.peopleLabel.text = runningModel.userName;
                
                ZLNewUserRiversDataModel *riverModel = [[ZLNewUserRiversDataModel alloc]initWithString:runningModel.riverData error:nil];
                
                self.runningView.riverDataModel =  riverModel;
                
            }
        }
        [self.runningView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.homeCenterView.mas_bottom).offset(10);
            make.centerX.equalTo(self);
            make.width.mas_equalTo(Main_Screen_Width);
            make.height.mas_equalTo(110);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
    }
    
   
    
    
}


- (void)updateConstraints{
    [super updateConstraints];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}


- (ZLHomeLoopTopView *)homeLoopImageView{
    
    if (!_homeLoopImageView) {
        
        _homeLoopImageView = [[ZLHomeLoopTopView alloc]init];
        
        
    }
    return _homeLoopImageView;
    
}
- (ZLHomeCenterView *)homeCenterView{
    if (!_homeCenterView) {
        _homeCenterView = [[ZLHomeCenterView alloc]init];
        _homeCenterView.backgroundColor = [UIColor whiteColor];
    }
    return _homeCenterView;
}

- (ZLHomeRiverRunningView *)runningView{
    if (!_runningView) {
        _runningView = [[ZLHomeRiverRunningView alloc]init];
        
//        _runningView.hidden = YES;
        
    }
    return _runningView;
}


@end
