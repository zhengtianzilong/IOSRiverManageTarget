//
//  ZLTaskInfoTableViewCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLTaskInfoTableViewCell.h"
#import "NSArray+ZLJiuGongGe.h"
@interface ZLTaskInfoTableViewCell ()<MWPhotoBrowserDelegate>
@property (nonatomic,retain) NSMutableArray *photosArray;
@end

@implementation ZLTaskInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.photosArray = [NSMutableArray array];
        [self setupUI];
    }
    return self;
    
}

// 固定containerView的宽
// 宫格的宽随containerView的宽改变
// 固定宫格的高
// containerView的高随宫格的高改变
- (void)distributeDynamic2CellWithCount:(NSUInteger)count warp:(NSUInteger)warp withImageUrl:(NSArray *)urls{
    
    [self.containerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.describe);
        make.top.equalTo(self.describe.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        //        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_greaterThanOrEqualTo(80);
        
    }];
    
    for (int i = 0; i < count; i++) {
        UIImageView *imageV = [[UIImageView alloc] init];
        
        ZLTaskInfoImageListModel *imageModel = urls[i];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImage_URL, imageModel.fileAddr]];
        
        MWPhoto *photo = [MWPhoto photoWithURL:url];
        [self.photosArray addObject:photo];
        
        
        [imageV sd_setImageWithURL:url];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        
        imageV.tag = (i + 1000);
        imageV.userInteractionEnabled = YES;
        [imageV addGestureRecognizer:tap];
        
//        imageV.backgroundColor = [UIColor redColor];
        [self.containerView addSubview:imageV];
    }
    
    [self.containerView.subviews mas_distributeSudokuViewsWithFixedItemWidth:0 fixedItemHeight:60
                                                            fixedLineSpacing:10 fixedInteritemSpacing:10
                                                                   warpCount:3
                                                                  topSpacing:10
                                                               bottomSpacing:10 leadSpacing:10 tailSpacing:10];
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    
    UIImageView *imageV = (UIImageView *)tap.view;
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.alwaysShowControls = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.displayNavArrows = NO;
    browser.startOnGrid = NO;
    browser.enableGrid = YES;
    [browser setCurrentPhotoIndex:imageV.tag - 1000];
    //这样处理的目的是让整个页面跳转更加自然
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:browser];
    navC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.viewController presentViewController:navC animated:YES completion:nil];
    
    
    
    
}


//必须实现的方法
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return  self.photosArray.count;
}
- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    
    if (index < self.photosArray.count) {
        return [self.photosArray objectAtIndex:index];
    }
    return nil;
}

- (void)setupUI{
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.eventLabel];
    [self.contentView addSubview:self.event];
    [self.contentView addSubview:self.stateLable];
    [self.contentView addSubview:self.state];
    [self.contentView addSubview:self.originatorLabel];
    [self.contentView addSubview:self.originator];
    [self.contentView addSubview:self.receiveLabel];
    [self.contentView addSubview:self.receive];
    [self.contentView addSubview:self.departLabel];
    [self.contentView addSubview:self.depart];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.describeLabel];
    [self.contentView addSubview:self.describe];
    [self.contentView addSubview:self.attachmentLabel];
    [self.contentView addSubview:self.attachment];
    UIView *containerView = [[UIView alloc] init];
    [self.contentView addSubview:containerView];
    self.containerView = containerView;
    
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
        make.width.equalTo(self.contentView);
        //        make.width.mas_equalTo(100);
        
    }];
    
    [self.eventLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.lineView.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
        
    }];
    
    [self.event mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.eventLabel.mas_right);
        make.top.equalTo(self.eventLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(50);
        
    }];
    
    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.eventLabel);
        make.top.equalTo(self.eventLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
        
    }];
    
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.stateLable.mas_right);
        make.top.equalTo(self.stateLable);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(50);
        
    }];
    
    [self.originatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.eventLabel);
        make.top.equalTo(self.stateLable.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
        
    }];
    
    [self.originator mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.originatorLabel.mas_right);
        make.top.equalTo(self.originatorLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(50);
        
    }];
    
    
    [self.receiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.eventLabel);
        make.top.equalTo(self.originatorLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
    }];
    
    [self.receive mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.receiveLabel.mas_right);
        make.top.equalTo(self.receiveLabel);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.departLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.eventLabel);
        make.top.equalTo(self.receiveLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
        
    }];
    
    [self.depart mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.departLabel.mas_right);
        make.top.equalTo(self.departLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(50);
        
    }];
    
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.eventLabel);
        make.top.equalTo(self.departLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
        
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.timeLabel.mas_right);
        make.top.equalTo(self.timeLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(50);
        
    }];
    
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.eventLabel);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
        
    }];
    
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.describeLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.describeLabel).offset(0);
        //        make.height.mas_equalTo(80);
        //        make.width.mas_equalTo(50);
        
    }];
    
    
    
    
}

- (void)setDataModel:(ZLTaskInfoDetailDataModel *)dataModel{
    
    _dataModel = dataModel;
    _event.text = dataModel.taskName;
    
    NSString *status = @"";
    
    if ([_dataModel.taskStatus isEqualToString:@"0"]) {
        status = @"已创建";
    }
    if ([_dataModel.taskStatus isEqualToString:@"1"]) {
        status = @"已下发";
    }
    if ([_dataModel.taskStatus isEqualToString:@"2"]) {
        
        status = @"已接收";
     
    }
    if ([_dataModel.taskStatus isEqualToString:@"3"]) {
        
        status = @"已转发";
    }
    if ([_dataModel.taskStatus isEqualToString:@"6"]) {
        
        status = @"已反馈";
    }
    if ([_dataModel.taskStatus isEqualToString:@"7"]) {
        
        status = @"已驳回";
    }
    if ([_dataModel.taskStatus isEqualToString:@"8"]) {
        
        status = @"已完成";
    }
    
    if ([_dataModel.taskStatus isEqualToString:@"9"]) {
        
        status = @"完结";
    }
    
    self.state.text = status;
    self.originator.text = dataModel.createName;
    self.receive.text = dataModel.receiverPersonNames;
    self.depart.text = dataModel.receiverDepartmentNames;
    
    NSString *time = dataModel.createTime;
    
     NSString *timeString = [ZLUtility getDateByTimestamp:[time longLongValue] / 1000 type:4];
    
    self.time.text = timeString;
    self.describe.text = dataModel.taskContent;
    
    if (dataModel.imgList.count > 0) {
        // 固定containerView的宽
        // 宫格的宽随containerView的宽改变
        // 固定宫格的高
        // containerView的高随宫格的高改变
        [self distributeDynamic2CellWithCount:dataModel.imgList.count warp:3 withImageUrl:dataModel.imgList];
        [self.attachmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.eventLabel);
            make.top.equalTo(self.containerView.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(60);
            
        }];
    }else{
        [self.attachmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.eventLabel);
            make.top.equalTo(self.describe.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(60);
            
        }];
    }
    
    [self.attachment mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.attachmentLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.attachmentLabel).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom);
        //        make.height.mas_equalTo(80);
        //        make.width.mas_equalTo(50);
        
    }];
    
    NSMutableArray *fileNameArray = [NSMutableArray array];
    
    for (ZLTaskInfoFileListModel *fileModel in dataModel.fileList) {
        
        [fileNameArray addObject:fileModel.orgName];
        
    }

    if (fileNameArray.count>0) {
        self.attachment.text = [fileNameArray componentsJoinedByString:@"\n"];
    }else{
        
        self.attachment.text = @" ";
        
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    //    [self.stateLable changeAlignmentRightandLeft];
    //    [self.originatorLabel changeAlignmentRightandLeft];
    //    [self.receiveLabel changeAlignmentRightandLeft];
    //    [self.timeLabel changeAlignmentRightandLeft];
    //    [self.describeLabel changeAlignmentRightandLeft];
}


- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
    }
    return _lineView;
}

- (UILabel *)eventLabel{
    if (!_eventLabel) {
        _eventLabel = [[UILabel alloc]init];
        _eventLabel.text = @"任务名称:";
        _eventLabel.font = CHINESE_SYSTEM(14);
    }
    return _eventLabel;
}
- (UILabel *)event{
    if (!_event) {
        _event = [[UILabel alloc]init];
        _event.text = @"XXXXX";
        _event.font = CHINESE_SYSTEM(14);
    }
    return _event;
}

- (UILabel *)stateLable{
    if (!_stateLable) {
        _stateLable = [[UILabel alloc]init];
        _stateLable.text = @"状态:";
        _stateLable.font = CHINESE_SYSTEM(14);
    }
    return _stateLable;
}
- (UILabel *)state{
    if (!_state) {
        _state = [[UILabel alloc]init];
        _state.text = @"XXXXX";
        _state.font = CHINESE_SYSTEM(14);
    }
    return _state;
}

- (UILabel *)originatorLabel{
    if (!_originatorLabel) {
        _originatorLabel = [[UILabel alloc]init];
        _originatorLabel.text = @"创建人:";
        _originatorLabel.font = CHINESE_SYSTEM(14);
    }
    return _originatorLabel;
}

- (UILabel *)originator{
    if (!_originator) {
        _originator = [[UILabel alloc]init];
        _originator.text = @"80";
        _originator.font = CHINESE_SYSTEM(14);
    }
    return _originator;
}

- (UILabel *)receiveLabel{
    if (!_receiveLabel) {
        _receiveLabel = [[UILabel alloc]init];
        _receiveLabel.text = @"接收人:";
        _receiveLabel.font = CHINESE_SYSTEM(14);
    }
    return _receiveLabel;
}

- (UILabel *)receive{
    if (!_receive) {
        _receive = [[UILabel alloc]init];
        _receive.text = @"123";
        _receive.font = CHINESE_SYSTEM(14);
    }
    return _receive;
}

- (UILabel *)departLabel{
    if (!_departLabel) {
        _departLabel = [[UILabel alloc]init];
        _departLabel.text = @"接收部门:";
        _departLabel.font = CHINESE_SYSTEM(14);
    }
    return _departLabel;
}

- (UILabel *)depart{
    if (!_depart) {
        _depart = [[UILabel alloc]init];
        _depart.text = @"123";
        _depart.font = CHINESE_SYSTEM(14);
    }
    return _depart;
}


- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"创建时间:";
        _timeLabel.font = CHINESE_SYSTEM(14);
    }
    return _timeLabel;
}

- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.text = @"系统管理员标记";
        _time.font = CHINESE_SYSTEM(14);
    }
    return _time;
}



- (UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc]init];
        _describeLabel.text = @"内容:";
        _describeLabel.font = CHINESE_SYSTEM(14);
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

- (UILabel *)attachmentLabel{
    if (!_attachmentLabel) {
        _attachmentLabel = [[UILabel alloc]init];
        _attachmentLabel.text = @"附件";
        _attachmentLabel.font = CHINESE_SYSTEM(14);
        
    }
    return _attachmentLabel;
}

- (UILabel *)attachment{
    if (!_attachment) {
        _attachment = [[UILabel alloc]init];
        _attachment.text = @"系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记系统管理员标记";
        _attachment.font = CHINESE_SYSTEM(14);
        _attachment.numberOfLines = 0;
    }
    return _attachment;
}


@end
