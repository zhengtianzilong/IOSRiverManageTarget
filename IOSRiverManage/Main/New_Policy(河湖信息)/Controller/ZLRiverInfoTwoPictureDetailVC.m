//
//  ZLRiverInfoTwoPictureDetailVC.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/6/7.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLRiverInfoTwoPictureDetailVC.h"

@interface ZLRiverInfoTwoPictureDetailVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ZLRiverInfoTwoPictureDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mainScrollView];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height / 3.0 - TopBarHeight, Main_Screen_Width, Main_Screen_Height / 3.0)];
    
    self.imageView.image = [UIImage imageNamed:self.imageString];
    
    [self.mainScrollView addSubview:self.imageView];
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imageView;
    
    
    
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    CGRect frame = self.imageView.frame;
    
    frame.origin.y = (self.mainScrollView.frame.size.height - self.imageView.frame.size.height) > 0 ? (self.mainScrollView.frame.size.height - self.imageView.frame.size.height) * 0.5 : 0;
    frame.origin.x = (self.mainScrollView.frame.size.width - self.imageView.frame.size.width) > 0 ? (self.mainScrollView.frame.size.width - self.imageView.frame.size.width) * 0.5 : 0;
    
    self.imageView.frame = frame;
    
    self.mainScrollView.contentSize = CGSizeMake(self.imageView.frame.size.width + 30, self.imageView.frame.size.height + 30);

}


- (UIScrollView *)mainScrollView{
    
    if (!_mainScrollView) {
        
        _mainScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _mainScrollView.minimumZoomScale = 0.5;
        _mainScrollView.maximumZoomScale = 10;
        _mainScrollView.delegate = self;
        
    }
    return _mainScrollView;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableAttributedString *)setTitle{
    
    NSDictionary *dic = @{NSFontAttributeName:AdaptedFontBoldSize(26),
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"两张图详情" attributes:dic];
    
    return title;
    
}

@end
