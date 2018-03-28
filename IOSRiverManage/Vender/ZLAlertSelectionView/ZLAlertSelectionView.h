//
//  ZLAlertSelectionView.h
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/11/22.
//  Copyright © 2017年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^sureClicked)(NSInteger index);

typedef void(^sureClickedMutiSelect)(NSArray *options);

@interface ZLAlertSelectionView : UIView

@property (nonatomic, strong) sureClicked selectItem;

@property (nonatomic, strong) sureClickedMutiSelect selectItemsMuti;

- (instancetype)initWithFrame:(CGRect)frame sourceArray:(NSMutableArray *)sourceArray withTitle:(NSString *)title sureTitle:(NSString *)sureTitle singleSelection:(BOOL)selection;
- (void)show;

- (void)hide;

//- (void)clearMemory;

@end
