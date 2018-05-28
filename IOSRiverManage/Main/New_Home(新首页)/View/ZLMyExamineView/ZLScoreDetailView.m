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
#import "ZLMyExamineModel.h"
#import "WJYAlertView.h"
#import "WJYAlertTipsView.h"
@interface ZLScoreDetailView()<YUFoldingTableViewDelegate>
@property (nonatomic, strong) YUFoldingTableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *scoreMutableArray;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@end

@implementation ZLScoreDetailView

- (void)getData{
    
    for (NSInteger i = 0; i < 5; i++) {
        
        for (int j = 0; j < 3; j++) {
            
            ZLMyExamineModel *model = [[ZLMyExamineModel alloc]init];
            model.score = @"";
            [self.scoreMutableArray addObject:model];
        }
        [self.sourceArray addObject:self.scoreMutableArray];
    }
}

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        self.scoreMutableArray = [NSMutableArray array];
        self.sourceArray = [NSMutableArray array];
        [self getData];
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
        make.height.mas_equalTo(2 * Main_Screen_Height);
        make.width.mas_equalTo(Main_Screen_Width);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (void)layoutSubviews{
    
    
    
}

// 返回箭头的位置
- (YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    return YUFoldingSectionHeaderArrowPositionRight;
}
- (NSInteger )numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    return self.sourceArray.count;
}
- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section
{
    NSMutableArray *array = self.sourceArray[section];
    return array.count;
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
    cell.title.text = [NSString stringWithFormat:@"Row %ld",indexPath.row];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSMutableArray *array = self.sourceArray[indexPath.section];
    
    ZLMyExamineModel *model = array[indexPath.row];
    cell.totalScoreTextField.text = model.score;
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.scroeInputBlock = ^(NSString *text) {
        
        NSIndexPath *indexPath = [yuTableView indexPathForCell:cell];
        
        NSMutableArray *array = self.sourceArray[indexPath.section];
        
        ZLMyExamineModel *model = array[indexPath.row];
        
        model.score = text;
        
        
//        [dic setObject:text forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
//        [self.scoreMutableArray addObject:dic];
        NSLog(@"hahaha%@",text);
        
    };
    
    return cell;
}

- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [yuTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WJYAlertTipsView *tipsView = [[WJYAlertTipsView alloc]initPagesViewWithTitle:@"河长制工作制度执行" bottomButtonTitle:@"关闭" cellText:@""];
    WJYAlertView *alertView = [[WJYAlertView alloc]initWithCustomView:tipsView dismissWhenTouchedBackground:YES];
    
    tipsView.bottomBlock = ^{
        
        [alertView dismissWithCompletion:nil];
        
    };
    
    [alertView show];
    
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
