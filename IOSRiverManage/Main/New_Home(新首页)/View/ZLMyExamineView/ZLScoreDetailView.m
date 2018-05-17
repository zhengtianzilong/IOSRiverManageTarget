//
//  ZLScoreDetailView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLScoreDetailView.h"
#import "YUFoldingTableView.h"
#import "ZLScoreTableViewCell.h"
@interface ZLScoreDetailView()<YUFoldingTableViewDelegate>
@property (nonatomic, strong) YUFoldingTableView *mainTableView;
@end

@implementation ZLScoreDetailView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
//    [self addSubview:self.baseInfoLabel];
    [self addSubview:self.mainTableView];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.top.equalTo(self).offset(0);
        make.height.mas_equalTo(Main_Screen_Height);
        make.width.mas_equalTo(Main_Screen_Width);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
  
    
}


// 返回箭头的位置
- (YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    return YUFoldingSectionHeaderArrowPositionRight;
}
- (NSInteger )numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    return 10;
}
- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section
{
    return 3;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger )section
{
    return 50;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Title %ld",section];
}
- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    ZLScoreTableViewCell *cell = [yuTableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZLScoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"Row %ld",indexPath.row];
    return cell;
}

- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [yuTableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)yuFoldingTableView:(YUFoldingTableView *)yuTableView tapHeader:(CGFloat)height{
    
    [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(0);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(Main_Screen_Width);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
}


#pragma mark - YUFoldingTableViewDelegate / optional （可选择实现的）
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView descriptionForHeaderInSection:(NSInteger )section
{
    return @"detailText";
}

- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView backgroundColorForHeaderInSection:(NSInteger )section{
    return [UIColor whiteColor];
}



- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView textColorForTitleInSection:(NSInteger )section{
    
    return HEXCOLOR(CNAVGATIONBAR_COLOR);
    
}

- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView textColorForDescriptionInSection:(NSInteger )section{
     return HEXCOLOR(CNAVGATIONBAR_COLOR);
}




- (YUFoldingTableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[YUFoldingTableView alloc] initWithFrame:CGRectZero];
        //        _mainTableView.openSectionArray = [NSArray arrayWithObjects:@1,@2, nil];
        _mainTableView.foldingDelegate = self;
        //            _mainTableView.datasource = self;
        //        _mainTableView.autoAdjustOpenAndClose = YES;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        // 可以设置cell默认展开，不设置的话，默认折叠
        _mainTableView.foldingState = YUFoldingSectionStateShow;
        _mainTableView.scrollEnabled = NO;
        //            _mainTableView.autoAdjustOpenAndClose = NO;
    }
    return _mainTableView;
}

@end
