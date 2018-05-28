//
//  ZLWanLeftAboutVC.m
//  IOSRiverManageWan
//
//  Created by 蔡紫龙 on 2018/5/25.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLWanLeftAboutVC.h"
#import "ZLLeftAboutTableViewCell.h"
@interface ZLWanLeftAboutVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;


@property (nonatomic, strong) NSArray *sourceArray;
@end

@implementation ZLWanLeftAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0xf4f4f4);
    self.automaticallyAdjustsScrollViewInsets = NO;
    _sourceArray = @[@[@"版权所有",@"中国移动通信集团江苏有限公司"],
                         @[@"技术支持",@"南京新高智联信息技术有限公司"],
                         @[@"问题反馈",@"njxgzl@singocn.com"],
                         @[@"联系人",@"刘云鹏"],
                         @[@"联系电话",@"025-58869698\n13585101674"]];
    
//    _sourceArray = @[@[@"版权所有",@"中国移动通信集团江苏有限公司"]];
    
    NSDictionary *dicInfo = [[NSBundle mainBundle]infoDictionary];
    _versionLabel.text = [NSString stringWithFormat:@"版本:%@",dicInfo[@"CFBundleShortVersionString"]];
    
    
    [_mainTableView registerNib:[UINib nibWithNibName:@"ZLLeftAboutTableViewCell" bundle:nil] forCellReuseIdentifier:@"ZLLeftAboutTableViewCell"];
    
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        if (indexPath.row == 4) {
            return 60;
        }else{
            return 44;
        }
    
    return 44;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLLeftAboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLLeftAboutTableViewCell" forIndexPath:indexPath];
    
    NSArray *tempArray = _sourceArray[indexPath.row];
    
    cell.leftLabel.text = tempArray.firstObject;
    
    cell.rightLabel.text = tempArray.lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rightLabel.numberOfLines = 0;
    cell.rightLabel.textAlignment = NSTextAlignmentRight;
    return cell;
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"关于系统" attributes:dic];
    
    return title;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
