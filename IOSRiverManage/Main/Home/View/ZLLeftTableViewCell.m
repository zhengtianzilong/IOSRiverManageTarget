//
//  ZLLeftTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/19.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLLeftTableViewCell.h"

@implementation ZLLeftTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.icon=[[UIImageView alloc]initWithFrame:CGRectZero];
        //   self.icon.backgroundColor=[UIColor greenColor];
        [self.contentView addSubview:self.icon];
        
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView).offset(AdaptedWidth(30));
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(AdaptedWidth(50));
        }];
        
        
        self.contentLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        //   self.contentLabel.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:self.contentLabel];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.icon.mas_right).offset(AdaptedWidth(25));
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(self.icon);
            
        }];
        
        
    }
    return self;
}
@end
