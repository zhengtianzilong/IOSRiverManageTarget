//
//  WJYAlertTipsView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/5/28.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "WJYAlertTipsView.h"
#import "ZLAlertScoreTableViewCell.h"
#import "ZLAlertContentTableViewCell.h"
@interface WJYAlertTipsView()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong)UIView *showView;
@property(nonatomic,strong)UIView *bottomLineView,*seperateLineView;
@property(nonatomic,copy)NSString *viewTitle,*bottomButtonTitle,*placeholderText;
@end

static const CGFloat kAlertViewHeight=200;
static const CGFloat kAlertViewLeftAndRight=15;
static const CGFloat kTopTitleLabelSapn=10;
static const CGFloat kTitleLabelHeight=16;
static const CGFloat kLeftAndRightSpan=10;
static const CGFloat kTopContentTextHeight=10;
static const CGFloat kContentTextViewHeight=100;
static const CGFloat kButtonHeight=44;

@implementation WJYAlertTipsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(instancetype)initPagesViewWithTitle:(NSString *)title bottomButtonTitle:(NSString *)bottomButtonTitle cellText:(NSString *)cellText
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        _viewTitle=title;
        _bottomButtonTitle = bottomButtonTitle;
        

        
        [self layoutViewPage];
    }
    return self;
}


-(void)layoutViewPage
{
    if (!self.showView) {
        self.showView=[[UIView alloc]init];
        self.showView.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.showView];
        self.showView.layer.cornerRadius=8;
        self.showView.layer.masksToBounds=true;
        [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kAlertViewLeftAndRight);
            make.right.mas_equalTo(-kAlertViewLeftAndRight);
            make.center.mas_equalTo(0);
            make.height.mas_equalTo(kAlertViewHeight);
        }];
    }
    
    
    if (!self.titleLabel) {
        self.titleLabel=[[UILabel alloc]init];
        self.titleLabel.font=[UIFont systemFontOfSize:15];
        self.titleLabel.text=self.viewTitle;
        self.titleLabel.textColor=[UIColor blackColor];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self.showView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kLeftAndRightSpan);
            make.right.mas_equalTo(-kLeftAndRightSpan);
            make.top.mas_equalTo(kTopTitleLabelSapn);
            make.height.mas_equalTo(kTitleLabelHeight);
        }];
    }
    
    //区别是否有头部的布局
    CGFloat curContentTextTop=self.viewTitle.length?kTopTitleLabelSapn+kTitleLabelHeight+kTopContentTextHeight:kTopTitleLabelSapn;
    CGFloat curContentTextHeight=self.viewTitle.length?kContentTextViewHeight:kContentTextViewHeight+kTopTitleLabelSapn+kTitleLabelHeight;
    

    
    
    if (!self.bottomButton) {
        self.bottomButton=[[UIButton alloc]init];
        [self.bottomButton setTitle:self.bottomButtonTitle forState:UIControlStateNormal];
        //        [self.rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.bottomButton setTitleColor:[UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [self.bottomButton addTarget:self action:@selector(bottomBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.showView addSubview:self.bottomButton];
        [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.showView.mas_bottom);
            make.height.mas_equalTo(kButtonHeight);
            make.left.equalTo(self.mas_left);
        }];
    }
    
    
    if (!self.bottomLineView) {
        self.bottomLineView=[[UIView alloc]init];
        self.bottomLineView.backgroundColor=[UIColor grayColor];
        [self.showView addSubview:self.bottomLineView];
        [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-kButtonHeight);
            make.height.mas_equalTo(0.3);
        }];
    }
    
    if (!self.mainTableView) {
        self.mainTableView = [[UITableView alloc]init];
        self.mainTableView.delegate=self;
        self.mainTableView.dataSource = self;
        
        self.mainTableView.rowHeight = UITableViewAutomaticDimension;
        self.mainTableView.estimatedRowHeight = 50;
        
        [self.mainTableView registerClass:[ZLAlertScoreTableViewCell class] forCellReuseIdentifier:@"ZLAlertScoreTableViewCell"];
        [self.mainTableView registerClass:[ZLAlertContentTableViewCell class] forCellReuseIdentifier:@"ZLAlertContentTableViewCell"];
        
        [self.showView addSubview:self.mainTableView];
        [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kLeftAndRightSpan);
            make.right.mas_equalTo(-kLeftAndRightSpan);
            make.top.mas_equalTo(curContentTextTop);
//            make.height.mas_equalTo(curContentTextHeight);
            make.bottom.equalTo(self.bottomLineView.mas_top);
        }];
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        ZLAlertContentTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"ZLAlertContentTableViewCell" forIndexPath:indexPath];
        
        if (contentCell == nil) {
            
            contentCell = [[ZLAlertContentTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"ZLAlertContentTableViewCell"];
            
        }
        
        return contentCell;
        
    }else if (indexPath.row == 1){
        
         ZLAlertScoreTableViewCell *scoreCell = [tableView dequeueReusableCellWithIdentifier:@"ZLAlertScoreTableViewCell" forIndexPath:indexPath];
        
        if (scoreCell == nil) {
             scoreCell = [[ZLAlertScoreTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"ZLAlertScoreTableViewCell"];
            
            
        }
        
        
        return scoreCell;
        
        
    }
    
    return nil;
}






#pragma mark 自定义代码

-(void)bottomBtnClicked
{
    if (self.bottomBlock) {
        self.bottomBlock();
    }
}

@end
