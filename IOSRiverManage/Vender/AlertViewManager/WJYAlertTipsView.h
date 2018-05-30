//
//  WJYAlertTipsView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZLGetScoreDetailModel.h"

typedef void (^alertBottomBlock)(void);
@interface WJYAlertTipsView : UIView

//开放出来
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)UIButton *bottomButton;

@property (nonatomic, copy) alertBottomBlock bottomBlock;

@property (nonatomic, strong) ZLGetScoreDetailModel *detailModel;


-(instancetype)initPagesViewWithTitle:(NSString *)title bottomButtonTitle:(NSString *)bottomButtonTitle cellModel:(ZLGetScoreDetailModel *)cellModel;
@end
