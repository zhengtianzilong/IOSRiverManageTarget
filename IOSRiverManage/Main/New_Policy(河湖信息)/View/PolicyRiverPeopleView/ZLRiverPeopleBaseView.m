//
//  ZLRiverPeopleBaseView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/1.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverPeopleBaseView.h"
#import "ZLRiverPeoplePhoneView.h"
@interface ZLRiverPeopleBaseView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSString *headName;

@end


@implementation ZLRiverPeopleBaseView
-(instancetype)initWithFrame:(CGRect)frame WithHeadName:(NSString *)headName{
    if (self= [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _headName = headName;
        
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.nameAndEdit];
    [self addSubview:self.peopleView];
     [self addSubview:self.mainTableView];
    [self addSubview:self.lineView];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self.nameAndEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0);
        //        make.width.mas_equalTo(150);
        make.top.equalTo(self).offset(0);
        make.height.mas_equalTo(50);
        make.right.equalTo(self.mas_right);
        //        make.bottom.equalTo(self.mas_bottom);
        
    }];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.width.mas_equalTo(Main_Screen_Width);
    }];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.nameAndEdit;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLRiverPeoplePhoneView *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLRiverPeoplePhoneView" forIndexPath:indexPath];
    
    //    ZLHsNotifyListDetailModel *model = self.sourceData[indexPath.row];
    //
    //    cell.detailModel = model;
    
    return cell;
    
}



- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLRiverPeoplePhoneView class] forCellReuseIdentifier:@"ZLRiverPeoplePhoneView"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        //        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //
        //            _requestStart = 1;
        //            [self listData];
        //
        //        }];
        //
        //        _mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //            _requestStart += 1;
        //            [self listData];
        //
        //        }];
        
        
    }
    return _mainTableView;
}

- (ZLRiverPeopleNameAndEditBtnView *)nameAndEdit{
    if (!_nameAndEdit) {
        
        _nameAndEdit = [[ZLRiverPeopleNameAndEditBtnView alloc]initWithFrame:CGRectZero WithName:_headName];
    }
    return _nameAndEdit;
}


@end
