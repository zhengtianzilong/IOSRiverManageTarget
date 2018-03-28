//
//  ZLRiverSelectView.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/20.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import "ZLRiverSelectView.h"

@interface ZLRiverSelectView ()<UITableViewDelegate,UITableViewDataSource>



@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *titles;

@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation ZLRiverSelectView


- (instancetype)initWithFrame:(CGRect)frame titles:(NSMutableArray *)modelArray importOrNomal:(NSString *)importOrNomal{
    
    if (self = [super initWithFrame:frame]) {
        _modelArray = modelArray;
        _titles = [NSMutableArray array];
        if (modelArray.count > 0) {
            
            for (ZLRiverDemandModel *model in modelArray) {
                
                [_titles addObject:model.rivers_name];
                
            }
            
        }
        
        _importOrNormal = importOrNomal;
        
        if ([_importOrNormal isEqualToString:@"1"] && ![_titles containsObject:@"清除所有选项"]) {
            
            [_titles insertObject:@"清除所有选项" atIndex:0];
            ZLRiverDemandModel *model = [[ZLRiverDemandModel alloc]init];
            model.rivers_name = @"清除所有选项";
            
            [_modelArray insertObject:model atIndex:0];
            
        }
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.3;
        [self addSubview:_maskView];
        [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            
        }];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = YES;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView.layer.cornerRadius = 5;
        _tableView.clipsToBounds = YES;
        
        [self addSubview:_tableView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(AdaptedWidth(30));
            make.right.equalTo(self.mas_right).offset(AdaptedWidth(-30));
            make.top.equalTo(self).offset(AdaptedWidth(30));
            make.height.mas_equalTo(_titles.count * 44);
        }];
    }
    return self;
    
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    cell.textLabel.text = _titles[indexPath.row];
    
    if ([cell.textLabel.text isEqualToString:@"清除所有选项"]) {
        
        cell.textLabel.textColor = HEXCOLOR(KNavBarBG_color_blue);
        
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    
    cell.backgroundColor = [UIColor whiteColor];
    
//    if (indexPath.row == _seletedIndex) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }else{
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if ([_importOrNormal isEqualToString:@"1"] && ![_modelArray containsObject:@"清除所有选项"]) {
//        
//
//        
//    }
    
    
    if (_selectedTitleBlock) {
        
        _selectedTitleBlock(_modelArray[indexPath.row]);
        
    }
    
//
//    self.selectedAtIndex(indexPath.row);
//    
//    _seletedIndex = indexPath.row;
}



//- (UITableView *)tableView
//{
//    if (!_tableView) {
//        
//        
//        
//        
//        
//    }
//    return _tableView;
//}

//- (UIView *)maskView{
//    if (!_maskView) {
//        
//
//        
//
//    }
//    return _maskView;
//}




@end
