//
//  ZLMyHeadView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyHeadView.h"

@implementation ZLMyHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.iconView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.identityLabel];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.width.mas_equalTo(AdaptedWidth(130));
        make.left.equalTo(self).offset(15);
//        make.bottom.equalTo(self).offset(-AdaptedHeight(30));
        make.centerY.equalTo(self);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconView.mas_right).offset(10);
        make.bottom.equalTo(self.iconView.mas_centerY).offset(-2);
        //            make.height.mas_equalTo(AdaptedHeight(30));
        
    }];
    [self.identityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconView.mas_right).offset(10);
        make.top.equalTo(self.iconView.mas_centerY).offset(2);
        //            make.height.mas_equalTo(AdaptedHeight(30));
        
    }];
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _iconView.layer.masksToBounds=YES;
        _iconView.layer.cornerRadius=self.iconView.frame.size.width/2;
        
#if WanApp
        _iconView.image = [UIImage imageNamed:@"wan_my_header"];
#else
        _iconView.image = [UIImage imageNamed:@"my_header"];
#endif
        
        
    }
    return _iconView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:UUserName];
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.textColor=[UIColor whiteColor];
    }
    return _nameLabel;
}

- (UILabel *)identityLabel{
    if (!_identityLabel) {
        _identityLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _identityLabel.numberOfLines=0;
        NSString *locationStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"identity"];
        _identityLabel.text = locationStr;
        _identityLabel.font = [UIFont systemFontOfSize:14];
        _identityLabel.textColor=[UIColor whiteColor];
    }
    return _identityLabel;
}

@end
