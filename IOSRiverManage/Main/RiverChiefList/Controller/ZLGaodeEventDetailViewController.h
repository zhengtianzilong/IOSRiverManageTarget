//
//  ZLGaodeEventDetailViewController.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/26.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "MYPresentedController.h"

typedef void(^ZLScrollBlcok)(NSInteger index);

@interface ZLGaodeEventDetailViewController : MYPresentedController

@property (nonatomic, strong) ZLScrollBlcok scrollBlock;

@property (nonatomic, assign) NSInteger index;

@end
