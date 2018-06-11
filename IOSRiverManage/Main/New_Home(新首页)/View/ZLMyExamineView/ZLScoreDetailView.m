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
#import "ZLGetScoreDetailService.h"
#import "ZLGetScoreDataModel.h"
@interface ZLScoreDetailView()<YUFoldingTableViewDelegate>
@property (nonatomic, strong) YUFoldingTableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *scoreMutableArray;



@end

@implementation ZLScoreDetailView

- (void)getData{
    
    ZLGetScoreDetailService *service = [[ZLGetScoreDetailService alloc]initWithmanagerDetailCode:_noModel.managerDetailCode modelCode:_noModel.modelCode];
    
    [service startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
       
        ZLGetScoreDataModel *dataModel = [[ZLGetScoreDataModel alloc]initWithString:request.responseString error:nil];
        
        if ([dataModel.code isEqualToString:@"0"]) {
            
            for (ZLGetScoreDetailArrayModel *rowModel in dataModel.data.rows) {
                
                [self.sourceArray addObject:rowModel];
                
            }
        }
        
        [_mainTableView reloadData];
        ZLLog(@"%@",request.responseString);
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
         ZLLog(@"%@",request.responseString);
        
        
    }];
    
}

- (instancetype)initWithModel:(ZLHaveNoExamineModel *)noModel{
    if (self = [super init]) {
        self.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        
        self.scoreMutableArray = [NSMutableArray array];
        self.sourceArray = [NSMutableArray array];
        self.noModel = noModel;
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
    ZLGetScoreDetailArrayModel *arrayModel = self.sourceArray[section];
    return arrayModel.list.count;
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
    
    ZLGetScoreDetailArrayModel *arrayModel = self.sourceArray[section];
    
    return arrayModel.title;
}
- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    ZLScoreTableViewCell *cell = [yuTableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZLScoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    ZLGetScoreDetailArrayModel *arrayModel = self.sourceArray[indexPath.section];
    
    ZLGetScoreDetailModel *detailModel = arrayModel.list[indexPath.row];
    
    cell.status = self.noModel.status;
    cell.detailModel = detailModel;
    
//    cell.totalScoreTextField.text = detailModel.selfComment;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.scroeInputBlock = ^(NSString *text) {
        
        NSIndexPath *indexPath = [yuTableView indexPathForCell:cell];
        
        ZLGetScoreDetailArrayModel *arrayModel = self.sourceArray[indexPath.section];
        
        ZLGetScoreDetailModel *detailModel = arrayModel.list[indexPath.row];
        
       detailModel.selfComment = text;
        
        NSLog(@"hahaha%@",text);
        
    };
    
    return cell;
}

- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [yuTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZLGetScoreDetailArrayModel *arrayModel = self.sourceArray[indexPath.section];
    
    ZLGetScoreDetailModel *detailModel = arrayModel.list[indexPath.row];
    
    WJYAlertTipsView *tipsView = [[WJYAlertTipsView alloc]initPagesViewWithTitle:S_ScoreDetailTips bottomButtonTitle:@"关闭" cellModel:detailModel];
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

-  (void)yuFoldingTableView:(YUFoldingTableView *)yuTableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    

}



#pragma mark - YUFoldingTableViewDelegate / optional （可选择实现的）
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView descriptionForHeaderInSection:(NSInteger )section
{
    return @"";
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
        _mainTableView.foldingState = YUFoldingSectionStateFlod;
        _mainTableView.scrollEnabled = NO;
        
    }
    return _mainTableView;
}

@end
