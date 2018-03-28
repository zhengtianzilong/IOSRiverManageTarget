//
//  ZLPolicyAllRiverCollectionView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLPolicyAllRiverCollectionView.h"
#import "ZLPolicyALlRiverCollectionViewCell.h"
#import "ZLPolicyAllRiverAreaModel.h"
@interface ZLPolicyAllRiverCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *mainCollectionView;

// cell数据
@property (nonatomic, strong) NSMutableArray *itemArray;;

@end
@implementation ZLPolicyAllRiverCollectionView
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpViews];
        
        
    }
    return self;
    
}
- (void)setUpViews{
    
    [self addSubview:self.mainCollectionView];
    
}

- (void)updateConstraints{
    [super updateConstraints];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
}

#pragma mark -- collection的代理方法


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLPolicyALlRiverCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZLPolicyALlRiverCollectionViewCell" forIndexPath:indexPath];
    ZLPolicyAllRiverAreaModel *model = self.itemArray[indexPath.row];
    cell.areaModel = model;
    
    
    return cell;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLPolicyAllRiverAreaModel *model = self.itemArray[indexPath.row];
    
//    ZLPolicyALlRiverCollectionViewCell *cell = (ZLPolicyALlRiverCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    for (ZLPolicyAllRiverAreaModel *model in self.itemArray) {
        
        model.isSelect = NO;
        
    }
    
    
    model.isSelect = !model.isSelect;
    
    
    [collectionView reloadData];
    
    if (self.centerItemBlock)
    {
        self.centerItemBlock(model.title, indexPath);
    }
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return (CGSizeMake(Main_Screen_Width / 3, 50));
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
//        _mainCollectionView.scrollEnabled = NO;
        [_mainCollectionView registerClass:[ZLPolicyALlRiverCollectionViewCell class] forCellWithReuseIdentifier:@"ZLPolicyALlRiverCollectionViewCell"];
        
    }
    return _mainCollectionView;
}


- (NSMutableArray *)itemArray{
    if (!_itemArray) {
        _itemArray = @[].mutableCopy;
        NSArray *titleArray = @[@"船舶查询", @"处罚记录", @"法律法规", @"报港查询", @"通讯录", @"通知公告", @"视频监控",@"船队报港",@"船舶查询", @"处罚记录", @"法律法规", @"报港查询", @"通讯录", @"通知公告", @"视频监控",@"船队报港",@"船舶查询", @"处罚记录", @"法律法规", @"报港查询", @"通讯录", @"通知公告", @"视频监控",@"船队报港"];
        
        for (NSInteger i = 0; i < titleArray.count; i++)
        {
            ZLPolicyAllRiverAreaModel *model = [ZLPolicyAllRiverAreaModel new];
            model.title = titleArray[i];
            model.isSelect = NO;

            [self.itemArray addObject:model];
        }
    }
    
    return _itemArray;
    
}

@end
