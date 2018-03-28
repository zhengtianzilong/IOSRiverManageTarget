//
//  ZLRiverPeopleNameAndEditBtnView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLRiverPeopleNameAndEditBtnView : UIView
@property (nonatomic, strong) UILabel *nameLable;

//@property (nonatomic, strong) UIButton *editBtn;


-(instancetype)initWithFrame:(CGRect)frame WithName:(NSString *)name;

@end
