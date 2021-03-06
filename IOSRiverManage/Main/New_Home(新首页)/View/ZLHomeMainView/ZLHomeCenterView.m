//
//  ZLHomeCenterView.m
//  HongZeHaiShi
//
//  Created by 蔡紫龙 on 2018/1/17.
//  Copyright © 2018年 xgzl. All rights reserved.
//

#import "ZLHomeCenterView.h"
#import "ZLNewLoginModel.h"
@interface ZLHomeCenterView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *mainCollectionView;

// cell数据
@property (nonatomic, strong) NSMutableArray *itemArray;;

@property (nonatomic, strong) YTKKeyValueStore *store;

@end

@implementation ZLHomeCenterView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpViews];
        
        
    }
    return self;
    
}
- (void)setUpViews{
    
    [self addSubview:self.mainCollectionView];
    
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.right.equalTo(self.mas_right);
        
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
    
    ZLHomeCenterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZLHomeCenterCollectionViewCell" forIndexPath:indexPath];
    
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
    
    return (CGSizeMake(Main_Screen_Width / 4, Main_Screen_Width / 4));
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
        [_mainCollectionView registerClass:[ZLHomeCenterCollectionViewCell class] forCellWithReuseIdentifier:@"ZLHomeCenterCollectionViewCell"];
        
    }
    return _mainCollectionView;
}


- (NSMutableArray *)itemArray{
    if (!_itemArray) {
        _itemArray = @[].mutableCopy;
        
        self.store = [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
        
        NSString *tableName = DBUserTable;
        
        [self.store createTableWithName:tableName];
        NSString *userModel = [self.store getStringById:DBLoginModel fromTable:DBUserTable];
        
        ZLNewLoginModel *newLoginModel = [[ZLNewLoginModel alloc]initWithString:userModel error:nil];
        
        NSArray *titleArray = nil;
        NSArray *imageTitle = nil;
        
        
        if (newLoginModel.data.areaCode.length >= 4) {
            
            NSString *subString = [newLoginModel.data.areaCode substringWithRange:NSMakeRange(0, 4)];
            
            if ([subString isEqualToString:@"3211"]) {
                
//#if WanApp
                titleArray = @[@"事件管理", @"任务管理", S_RiverRecordInfo, @"综合统计", @"新闻公告", @"通讯录",@"我的考核"];
//#else
//                titleArray = @[@"事件管理", @"任务管理", @"巡河记录", @"综合统计", @"新闻公告", @"通讯录",@"我的考核"];
//#endif
//
                
                imageTitle = @[@"home_eventManager", @"home_taskManager", @"home_riverRecord", @"home_statistical", @"home_news", @"home_addressbook",@"home_more"];
                
            }else{
                
//#if WanApp
                titleArray = @[@"事件管理", @"任务管理", S_RiverRecordInfo, @"综合统计", @"新闻公告", @"通讯录", @"交办督办",@"我的考核"];
//#else
//                titleArray = @[@"事件管理", @"任务管理", @"巡河记录", @"综合统计", @"新闻公告", @"通讯录", @"交办督办",@"我的考核"];
//#endif
                
                
                imageTitle = @[@"home_eventManager", @"home_taskManager", @"home_riverRecord", @"home_statistical", @"home_news", @"home_addressbook", @"home_ oversee",@"home_more"];
            }
            
            
        }else{
            
//#if WanApp
            titleArray = @[@"事件管理", @"任务管理", S_RiverRecordInfo, @"综合统计", @"新闻公告", @"通讯录", @"交办督办",@"我的考核"];
//#else
//            titleArray = @[@"事件管理", @"任务管理", @"巡河记录", @"综合统计", @"新闻公告", @"通讯录", @"交办督办",@"我的考核"];
//#endif
            imageTitle = @[@"home_eventManager", @"home_taskManager", @"home_riverRecord", @"home_statistical", @"home_news", @"home_addressbook", @"home_ oversee",@"home_more"];
        }
        
        
        
        
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

@end
