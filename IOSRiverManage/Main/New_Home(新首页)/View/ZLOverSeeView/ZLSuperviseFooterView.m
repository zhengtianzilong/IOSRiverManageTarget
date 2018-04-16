//
//  ZLSuperviseFooterView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/22.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLSuperviseFooterView.h"

@implementation ZLSuperviseFooterView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}



- (void)setupUI{
    
    [self.contentView addSubview:self.describe];
    [self.contentView addSubview:self.describeLabel];
    [self.contentView addSubview:self.noteLabel];
    [self.contentView addSubview:self.note];
    
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
        
    }];
    
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.describeLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.describeLabel).offset(0);
        //        make.height.mas_equalTo(80);
        //        make.width.mas_equalTo(65);
        
    }];
    
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.describeLabel);
        make.top.equalTo(self.describe.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(75);
        
    }];
    
    [self.note mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.noteLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.noteLabel).offset(0);
        //        make.height.mas_equalTo(80);
        //        make.width.mas_equalTo(65);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    
    //    [self.stateLable changeAlignmentRightandLeft];
    //    [self.originatorLabel changeAlignmentRightandLeft];
    //    [self.receiveLabel changeAlignmentRightandLeft];
    //    [self.timeLabel changeAlignmentRightandLeft];
    //    [self.describeLabel changeAlignmentRightandLeft];
}

- (void)setDetailModel:(ZLSuperviseDetailDataModel *)detailModel{
    
    _detailModel = detailModel;
  
    self.describe.text = detailModel.superviseContent;
    
    if (detailModel.remark == nil) {
        detailModel.remark = @" ";
    }
    
    self.note.text = detailModel.remark;
}


- (UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc]init];
        _describeLabel.text = @"交办工作内容：";
        _describeLabel.font = Font(14);
    }
    return _describeLabel;
}

- (UILabel *)describe{
    if (!_describe) {
        _describe = [[UILabel alloc]init];
        _describe.text = @"系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记";
        _describe.font = CHINESE_SYSTEM(14);
        _describe.numberOfLines = 0;
    }
    return _describe;
}


- (UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.text = @"备注：";
        _noteLabel.font = Font(14);
        
    }
    return _noteLabel;
}

- (UILabel *)note{
    if (!_note) {
        _note = [[UILabel alloc]init];
        _note.text = @"系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记";
        _note.font = CHINESE_SYSTEM(14);
        _note.numberOfLines = 0;
    }
    return _note;
}

@end
