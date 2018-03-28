//
//  ZLMyLaunchWorkVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManagerWaitVC.h"
#import "ZLMyEventWaitCell.h"
#import "ZLMyventDealDetailVC.h"
@interface ZLEventManagerWaitVC ()

@end

@implementation ZLEventManagerWaitVC





- (void)viewDidLoad {
    [super viewDidLoad];
   
}
- (void)setCell{
    
    [self.mainTableView registerClass:[ZLMyEventWaitCell class] forCellReuseIdentifier:@"ZLMyEventWaitCell"];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLMyEventWaitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyEventWaitCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof(self) weakSelf = self;
    
    cell.dealClick = ^{
        ZLMyventDealDetailVC *vc = [[ZLMyventDealDetailVC alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    
    //    ZLFlotillaReportModel *model = self.sourceData[indexPath.section];
    //
    //    cell.flotillaModel = model;
    
    return cell;
    
    
}

@end
