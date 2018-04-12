//
//  ZLAddressBookVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/3.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLAddressBookVC.h"
#import "ZLAddressBookTableViewCell.h"
#import "HCSortString.h"
#import "ZYPinYinSearch.h"
#import <objc/runtime.h>
#import "ZLAddressBookDetailVC.h"

#import "ZLNewAddressBookModel.h"
#import "ZLNewAddressBookService.h"

#define kColor          [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];

//@implementation Student
//
//+ (NSMutableArray *)getModelData {
//    NSMutableArray *ary = [NSMutableArray new];
//    NSArray *ary1 = @[@"张三",@"李四",@"托马斯",@"angel",@"12-谈",@"520",@"****",@"Linda",@"九寨沟",@"鼓浪屿",@"香格里拉",@"千岛湖",@"西双版纳",@"+-*/",@"故宫",@"上海科技馆",@"东方明珠",@"外滩",@"CapeTown",@"The Grand Canyon",@"4567.com",@"长江",@"长江1号",@"&*>?",@"弯弯月亮",@"that is it ?",@"山水之间",@"倩女幽魂",@"疆土无边",@"荡秋千"];
//
//    for (NSInteger index = 0; index < ary1.count;index++){
//        Student *stu = [Student new];
//        stu.name = ary1[index];
//        [ary addObject:stu];
//    }
//    return ary;
//}
//
//@end

@interface ZLAddressBookVC ()<UISearchResultsUpdating, UITableViewDelegate,UITableViewDataSource>

//@property (strong, nonatomic) Student *student;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSArray *ary;
@property (strong, nonatomic) NSMutableArray *dataSource;/**<排序前的整个数据源*/
@property (strong, nonatomic) NSDictionary *allDataSource;/**<排序后的整个数据源*/
@property (strong, nonatomic) NSMutableArray *searchDataSource;/**<搜索结果数据源*/
@property (strong, nonatomic) NSArray *indexDataSource;/**<索引数据源*/

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZLAddressBookVC


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSMutableArray array];
    
    [self getData];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ZLAddressBookTableViewCell class] forCellReuseIdentifier:@"ZLAddressBookTableViewCell"];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view);
    }];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    
    self.tableView.tableFooterView = [UIView new];
    
    //框架方法
    self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"empty_jd"
                                                            titleStr:@"暂无数据，点击重新加载"
                                                           detailStr:@""];
    //emptyView内容上的点击事件监听
    __weak typeof(self)weakSelf = self;
    [self.tableView.ly_emptyView setTapContentViewBlock:^{
        [weakSelf getData];
    }];
}

#pragma mark - -------
- (void)getData {

    [SVProgressHUD show];
    ZLNewAddressBookService *addressService = [[ZLNewAddressBookService alloc]init];
    
    [addressService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ZLNewAddressBookModel *bookModel = [[ZLNewAddressBookModel alloc]initWithString:request.responseString error:nil];
        
        if ([bookModel.code isEqualToString:@"0"]) {
            
            for (ZLNewAddressBookDataModel *dataModel in bookModel.data) {
                [_dataSource addObject:dataModel];
            }
        }
        
        _allDataSource = [HCSortString sortAndGroupForArray:_dataSource PropertyName:@"realName"];
        _indexDataSource = [HCSortString sortForStringAry:[_allDataSource allKeys]];
        _searchDataSource = [NSMutableArray new];
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
         [SVProgressHUD dismiss];
    }];
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.placeholder = @"姓名";
        _searchController.searchBar.barTintColor = HEXCOLOR(CVIEW_GRAY_COLOR);
        _searchController.searchBar.tintColor = HEXCOLOR(CNAVGATIONBAR_COLOR);
        
        UITextField *searchField = [_searchController.searchBar valueForKey:@"searchField"];
        if (searchField) {
            [searchField setBackgroundColor:[UIColor whiteColor]];
            searchField.layer.cornerRadius = 8.0f;
            searchField.layer.borderColor = HEXCOLOR(CNAVGATIONBAR_COLOR).CGColor;
            searchField.layer.borderWidth = 1;
            searchField.layer.masksToBounds = YES;
        }
        
        
//        _searchController.definesPresentationContext = YES;
        self.definesPresentationContext = YES;
        [_searchController.searchBar sizeToFit];
    }
    return _searchController;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.searchController.active) {
        return _indexDataSource.count;
    }else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.searchController.active) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[section]];
        return value.count;
    }else {
        return _searchDataSource.count;
    }
}
////头部索引标题
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (!self.searchController.active) {
//        return _indexDataSource[section];
//    }else {
//        return nil;
//    }
//}
//右侧索引列表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (!self.searchController.active) {
        return _indexDataSource;
    }else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLAddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLAddressBookTableViewCell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    ZLNewAddressBookDataModel *model;
    
    if (!self.searchController.active) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
        
       model  = value[indexPath.row];

    }else{
         model = _searchDataSource[indexPath.row];
    }
    
    cell.titleLabel.text = model.realName;
    
    cell.phoneLabel.text = model.phone;
    
    cell.detailLabel.text = model.dutyName;
    
    
//    [cell configCellWithModel:_student];
    return cell;
}
//索引点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLNewAddressBookDataModel *model;
    if (!self.searchController.active) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
        model = value[indexPath.row];
    }else{
        model = _searchDataSource[indexPath.row];
    }
    self.searchController.active = NO;
    
    ZLAddressBookDetailVC *detailVC = [[ZLAddressBookDetailVC alloc]init];
    detailVC.addressModelDataModel = model;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}

#pragma mark - UISearchDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [_searchDataSource removeAllObjects];
    NSArray *ary = [NSArray new];
    //对排序好的数据进行搜索
    ary = [HCSortString getAllValuesFromDict:_allDataSource];
    
    if (searchController.searchBar.text.length == 0) {
        [_searchDataSource addObjectsFromArray:ary];
    }else {
        ary = [ZYPinYinSearch searchWithOriginalArray:ary andSearchText:searchController.searchBar.text andSearchByPropertyName:@"realName"];
        [_searchDataSource addObjectsFromArray:ary];
    }
    [self.tableView reloadData];
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"通讯录" attributes:dic];
    
    return title;
    
}

- (void)left_button_event:(UIButton *)sender{
    
    [SVProgressHUD dismiss];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
