//
//  ZLLeftHeadView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/19.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLLeftHeadView.h"

@implementation ZLLeftHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.iconView=[[UIImageView alloc]initWithFrame:CGRectZero];
        self.iconView.layer.masksToBounds=YES;
        self.iconView.layer.cornerRadius=self.iconView.frame.size.width/2;
        self.iconView.image=[UIImage imageNamed:@"left_touxiang"];
        [self addSubview:self.iconView];
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.height.width.mas_equalTo(AdaptedWidth(130));
            make.left.equalTo(self).offset(AdaptedWidth(30));
            make.bottom.equalTo(self).offset(-AdaptedHeight(30));
        }];
        
        
        //头像加入手势
        self.iconView.userInteractionEnabled=YES;
        //        UITapGestureRecognizer *tapIcon=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeIcon)];
        //        [self.iconView addGestureRecognizer:tapIcon];
        self.nameLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        self.nameLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:UUserName];
        self.nameLabel.font=[UIFont systemFontOfSize:18];
        [self addSubview:self.nameLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.iconView.mas_right).offset(10);
            make.bottom.equalTo(self.iconView.mas_centerY).offset(-2);
//            make.height.mas_equalTo(AdaptedHeight(30));
            
        }];
        
        
        self.identityLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        self.identityLabel.numberOfLines=0;
        NSString *locationStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"identity"];
        self.identityLabel.text=locationStr;
        self.identityLabel.font=[UIFont systemFontOfSize:14];
        [self addSubview:self.identityLabel];
        
        [self.identityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.iconView.mas_right).offset(10);
            make.top.equalTo(self.iconView.mas_centerY).offset(2);
//            make.height.mas_equalTo(AdaptedHeight(30));
            
        }];
        
        self.nameLabel.textColor=[UIColor whiteColor];
        self.identityLabel.textColor=[UIColor whiteColor];
    }
    return self;
}

@end
