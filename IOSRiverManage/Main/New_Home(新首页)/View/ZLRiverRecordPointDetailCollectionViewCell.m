//
//  ZLRiverRecordPointDetailCollectionViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/20.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverRecordPointDetailCollectionViewCell.h"
@interface ZLRiverRecordPointDetailCollectionViewCell ()

@end

@implementation ZLRiverRecordPointDetailCollectionViewCell


- (void)setFrame:(CGRect)frame{
    
    frame.size.width = Main_Screen_Width - 20;
    frame.origin.x = 10;
    [super setFrame:frame];
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUpUI];
        
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        
    }
    return self;
}


- (void)setUpUI{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"标题：";
    _titleLabel.font = CHINESE_SYSTEM(13);
    [self.contentView addSubview:_titleLabel];
    

    
    
    _title = [[UILabel alloc]init];
    _title.font = CHINESE_SYSTEM(12);
    _title.text = @"哈哈哈";
    [self.contentView addSubview:_title];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.text = @"内容：";
    _contentLabel.font = Font(12);
    [self.contentView addSubview:_contentLabel];
    
    
    _content = [[UILabel alloc]init];
    _content.text = @"河道有许多垃圾袋,饮料瓶等等,相关部门注意看看啊啊啊啊啊啊啊啊啊啊多多发付军爱所付军奥所付所撒多付囧撒多军付";
    _content.font = CHINESE_SYSTEM(12);
    //    _content.numberOfLines = 0;
    [self.contentView addSubview:_content];
    
    _riverPeopleLabel = [[UILabel alloc]init];
    _riverPeopleLabel.text = @"巡河人：";
    _riverPeopleLabel.font = Font(12);
    [self.contentView addSubview:_riverPeopleLabel];
    
    
    
    _riverPeople = [[UILabel alloc]init];
    _riverPeople.text = @"接收人";
    _riverPeople.font = Font(12);
    [self.contentView addSubview:_riverPeople];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.text = @"创建时间：";
    _timeLabel.font = Font(12);
    [self.contentView addSubview:_timeLabel];
    
    
    _time = [[UILabel alloc]init];
    _time.text = @"2017-10-11 11:28";
    _time.font = CHINESE_SYSTEM(12);
    [self.contentView addSubview:_time];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right).offset(5);
        make.top.equalTo(_titleLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(_titleLabel);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.height.equalTo(_titleLabel);
        make.width.mas_equalTo(60);
    }];
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentLabel.mas_right).offset(0);
        make.top.equalTo(_contentLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(_titleLabel);
        
    }];
  
    
    [_riverPeopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_contentLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
    }];
    
    [_riverPeople mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_riverPeopleLabel.mas_right).offset(0);
        make.top.equalTo(_riverPeopleLabel);
        make.height.equalTo(_riverPeopleLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_riverPeopleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
    }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_timeLabel.mas_right).offset(0);
        make.top.equalTo(_timeLabel);
        make.height.equalTo(_timeLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
}

- (void)setDataModel:(ZLGaodeEventAndTaskModel *)dataModel{
    _dataModel = dataModel;
    
    self.title.text = dataModel.title;
    self.content.text = dataModel.content;
    self.riverPeople.text = dataModel.riverPeople;
    
    NSString *time = [ZLUtility getDateByTimestamp:[dataModel.time longLongValue] / 1000 type:4];
    
    self.time.text = time;
    
    if ([dataModel.type isEqualToString:@"上报"]) {
        
        self.timeLabel.text = @"上报时间";
        
    }else if ([dataModel.type isEqualToString:@"下发"]){
        
        self.timeLabel.text = @"下发时间";
        
    }
    
    
}


@end
