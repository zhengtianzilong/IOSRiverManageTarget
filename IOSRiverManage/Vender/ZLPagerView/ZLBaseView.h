//
//  ZLBaseView.h
//  SmartGas
//
//  Created by caizilong on 16/6/13.
//  Copyright © 2016年 caizilong. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ZLMyScrollView.h"
@interface ZLBaseView : UIView<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) NSInteger currentPage; /**<  页码   **/
@property (strong, nonatomic) UIScrollView *topTab; /**<  顶部tab   **/
@property (strong, nonatomic) NSArray *titleArray; /**<  标题   **/
@property (assign, nonatomic) CGFloat titleScale; /**< 标题缩放比例 **/

- (instancetype)initWithFrame:(CGRect)frame WithSelectColor:(UIColor *)selectColor WithUnselectorColor:(UIColor *)unselectColor WithUnderLineColor:(UIColor *)underlineColor WithtopTabColor:(UIColor *)topTabColor WithTopTabType:(NSInteger)topTabNum;

@end
