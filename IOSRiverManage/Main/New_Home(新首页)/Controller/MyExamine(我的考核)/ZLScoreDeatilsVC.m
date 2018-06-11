//
//  ZLScoreDeatilsVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/31.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLScoreDeatilsVC.h"
#import "YUFoldingTableView.h"
#import "ZLScoreTableViewCell.h"
#import "ZLMyExamineModel.h"
#import "WJYAlertView.h"
#import "WJYAlertTipsView.h"
#import "ZLGetScoreDetailService.h"
#import "ZLGetScoreDataModel.h"

#import "ZLScoreDetailView.h"
#import "ZLScoreBottomView.h"
#import "ZLGetScoreDataModel.h"
#import "ZLCommitMyScoreService.h"

@interface ZLScoreDeatilsVC ()<YUFoldingTableViewDelegate>
@property (nonatomic, strong) YUFoldingTableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *scoreMutableArray;

@end

@implementation ZLScoreDeatilsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(CVIEW_GRAY_COLOR);
    
    self.scoreMutableArray = [NSMutableArray array];
    self.sourceArray = [NSMutableArray array];
//    self.noModel = noModel;
    [self getData];
    [self setupUI];
}

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

//- (instancetype)initWithModel:(ZLHaveNoExamineModel *)noModel{
//    if (self = [super init]) {
//        
//    }
//    return self;
//}

- (void)setupUI{
    //    [self addSubview:self.baseInfoLabel];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
//        make.height.mas_equalTo(2 * Main_Screen_Height);
        make.width.mas_equalTo(Main_Screen_Width);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    ZLScoreBottomView *bottomView = [[ZLScoreBottomView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 60 * kScreenHeightRatio - TopBarHeight, Main_Screen_Width, 60 * kScreenHeightRatio) withTitles:@[@"保存",@"提交"]];
    
    [bottomView.saveButton addTarget:self action:@selector(saveClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [bottomView.reportButton addTarget:self action:@selector(commitClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    [self.view addSubview:bottomView];
    
    bottomView.hidden = !_isShowBottomView;
    
    
}


- (void)reporeServiceWithflag:(NSString *)flag withStatus:(NSString *)status{
    BOOL isCommit = YES;
    
    for (ZLGetScoreDetailArrayModel *rowModel in self.sourceArray) {
        // 判断是不是输入完全部分值了
        for (ZLGetScoreDetailModel *detailModel in rowModel.list) {
            
            if (!([detailModel.type isEqualToString:@"2"] || [detailModel.type isEqualToString:@"3"])) {
                if ( detailModel.selfComment == nil || [detailModel.selfComment isEqualToString:@""]) {
                    isCommit = NO;
                }
            }
        }
    }
    
    if (isCommit) {
        
        ZLCommitMyScoreService *commitService = [[ZLCommitMyScoreService alloc]initWithArray:self.sourceArray managerDetailCode:self.noModel.managerDetailCode modelCode:self.noModel.managerCode flag:flag];
        [SVProgressHUD showWithStatus:status];
        [commitService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            ZLBaseModel *model = [[ZLBaseModel alloc]initWithString:request.responseString error:nil];
            
            if ([model.code isEqualToString:@"0"]) {
                
                [SVProgressHUD showSuccessWithStatus:@"成功"];
                
                [SVProgressHUD dismissWithDelay:0.4 completion:^{
                    
                    [self backClick];
                    
                }];
            }else{
                
                [SVProgressHUD showErrorWithStatus:model.detail];
                [SVProgressHUD dismissWithDelay:0.6];
                
            }
            ZLLog(@"%@", request.responseString);
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
            [SVProgressHUD dismissWithDelay:0.3];
        }];
        
    }else{
        
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 0) {
                return ;
                
            }
            
        } title:@"提示" message:@"还有未输入的分值" cancelButtonName:@"取消" otherButtonTitles:nil, nil];
        
    }
}

- (void)commitClick{
    
    
    
    [self reporeServiceWithflag:@"saveAndSub" withStatus:@"提交中"];
}
- (void)saveClick{
    [self reporeServiceWithflag:@"save" withStatus:@"保存中"];
}


- (void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
    
//    [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view);
//        make.top.equalTo(self.view).offset(0);
//        make.height.mas_equalTo(height);
//        make.width.mas_equalTo(Main_Screen_Width);
//        make.bottom.equalTo(self.view.mas_bottom);
//
//    }];
    

//    self.mainTableView.contentSize = CGSizeMake(Main_Screen_Width, height + TopBarHeight + 60 * kScreenHeightRatio + 200);
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0,   60 * kScreenHeightRatio, 0);
    yuTableView.contentInset = insets;
    
    ZLLog(@"height%f,  %f",height, self.mainTableView.contentSize.height );
    
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
        
//        _mainTableView.contentSize = CGSizeMake(Main_Screen_Width,2000);
        
        
        _mainTableView.scrollEnabled = YES;
        
    }
    return _mainTableView;
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"考核详情" attributes:dic];
    
    return title;
    
}

@end
