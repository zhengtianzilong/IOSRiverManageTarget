//
//  ZLHomeLoopTopView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/26.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLHomeLoopTopView.h"

@interface ZLHomeLoopTopView ()
@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation ZLHomeLoopTopView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
    
        [self addSubview:self.imageView];
        
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self);
            make.width.mas_equalTo(Main_Screen_Width);
            make.top.equalTo(self);
            //        make.height.equalTo(self);
            
            make.bottom.equalTo(self.mas_bottom);
            
        }];
        
        
        
    }
    return self;
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    

    
}

- (UIImageView *)imageView{
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_banner"]];
        
    }
    return _imageView;
}




@end
