//
//  ZLRiverChangeCollectionView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/7.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverChangeCollectionView.h"
@interface ZLRiverChangeCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *mainCollectionView;

// cell数据
@property (nonatomic, strong) NSMutableArray *itemArray;;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *lineView;



@end

@implementation ZLRiverChangeCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpViews];
        
        
    }
    return self;
    
}
- (void)setUpViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    
    [self addSubview:self.mainCollectionView];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10);
        
        make.right.equalTo(self.mas_right).offset(0);
        
        make.top.equalTo(self);
        
        make.height.mas_equalTo(35);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0);
        
        make.right.equalTo(self.mas_right).offset(0);
        
        make.top.equalTo(self.titleLabel.mas_bottom);
        
        make.height.mas_equalTo(1);
    }];
    
    
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.top.equalTo(self.lineView.mas_bottom);
        make.bottom.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(((Main_Screen_Width - 20) / 3 / 1.5 ) * 2);
    }];
    
}

- (void)updateConstraints{
    [super updateConstraints];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

#pragma mark -- collection的代理方法


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLRiverChangeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZLRiverChangeCollectionViewCell" forIndexPath:indexPath];
    
    cell.model = self.itemArray[indexPath.row];
    return cell;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLHomeCenterCollectionModel *model = self.itemArray[indexPath.row];
    
    if (self.centerItemBlock)
    {
        self.centerItemBlock(model, indexPath);
        
    }
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return (CGSizeMake((Main_Screen_Width - 20) / 3, (Main_Screen_Width - 20) / 3 / 1.5 ));
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (UICollectionView *)mainCollectionView{
    if (!_mainCollectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        _mainCollectionView.dataSource = self;
        _mainCollectionView.delegate = self;
        _mainCollectionView.scrollEnabled = NO;
        [_mainCollectionView registerClass:[ZLRiverChangeCollectionViewCell class] forCellWithReuseIdentifier:@"ZLRiverChangeCollectionViewCell"];
        
    }
    return _mainCollectionView;
}


- (NSMutableArray *)itemArray{
    if (!_itemArray) {
        _itemArray = @[].mutableCopy;
        NSArray *titleArray = @[ @"公示牌", @"取水口", @"排污口"];
        NSArray *imageTitle = @[ @"map_billboard", @"map_intake", @"map_outlet"];
        for (NSInteger i = 0; i < titleArray.count; i++)
        {
            ZLHomeCenterCollectionModel *model = [ZLHomeCenterCollectionModel new];
            model.imageTitle = imageTitle[i];
            model.title = titleArray[i];
            
            [self.itemArray addObject:model];
        }
    }
    
    return _itemArray;
    
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        
        _titleLabel.text = @"修改信息";
    }
    return _titleLabel;
    
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        
        _lineView.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
    }
    return _lineView;
}




@end
