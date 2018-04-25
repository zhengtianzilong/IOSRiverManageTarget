//
//  ZLTimeLineTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLTimeLineTableViewCell.h"

@implementation ZLTimeLineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}
- (void)setupUI{
    
    [self.contentView addSubview:self.colorIndicator];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.descripe];
    [self.contentView addSubview:self.colorIndicator];
    [self.contentView addSubview:self.topLineView];
    [self.contentView addSubview:self.bottomLineView];
    [self.colorIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.width.mas_equalTo(7);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.colorIndicator.mas_right).offset(5);
        make.centerY.equalTo(self.colorIndicator);
        make.height.mas_equalTo(20);
        make.width.mas_greaterThanOrEqualTo(145);
    }];
    
    [self.descripe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.time.mas_right).offset(0);
        make.top.equalTo(self.time);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom);
        //        make.width.mas_equalTo(50);
        
    }];
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.colorIndicator);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.colorIndicator.mas_top);
        make.width.mas_equalTo(1);
        
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.colorIndicator);
        make.top.equalTo(self.colorIndicator.mas_bottom);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo(1);
        
    }];

}

- (void)setDataModel:(ZLTaskIncidentListModel *)dataModel{
    
    _dataModel = dataModel;
    
    NSString *time = _dataModel.oprateTime;
    
    NSString *timeString = [ZLUtility getDateByTimestamp:[time longLongValue] / 1000 type:4];
    self.time.text = timeString;
    
    self.descripe.text = dataModel.descri;
    
    
}


- (UIImageView *)colorIndicator{
    if (!_colorIndicator) {
        _colorIndicator = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"task_point"]];
    }
    return _colorIndicator;
}

- (UIView *)topLineView{
    if (!_topLineView) {
        _topLineView = [[UIView alloc]init];
        _topLineView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
    }
    return _topLineView;
}

- (UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    }
    return _bottomLineView;
}

- (UILabel *)descripe{
    if (!_descripe) {
        _descripe = [[UILabel alloc]init];
        _descripe.text = @"123hfjsdhuisdhfsdahfhdsahfsadhfidsahfdsaihfdsfsdafgdsafsdhfdsjhfdkjshfdjkshfjsjkdshjkdsfh";
        _descripe.font = CHINESE_SYSTEM(12);
        _descripe.numberOfLines = 0;
    }
    return _descripe;
}

- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.text = @"2018-03-25 19:05:12";
        _time.font = CHINESE_SYSTEM(12);
    }
    return _time;
}
@end
