//
//  ZLGaodeEventDetailViewController.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/12/26.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLGaodeEventDetailViewController.h"
#import "ZLGaodeDetailView.h"
#import "ZLRiverRecordPointDetailCollectionViewCell.h"

@interface ZLGaodeEventDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>
{
    CGPoint beginOffset;
}

@property (nonatomic, strong) ZLGaodeDetailView *gaodeDetailView;





@end

@implementation ZLGaodeEventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

//    self.gaodeDetailView.titleLabel.text = @"河面污染严重, 很多垃圾啊";
//    self.gaodeDetailView.riverPeople.text = @"李乐";
//    self.gaodeDetailView.reportObject.text = @"李倩、刘云";
//    self.gaodeDetailView.reportTime.text = @"2017-10-13 09:20";
//    self.gaodeDetailView.address.text = @"南京市玄武区水西门大街120号";
//    self.gaodeDetailView.feedBack.text = @"南京市玄武区水西门大街120号南京市玄武区水西门大街120号南京市玄武区水西门大街120号南京市玄武区水西门大街120号南京市玄武区水西门大街120号南京市玄武区水西门大街120号南京市玄武区水西门大街120号南京市玄武区水西门大街120号南京市玄武区水西门大街120号";
   
    
    [self.view addSubview:self.mainCollectionView];
    
}

- (void)cancelClick{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [self.mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.index inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 向下取整
    NSInteger currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    if (_scrollBlock) {
        self.scrollBlock(currentPage);
    }
    
    
    ZLLog(@"%ld页", currentPage);
    
    
}
//
//// 已经开始滚动
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//
//
//
//
//}

#pragma mark -- collection的代理方法


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLRiverRecordPointDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZLRiverRecordPointDetailCollectionViewCell" forIndexPath:indexPath];
    ZLGaodeEventAndTaskModel *model = self.sourceArray[indexPath.row];
    cell.dataModel = model;
    
    return cell;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.sourceArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    if (self.callback) {
        self.callback(@(indexPath.row));
    }
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return (CGSizeMake(Main_Screen_Width, self.view.frame.size.height));
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionView *)mainCollectionView{
    
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        _mainCollectionView.dataSource = self;
        _mainCollectionView.delegate = self;
        //        _mainCollectionView.scrollEnabled = NO;
        _mainCollectionView.pagingEnabled = YES;
        _mainCollectionView.bounces = NO;
        _mainCollectionView.showsHorizontalScrollIndicator = NO;
        
        
        [_mainCollectionView registerClass:[ZLRiverRecordPointDetailCollectionViewCell class] forCellWithReuseIdentifier:@"ZLRiverRecordPointDetailCollectionViewCell"];
    }
    return _mainCollectionView;
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
