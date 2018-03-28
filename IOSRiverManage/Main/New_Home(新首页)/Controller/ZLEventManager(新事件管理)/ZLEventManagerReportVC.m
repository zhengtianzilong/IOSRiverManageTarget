//
//  ZLMyWaitWorkVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/2.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLEventManagerReportVC.h"
#import "ZLQueryOnlyTimeView.h"
#import "ZLMyEventCell.h"
#import "ZLMyEventDetailVC.h"
#import "ZLNewChangeEventReportVC.h"
@interface ZLEventManagerReportVC ()
@end

@implementation ZLEventManagerReportVC

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLMyEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLMyEventCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof(self) weakSelf = self;
    
    cell.changeClick = ^{
    
        ZLNewChangeEventReportVC *changeVC = [[ZLNewChangeEventReportVC alloc]init];
        [weakSelf.navigationController pushViewController:changeVC animated:YES];
        
        
    };
    return cell;
}


@end
