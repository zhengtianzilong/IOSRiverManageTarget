//
//  ZLNewGaodeReportView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/14.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLNewGaodeReportView : UIView<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UITableView *mainTableView;
-(instancetype)initWithFrame:(CGRect)frame andHeight:(float)height;
-(void)hideView;
-(void)showView;


@end
