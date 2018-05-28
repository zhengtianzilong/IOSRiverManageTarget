//
//  ZLScoreDetailVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/16.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLScoreDetailVC.h"
#import "ZLScoreDetailView.h"
#import "ZLScoreBottomView.h"

@interface ZLScoreDetailVC ()
@property (nonatomic, strong) ZLScoreDetailView *detailView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@end

@implementation ZLScoreDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainScrollView];
    
    [self.mainScrollView addSubview:self.detailView];
    
    ZLScoreBottomView *bottomView = [[ZLScoreBottomView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 50 * kScreenHeightRatio - TopBarHeight, Main_Screen_Width, 50 * kScreenHeightRatio) withTitles:@[@"保存",@"提交"]];

    [self.view addSubview:bottomView];

}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.equalTo(self.view);
        
        make.left.right.top.bottom.equalTo(self.view);
        
    }];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        //设置边距相对于scrollView的约束
        //（自己的见解：contentView的edges相对scrollView的edges的约束  contentView实际上被拉伸的宽高是相对于scrollView的contentSize的）
        make.edges.equalTo(self.mainScrollView);
        
        //        make.top.equalTo(self.mainScrollView);
        //
        //        make.bottom.equalTo(self.mainScrollView.mas_bottom);
        //        //因为上面的宽高是相对于contentSize的  所以为0  这里需要设置contentView的宽度约束后  scrollView的contentSize.width就会拉伸
        make.width.equalTo(self.mainScrollView);
        
        //        make.left.equalTo(self.view);
        //        make.right.equalTo(self.view.mas_right);
        //        make.top.equalTo(self.view);
        ////        make.bottom.equalTo(self.mainScrollView.mas_bottom);
        //
        //        make.height.mas_equalTo(Main_Screen_Height);
        
        
        
    }];
    
    
    // 设置过渡视图的底边距（此设置将影响到scrollView的contentSize）
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.detailView.mas_bottom);
    }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"评分" attributes:dic];
    
    return title;
    
}

- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]init];
        _mainScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _mainScrollView;
}

- (ZLScoreDetailView *)detailView{
    if (!_detailView) {
        _detailView = [[ZLScoreDetailView alloc]init];
        
    }
    return _detailView;
}



@end
