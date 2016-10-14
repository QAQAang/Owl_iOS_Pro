//
//  NewFeatureViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 2016/10/9.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "UIView+YPFrameExtension.h"
#import "RootTabBarViewController.h"

@interface NewFeatureViewController () <UIScrollViewDelegate>
@property (nonatomic, copy)NSMutableArray *imageArray;
@end

@implementation NewFeatureViewController

- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithObjects:@"引导页-发布", @"引导页-分享", @"引导页-安全", nil];
    }
    return _imageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ViewBacgroundColor;
    
    [self createScrollView];
}

- (void)createScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, HEIGHTS)];
    scrollView.contentSize = CGSizeMake(self.imageArray.count * WIDTHS, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.alwaysBounceHorizontal = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    for (NSInteger i = 0; i < self.imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * WIDTHS, 0, WIDTHS, HEIGHTS)];
        imageView.image = [UIImage imageNamed:self.imageArray[i]];
        if (i == self.imageArray.count - 1) {
            imageView.userInteractionEnabled = YES;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 541 * HEIGHTMAKE, 130 * WIDTHMAKE, 35 * HEIGHTMAKE);
            btn.centerX = self.view.centerX;
            [btn addTarget:self action:@selector(InMainViewClick) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:btn];
        }
        [scrollView addSubview:imageView];
    }
    [self.view addSubview:scrollView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGPoint offset = scrollView.contentOffset;
//    NSInteger index = offset.x / WIDTHS;
    
}

- (void)InMainViewClick
{
    RootTabBarViewController *rootVc = [[RootTabBarViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = rootVc;
}

@end
