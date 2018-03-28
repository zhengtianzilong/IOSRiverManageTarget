//
//  ZLMyVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/2/27.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLMyVC.h"
#import "ZLMyHeadView.h"
#import "ZLMyTableViewCell.h"
#import "ZLFAQVC.h"
#import "ZLMySetupVC.h"
#import "ZLLeftAboutViewController.h"
#import "ZLNewLoginModel.h"
@interface ZLMyVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) ZLMyHeadView *headView;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *contentArr;

@property (nonatomic, strong) YTKKeyValueStore *store;
@end

@implementation ZLMyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //头部view的加入和设置
    self.headView=[[ZLMyHeadView alloc]init];
    self.headView.backgroundColor= HEXCOLOR(CNAVGATIONBAR_COLOR);
    [self.view addSubview:self.headView];
    
    self.store = [[YTKKeyValueStore alloc]initDBWithName:@"hzz.db"];
    
    NSString *tableName = DBUserTable;
    
    [self.store createTableWithName:tableName];
    NSString *userModel = [self.store getStringById:DBLoginModel fromTable:DBUserTable];
    
    ZLNewLoginModel *newLoginModel = [[ZLNewLoginModel alloc]initWithString:userModel error:nil];
    
    self.headView.nameLabel.text = newLoginModel.data.userName;
    self.headView.identityLabel.text = newLoginModel.data.duty;
    self.contentArr = @[@{@"content":@"常见问题",@"image":@"my_question"},@{@"content":@"关于系统",@"image":@"my_about"},@{@"content":@"系统设置",@"image":@"my_set"}];
    
    [self.view addSubview:self.mainTableView];
    
    
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.height.mas_equalTo(AdaptedHeight(190));
        make.width.mas_equalTo(Main_Screen_Width);
        make.top.equalTo(self.view);
    }];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.height.mas_equalTo(self.contentArr.count * 55);
        make.width.mas_equalTo(Main_Screen_Width);
        make.top.equalTo(self.headView.mas_bottom);
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
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.contentArr[indexPath.row];
    static NSString *CellIdentifier = @"ZLMyTableViewCell";
    ZLMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.icon.image = [UIImage imageNamed:dic[@"image"]];
    cell.contentLabel.text = dic[@"content"];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZLLog(@"%@",self.contentArr[indexPath.row][@"content"]);
    
    if ([self.contentArr[indexPath.row][@"content"] isEqualToString:@"常见问题"]) {
        ZLFAQVC *vc=[[ZLFAQVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
    if ([self.contentArr[indexPath.row][@"content"] isEqualToString:@"关于系统"]) {
        ZLLeftAboutViewController *vc=[[ZLLeftAboutViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
    if ([self.contentArr[indexPath.row][@"content"] isEqualToString:@"系统设置"]) {
        
        //a) 获取故事板
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ZLMySetupVC" bundle:nil];
        
        
        //b) 将故事板中的视图覆盖导航视图(方法一)
        ZLMySetupVC *vc = (ZLMySetupVC *)[storyboard instantiateViewControllerWithIdentifier:@"ZLMySetupVC"];
        
        //        ZLMeSetupViewController *vc=[[ZLMeSetupViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        [_mainTableView registerClass:[ZLMyTableViewCell class] forCellReuseIdentifier:@"ZLMyTableViewCell"];
        _mainTableView.bounces = NO;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
    }
    return _mainTableView;
}


- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"我的" attributes:dic];
    
    return title;
    
}

- (UIButton *)set_leftButton{
    return  nil;
}

@end
