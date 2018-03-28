//
//  ZLGaodeReportBiew.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/5.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLEventReportSubView.h"
@interface ZLGaodeReportView : UIView
@property (nonatomic, strong) ZLEventReportSubView *titleView;

@property (nonatomic, strong) ZLEventReportSubView *riverPeopleView;

@property (nonatomic, strong) ZLEventReportSubView *reportObjectView;

@property (nonatomic, strong) ZLEventReportSubView *addressView;

@property (nonatomic, strong) UITextView *noteTextView;

@property (nonatomic, strong) NSString *liable_id;

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *idArray;
- (instancetype)initWithFrame:(CGRect)frame riverId:(NSString *)riverId;
@end
