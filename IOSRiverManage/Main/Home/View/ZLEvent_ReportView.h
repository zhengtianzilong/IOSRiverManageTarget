//
//  ZLEvent_ReportView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/19.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText/YYText.h>
#import "ZLEventReportSubView.h"
@interface ZLEvent_ReportView : UIView

@property (nonatomic, strong) ZLEventReportSubView *firstView;

@property (nonatomic, strong) ZLEventReportSubView *secondView;
@property (nonatomic, strong) ZLEventReportSubView *thirdView;
@property (nonatomic, strong) YYTextView *noteTextView;

@property (nonatomic, strong) NSString *liable_id;

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *idArray;

- (instancetype)initWithFrame:(CGRect)frame andHasEventNameObject:(BOOL)hasName hasLeader:(BOOL)hasLeader;

@end
