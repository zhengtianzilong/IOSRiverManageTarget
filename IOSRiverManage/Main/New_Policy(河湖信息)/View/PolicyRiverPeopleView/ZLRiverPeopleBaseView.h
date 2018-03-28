//
//  ZLRiverPeopleBaseView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLRiverPeoplePhoneView.h"
#import "ZLRiverPeopleNameAndEditBtnView.h"
@interface ZLRiverPeopleBaseView : UIView

@property (nonatomic, strong) ZLRiverPeoplePhoneView *peopleView;



@property (nonatomic, strong) ZLRiverPeopleNameAndEditBtnView *nameAndEdit;

-(instancetype)initWithFrame:(CGRect)frame WithHeadName:(NSString *)headName;
@end
