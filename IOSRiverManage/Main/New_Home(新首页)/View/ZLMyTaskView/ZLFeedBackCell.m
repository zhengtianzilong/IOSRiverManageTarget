//
//  ZLFeedBackCell.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/4/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLFeedBackCell.h"
#import "NSArray+ZLJiuGongGe.h"
@interface ZLFeedBackCell ()<MWPhotoBrowserDelegate>
@property (nonatomic,retain) NSMutableArray *photosArray;
@end

@implementation ZLFeedBackCell

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
        make.bottom.equalTo(self.contentView.mas_bottom);
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
    [self.contentView addSubview:self.originatorLabel];
    [self.contentView addSubview:self.originator];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.describeLabel];
    [self.contentView addSubview:self.describe];
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
    
    [self.originatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.lineView.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(75);
        
    }];
    
    [self.originator mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.originatorLabel.mas_right);
        make.top.equalTo(self.originatorLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(50);
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.originatorLabel);
        make.top.equalTo(self.originatorLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(75);
        
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.timeLabel.mas_right);
        make.top.equalTo(self.timeLabel);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(50);
        
    }];
    
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.originatorLabel);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(75);
        
    }];
    
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.describeLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.describeLabel).offset(0);
        //        make.height.mas_equalTo(80);
        //        make.width.mas_equalTo(50);
        make.bottom.equalTo(self.contentView);
    }];
    
    
    
    
}

- (void)setDataModel:(ZLTaskFeedBackDataModel *)dataModel{

    _dataModel = dataModel;
    self.originator.text = dataModel.userName;
    if (dataModel.feedbackContent) {
        self.describe.text = dataModel.feedbackContent;
    }else{
        self.describe.text = @" ";
        
    }
    NSString *time = dataModel.createTime;

    NSString *timeString = [ZLUtility getDateByTimestamp:[time longLongValue] / 1000 type:4];

    self.time.text = timeString;

    if (dataModel.imgList.count > 0) {
        // 固定containerView的宽
        // 宫格的宽随containerView的宽改变
        // 固定宫格的高
        // containerView的高随宫格的高改变
        [self distributeDynamic2CellWithCount:dataModel.imgList.count warp:3 withImageUrl:dataModel.imgList];

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



- (UILabel *)originatorLabel{
    if (!_originatorLabel) {
        _originatorLabel = [[UILabel alloc]init];
        _originatorLabel.text = @"执行人：";
        _originatorLabel.font = Font(14);
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



- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"创建时间：";
        _timeLabel.font = Font(14);
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
        _describeLabel.text = @"反馈描述：";
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


@end
