//
//  ZLGaodeDetailView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/26.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLGaodeDetailView.h"
#import "ZLGaodeDetailImageCollectionViewCell.h"
#import "NSArray+ZLJiuGongGe.h"
@interface ZLGaodeDetailView()

@end

@implementation ZLGaodeDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpView];
        
    }
    return self;
}

- (void)setUpView{
    [self addSubview:self.cancelBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.riverLabel];
    [self addSubview:self.riverPeople];
    [self addSubview:self.reportObjectLabel];
    [self addSubview:self.reportObject];
    [self addSubview:self.reportTimeLabel];
    [self addSubview:self.reportTime];
    [self addSubview:self.addressLabel];
    [self addSubview:self.address];
    [self addSubview:self.feedBackLabel];
    [self addSubview:self.feedBack];
//    [self addSubview:self.mainCollectionView];
    UIView *containerView = [[UIView alloc] init];
    [self addSubview:containerView];
    self.containerView = containerView;
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-5);
        make.top.equalTo(self.mas_top).offset(5);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.cancelBtn.mas_left);
        make.height.mas_equalTo(30);
    }];
    
    [self.riverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(90);
    }];
    
    [self.riverPeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.riverLabel.mas_right).offset(5);
        make.top.equalTo(self.riverLabel);
        make.right.equalTo(self.cancelBtn.mas_left);
        make.height.mas_equalTo(20);
    }];
    
    [self.reportObjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.riverLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(90);
    }];
    
    [self.reportObject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reportObjectLabel.mas_right).offset(5);
        make.top.equalTo(self.reportObjectLabel);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    [self.reportTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.reportObjectLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(90);
    }];
    
    [self.reportTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reportTimeLabel.mas_right).offset(5);
        make.top.equalTo(self.reportTimeLabel);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.reportTimeLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(90);
    }];
    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel.mas_right).offset(5);
        make.top.equalTo(self.addressLabel);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    [self.feedBackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.addressLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(90);
    }];
    
    [self.feedBack mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.feedBackLabel.mas_right);
        make.top.equalTo(self.feedBackLabel).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
        //        make.height.mas_equalTo(60);
        
    }];
    
    // 固定containerView的宽
    // 宫格的宽随containerView的宽改变
    // 固定宫格的高
    // containerView的高随宫格的高改变
    [self distributeDynamic2CellWithCount:8 warp:3];
    
    //    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(self.feedBackLabel.mas_right);
    //        make.top.equalTo(self.feedBack.mas_bottom).offset(5);
    //        make.right.equalTo(self.mas_right).offset(-10);
    //        make.height.mas_equalTo(200);
    //        make.bottom.equalTo(self.mas_bottom).offset(-20);
    //    }];
    //
    
    
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
   
    [_riverLabel changeAlignmentRightandLeft];
    [_reportObjectLabel changeAlignmentRightandLeft];
    [_reportTimeLabel changeAlignmentRightandLeft];
    [_addressLabel changeAlignmentRightandLeft];
    [_feedBackLabel changeAlignmentRightandLeft];
}

// 固定containerView的宽
// 宫格的宽随containerView的宽改变
// 固定宫格的高
// containerView的高随宫格的高改变
- (void)distributeDynamic2CellWithCount:(NSUInteger)count warp:(NSUInteger)warp {
    
    [self.containerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.feedBackLabel.mas_right);
        make.top.equalTo(self.feedBack.mas_bottom).offset(5);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
    
        
    }];
    
    for (int i = 0; i < count; i++) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor redColor];
        [self.containerView addSubview:view];
    }
    
    [self.containerView.subviews mas_distributeSudokuViewsWithFixedItemWidth:0 fixedItemHeight:60
                                                            fixedLineSpacing:10 fixedInteritemSpacing:10
                                                                   warpCount:3
                                                                  topSpacing:10
                                                               bottomSpacing:10 leadSpacing:10 tailSpacing:10];
}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 2;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 4;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    ZLGaodeDetailImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZLGaodeDetailImageCollectionViewCell" forIndexPath:indexPath];
////    cell.backgroundColor = [UIColor redColor];
//
//    return cell;
//
//}


- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = CHINESE_SYSTEM(18);

    }
    return _titleLabel;
    
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:(UIButtonTypeContactAdd)];
    }
    return _cancelBtn;
}

- (UILabel *)riverLabel{
    
    if (!_riverLabel) {
        _riverLabel = [[UILabel alloc]init];
        _riverLabel.text = @"巡河人:";
        _riverLabel.font = CHINESE_SYSTEM(15);
//        _riverLabel.attributedText = [self setTextString:@"巡河人:"];
        
    }
    return _riverLabel;
    
}
- (UILabel *)riverPeople{
    
    if (!_riverPeople) {
        _riverPeople = [[UILabel alloc]init];
        _riverPeople.font = CHINESE_SYSTEM(15);
    }
    return _riverPeople;
    
}
- (UILabel *)reportObjectLabel{
    
    if (!_reportObjectLabel) {
        _reportObjectLabel = [[UILabel alloc]init];
        _reportObjectLabel.text = @"上报对象:";
        _reportObjectLabel.font = CHINESE_SYSTEM(15);
    }
    return _reportObjectLabel;
    
}
- (UILabel *)reportObject{
    
    if (!_reportObject) {
        _reportObject = [[UILabel alloc]init];
        _reportObject.font = CHINESE_SYSTEM(15);
    }
    return _reportObject;
    
}
- (UILabel *)reportTimeLabel{
    
    if (!_reportTimeLabel) {
        _reportTimeLabel = [[UILabel alloc]init];
        _reportTimeLabel.text = @"上报时间:";
        _reportTimeLabel.font = CHINESE_SYSTEM(15);
    }
    return _reportTimeLabel;
    
}
- (UILabel *)reportTime{
    
    if (!_reportTime) {
        _reportTime = [[UILabel alloc]init];
        _reportTime.font = CHINESE_SYSTEM(15);
    }
    return _reportTime;
    
}
- (UILabel *)addressLabel{
    
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.text = @"位置:";
        _addressLabel.font = CHINESE_SYSTEM(15);
    }
    return _addressLabel;
    
}
- (UILabel *)address{
    
    if (!_address) {
        _address = [[UILabel alloc]init];
        _address.font = CHINESE_SYSTEM(15);
    }
    return _address;
    
}

- (UILabel *)feedBackLabel{
    
    if (!_feedBackLabel) {
        _feedBackLabel = [[UILabel alloc]init];
        _feedBackLabel.text = @"反馈内容:";
        _feedBackLabel.font = CHINESE_SYSTEM(15);;
    }
    return _feedBackLabel;
    
}

- (UILabel *)feedBack{
    if (!_feedBack) {
        _feedBack = [[UILabel alloc]init];
        _feedBack.numberOfLines = 0;
        _feedBack.font = CHINESE_SYSTEM(15);
    }
    return _feedBack;
}

- (UICollectionView *)mainCollectionView{
    
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
        CGFloat width = (App_Frame_Width - 100) / 5;
        layout.itemSize = CGSizeMake(width, width);
        
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        [_mainCollectionView registerClass:[ZLGaodeDetailImageCollectionViewCell class] forCellWithReuseIdentifier:@"ZLGaodeDetailImageCollectionViewCell"];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        
    }
    return _mainCollectionView;
}

@end
