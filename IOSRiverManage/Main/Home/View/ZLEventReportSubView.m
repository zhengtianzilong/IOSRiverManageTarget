//
//  ZLEventReportSubView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/20.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLEventReportSubView.h"

@implementation ZLEventReportSubView

- (instancetype)initWithName:(NSString *)name placeHolder:(NSString *)placeHolder haveButton:(BOOL)haveButton{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = name;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(AdaptedWidth(30));
            make.height.mas_equalTo(AdaptedHeight(80));
            //            make.width.mas_equalTo(AdaptedWidth(200));
        }];
        
        [_nameLabel setNeedsDisplay];
        
        
        
        if (![placeHolder isEqualToString:@""]) {
            self.eventTextfiled = [[UITextField alloc]init];
            self.eventTextfiled.placeholder = placeHolder;
            self.eventTextfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
            [self addSubview:self.eventTextfiled];
            [self.eventTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(self);
                make.left.equalTo(_nameLabel.mas_right).offset(AdaptedWidth(10));
                make.height.mas_equalTo(AdaptedHeight(80));
                make.right.lessThanOrEqualTo(self.mas_right).offset(0);
                //                make.width.mas_equalTo(App_Frame_Width -  - AdaptedWidth(50));
            }];
        }
        if (haveButton) {
            _imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"event_object"]];
            UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _imageV.frame.size.width + 10, _imageV.frame.size.height)];
            [rightView addSubview:_imageV];
            
            //            imageV.image = [UIImage imageNamed:@"event_object"];
            self.eventTextfiled.rightViewMode = UITextFieldViewModeAlways;
            self.eventTextfiled.rightView = rightView;
            
        }
        
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self).offset(0);
            make.height.mas_equalTo(1);
            make.right.equalTo(self.mas_right);
            
            
        }];
        
        
    }
    
    
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.eventTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(App_Frame_Width - _nameLabel.frame.size.width - AdaptedWidth(30) - AdaptedWidth(10));
        
    }];
    
    ZLLog(@"%@",_nameLabel);
    
    
}


@end

