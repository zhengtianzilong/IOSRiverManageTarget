//
//  ZLMyTaskChangAndDeleteCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyTaskChangAndDeleteCell.h"
#import "UIView+RoundedCorner.h"
@implementation ZLMyTaskChangAndDeleteCell

- (void)setUpUI{
    [super setUpUI];
    
    [self.contentView addSubview:self.changeBtn];
    [self.contentView addSubview:self.deleteBtn];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.lineViewBottom.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(55);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.deleteBtn.mas_left).offset(-5);
        make.top.equalTo(self.deleteBtn);
        make.height.equalTo(self.deleteBtn);
        make.width.equalTo(self.deleteBtn);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    self.colorIndicator.image = [UIImage imageNamed:@"task_point"];
    
    self.initiatorLabel.text = @"创建人:";
    self.receivedLabel.text = @"执行人:";
    self.state.textColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.deleteBtn jm_setCornerRadius:0.8 withBackgroundColor:[UIColor whiteColor]];
    //    [self.changeBtn jm_setCornerRadius:0.7 withBackgroundColor:[UIColor whiteColor]];
    
}

- (void)setDataModel:(ZLTaskManageDataModel *)dataModel{
    
    _dataModel = dataModel;
    self.initiatorName.text = _dataModel.createName;
    self.receivedName.text = _dataModel.userName;
    self.content.text = _dataModel.taskContent;
    self.timeLabel.text = _dataModel.createTime;
    self.title.text = _dataModel.taskName;
    
    NSString *status = @"";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImage_URL,_dataModel.fileAddr]];
    
    [self.imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"event_placeImage"]];
    
    if ([_dataModel.taskStatus isEqualToString:@"0"]) {
        status = @"已创建";
        self.deleteBtn.hidden = NO;
        self.changeBtn.hidden = NO;
    }
    
    if ([_dataModel.taskStatus isEqualToString:@"1"]) {
        
        status = @"已下发";
        
        self.deleteBtn.hidden = YES;
        self.changeBtn.hidden = YES;
        
    }
    if ([_dataModel.taskStatus isEqualToString:@"2"]) {
        
        status = @"已接收";
        self.deleteBtn.hidden = YES;
        self.changeBtn.hidden = YES;
    }
    if ([_dataModel.taskStatus isEqualToString:@"3"]) {
        
        status = @"已转发";
        self.deleteBtn.hidden = YES;
        self.changeBtn.hidden = YES;
    }
    if ([_dataModel.taskStatus isEqualToString:@"6"]) {
        
        status = @"已反馈";
        self.deleteBtn.hidden = YES;
        self.changeBtn.hidden = YES;
    }
    if ([_dataModel.taskStatus isEqualToString:@"7"]) {
        
        status = @"已驳回";
        self.deleteBtn.hidden = YES;
        self.changeBtn.hidden = YES;
    }
    if ([_dataModel.taskStatus isEqualToString:@"8"]) {
        
        status = @"已完成";
        self.deleteBtn.hidden = YES;
        self.changeBtn.hidden = YES;
    }
    
    if ([_dataModel.taskStatus isEqualToString:@"9"]) {
        status = @"完结";
        self.deleteBtn.hidden = YES;
        self.changeBtn.hidden = YES;
    }
    
    self.state.text = status;
    
    
}



- (void)deleteBtnClick{
    
    if (_deleteClick) {
        self.deleteClick(_dataModel);
    }
    
}

- (void)changeBtnClick{
    if (_changeClick) {
        self.changeClick(_dataModel);
    }
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc]init];
        [_deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
        [_deleteBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        _deleteBtn.layer.borderWidth = 1;
        _deleteBtn.layer.cornerRadius = 5;
        _deleteBtn.layer.borderColor = HEXCOLOR(CVIEW_GRAY_COLOR).CGColor;
        _deleteBtn.titleLabel.font = CHINESE_SYSTEM(16);
        _deleteBtn.layer.masksToBounds = YES;
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _deleteBtn;
}

- (UIButton *)changeBtn{
    if (!_changeBtn) {
        _changeBtn = [[UIButton alloc]init];
        [_changeBtn setTitle:@"修改" forState:(UIControlStateNormal)];
        [_changeBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        _changeBtn.titleLabel.font = CHINESE_SYSTEM(16);
        _changeBtn.layer.borderWidth = 1;
        _changeBtn.layer.masksToBounds = NO;
        _changeBtn.layer.cornerRadius = 5;
        _changeBtn.layer.borderColor = HEXCOLOR(CVIEW_GRAY_COLOR).CGColor;
        _changeBtn.clipsToBounds = YES;
        
    }
    return _changeBtn;
}



@end
