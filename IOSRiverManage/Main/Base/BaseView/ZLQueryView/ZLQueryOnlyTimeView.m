//
//  ZLQueryOnlyTimeView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLQueryOnlyTimeView.h"

@implementation ZLQueryOnlyTimeView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        [self addSubview:self.selectInfoView];
        [self addSubview:self.threeButton];
        [self addSubview:self.queryButton];
        
        [self.selectInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right).offset(0);
            make.top.equalTo(self).offset(10);
//            make.height.mas_equalTo(82);
        }];
        
        [self.threeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self);
            make.top.equalTo(self.selectInfoView.mas_bottom).offset(10);
            make.height.mas_equalTo(35);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
        
        [self.queryButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self);
            make.top.equalTo(self.threeButton.mas_bottom).offset(10);
            make.height.mas_equalTo(40);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
   
    
    
    [self.threeButton jm_setCornerRadius:6 withBorderColor:[UIColor blackColor] borderWidth:1];
    
    [self.queryButton jm_setCornerRadius:6 withBackgroundColor:HEXCOLOR(CNAVGATIONBAR_COLOR)];
    
    
}


- (ZLSelectOnlyTimeView *)selectInfoView{
    if (!_selectInfoView) {
        _selectInfoView = [[ZLSelectOnlyTimeView alloc]init];
        
    }
    return _selectInfoView;
}


- (ZLThreeButtonView *)threeButton{
    
    if (!_threeButton) {
        _threeButton = [[ZLThreeButtonView alloc]init];
        [_threeButton.oneMonthBtn addTarget:self action:@selector(oneMonthBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_threeButton.oneQuarterBtn addTarget:self action:@selector(oneQuarterBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_threeButton.halfYearBtn addTarget:self action:@selector(halfYearBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _threeButton;
    
}


/**
 本月
 */
- (void)oneMonthBtnClick{
    [self solveTimeWith:1];
}

/**
 本季度
 */
- (void)oneQuarterBtnClick{
    [self solveTimeWith:3];
}

/**
 半年
 */
- (void)halfYearBtnClick{
    [self solveTimeWith:6];
}


/**
 计算当前时间之前的时间
 
 @param beforeTime 往前推多久
 */
- (void)solveTimeWith:(NSInteger)beforeTime{
    //得到当前的时间
    NSDate * mydate = [NSDate date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    self.selectInfoView.endTimeView.selectTimeLabel.text = currentDateStr;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:-beforeTime];
    
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    self.selectInfoView.startTimeView.selectTimeLabel.text = beforDate;
}


- (UIButton *)queryButton{
    if (!_queryButton) {
        _queryButton = [[UIButton alloc]init];
        //        _queryButton.backgroundColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
        
        [_queryButton setTitle:@"查询" forState:(UIControlStateNormal)];
        
    }
    return _queryButton;
    
}


@end
