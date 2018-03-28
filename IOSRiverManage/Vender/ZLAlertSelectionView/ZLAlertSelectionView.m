//
//  ZLAlertSelectionView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/22.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLAlertSelectionView.h"
#import "ZLAlertSelectTableViewCell.h"
#import "UIView+CustomBorder.h"
#define kLastSelection @"YJSelectionArchive"
@interface ZLAlertSelectionView()<UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) NSArray *contentArr;

@property (nonatomic, strong) UITapGestureRecognizer *tapGes;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *sureTitle;

@property (nonatomic, assign) BOOL isSingleSelection;//是否是单选状态

@property (nonatomic, strong) NSMutableArray *selectedArray;//已选择的index数组
@end

@implementation ZLAlertSelectionView

- (instancetype)initWithFrame:(CGRect)frame sourceArray:(NSMutableArray *)sourceArray withTitle:(NSString *)title sureTitle:(NSString *)sureTitle singleSelection:(BOOL)selection{
    if (self = [super initWithFrame:frame]) {
        
        _title = title;
        
        _sureTitle = sureTitle;
        
        _isSingleSelection = selection;
        
        self.selectedArray = [[[NSUserDefaults standardUserDefaults] objectForKey:kLastSelection] mutableCopy];
        
        if (!self.selectedArray) {
            self.selectedArray = [NSMutableArray new];
        }
        
//        self.selectedArray = [NSMutableArray array];
        
        self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self commonInit];
        self.contentArr = sourceArray;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        _tapGes.delegate = self;

        [self addGestureRecognizer:_tapGes];
        
    }
    return self;
}

- (void)commonInit{
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.titleLabel];
    [self.alertView addSubview:self.mainTableView];
    [self.alertView addSubview:self.bottomView];
    [self.bottomView addSubview:self.cancelButton];
    [self.bottomView addSubview:self.sureButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(Main_Screen_Height * 0.4);
        make.width.mas_equalTo(Main_Screen_Width * 0.8);
        make.center.equalTo(self);
        
    }];
    
    [self.alertView addBottomBorderWithColor:HEXCOLOR(CVIEW_GRAY_COLOR) width:(1)];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(self.alertView.mas_height).multipliedBy(0.16);
        make.width.equalTo(self.alertView);
        make.left.equalTo(self.alertView);
        make.top.equalTo(self.alertView);
        
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(self.alertView.mas_height).multipliedBy(0.16);
        make.width.equalTo(self.alertView);
        make.left.equalTo(self.alertView);
        make.bottom.equalTo(self.alertView.mas_bottom);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(self.bottomView.mas_height);
        make.width.equalTo(self.bottomView).multipliedBy(0.5);
        make.left.equalTo(self.bottomView);
        make.bottom.equalTo(self.bottomView.mas_bottom);
    }];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(self.bottomView.mas_height);
        make.width.equalTo(self.bottomView).multipliedBy(0.5);
        make.left.equalTo(self.cancelButton.mas_right);
        make.bottom.equalTo(self.bottomView.mas_bottom);
    }];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.width.equalTo(self.alertView);
        make.left.equalTo(self.alertView);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    
    CAShapeLayer *bottomLayer = [[CAShapeLayer alloc]init];
    
    bottomLayer.frame = CGRectMake(Main_Screen_Width * 0.8 / 2, 0, 1, Main_Screen_Height * 0.4 * 0.16);
    bottomLayer.backgroundColor = [HEXCOLOR(CVIEW_GRAY_COLOR) CGColor];
    
    [_bottomView.layer addSublayer:bottomLayer];
    
}

#pragma mark -- 手势代理方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    CGPoint point = [gestureRecognizer locationInView:self];
    if (CGRectContainsPoint(self.alertView.frame, point)) {
        return NO;
    }else{
        return YES;
    }
    
}

// 手势点击触发的事件
- (void)tapClick:(UITapGestureRecognizer *)ges{
    
    [self hide];
    
}
// 取消按钮触发的事件
- (void)cancelClick{
    [self hide];
}

- (void)sureClick:(UIButton *)button{
    
    if (_isSingleSelection) {
        if (_selectItem) {
            self.selectItem(self.selectedIndexPath.row);
        }
    }else{
        
        [[NSUserDefaults standardUserDefaults] setObject:self.selectedArray forKey:kLastSelection];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if (_selectItemsMuti) {
            self.selectItemsMuti(_selectedArray);
        }
    }
    
   
    [self cancelClick];
}




- (void)show{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)hide{
    [UIView animateWithDuration:0.2 animations:^{
        
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}


#pragma mark -- TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contentArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.contentArr[indexPath.row];
    static NSString *CellIdentifier = @"ZLAlertSelectTableViewCell";
    ZLAlertSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    if (cell == nil) {
        cell = [[ZLAlertSelectTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier];
    }
    
    if (!self.isSingleSelection) {
        cell.selectionButton.selected = NO;
        if ([self.selectedArray containsObject:@(indexPath.row)]) {
            cell.selectionButton.selected = YES;
        }
    }else{
        if (self.selectedIndexPath && self.selectedIndexPath == indexPath) {
            cell.selectionButton.selected = YES;
        }else{
            cell.selectionButton.selected = NO;
        }
    }
   
    cell.descriptionLabel.text = title;
    return cell;
    
//    if (self.isSingleSelection) {
//        [self.selectedArray removeAllObjects];
//        [self.selectedArray addObject:@(indexPath.row)];
//        if (self.canMemory && self.memoryAddress.length <= 0) {
//            [[NSUserDefaults standardUserDefaults] setObject:self.selectedArray forKey:[NSString stringWithFormat:kLastSelection, self.delegate]];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }else{
//            [[NSUserDefaults standardUserDefaults] setObject:self.selectedArray forKey:[NSString stringWithFormat:self.memoryAddress, self.delegate]];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }
//        self.completeSelection(indexPath.row, nil);
//        [self closeView:self];
//    } else {
//        cell.selectionButton.selected = !cell.selectionButton.isSelected;
//        if (cell.selectionButton.isSelected) {
//            [self.selectedArray addObject:@(indexPath.row)];
//        } else {
//            [self.selectedArray removeObject:@(indexPath.row)];
//        }
//    }
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZLAlertSelectTableViewCell *cell;
    if (self.selectedIndexPath && self.isSingleSelection) {
        cell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
        cell.selectionButton.selected = NO;
    }
    
    cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.selectionButton.selected = YES;
    
    self.selectedIndexPath = indexPath;
    
    
    if (self.isSingleSelection) {
        if (self.selectedIndexPath && self.selectedIndexPath == indexPath) {
            cell.selectionButton.selected = YES;
        }else{
            cell.selectionButton.selected = NO;
        }
        
    } else {
        cell.selectionButton.selected = !cell.selectionButton.isSelected;
        if (cell.selectionButton.isSelected) {
            [self.selectedArray addObject:@(indexPath.row)];
        } else {
            [self.selectedArray removeObject:@(indexPath.row)];
        }
    }
    
    [self.mainTableView reloadData];
    ZLLog(@"%@",self.contentArr[indexPath.row]);
}

- (void)clearMemory{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLastSelection];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -- 懒加载
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = _title;
    }
    return _titleLabel;
    
}

- (UIView *)alertView{
    if (!_alertView) {
        
        _alertView = [[UIView alloc]init];
        _alertView.backgroundColor = [UIColor redColor];
        _alertView.layer.cornerRadius = 8;
        _alertView.layer.masksToBounds = YES;
        
    }
    return _alertView;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLAlertSelectTableViewCell class] forCellReuseIdentifier:@"ZLAlertSelectTableViewCell"];
        _mainTableView.bounces = NO;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
    }
    return _mainTableView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
        [_cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
    }
    return _cancelButton;
}
- (UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_sureButton setTitle:_sureTitle forState:(UIControlStateNormal)];
        [_sureButton setTitleColor:HEXCOLOR(CNAVGATIONBAR_COLOR) forState:(UIControlStateNormal)];
        [_sureButton addTarget:self action:@selector(sureClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
    }
    return _sureButton;
}
@end
